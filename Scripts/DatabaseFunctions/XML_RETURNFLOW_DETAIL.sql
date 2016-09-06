-- Function: "WADE_R"."XML_RETURNFLOW_DETAIL"(text, text, text)

-- DROP FUNCTION "WADE_R"."XML_RETURNFLOW_DETAIL"(text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_RETURNFLOW_DETAIL"(
    IN orgid text,
    IN reportid text,
    IN allocationid text,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$



BEGIN



tmp_output := (SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:ReturnFlow", 
		XMLCONCAT((SELECT XMLFOREST
				("RETURN_FLOW_ID" AS "WC:ReturnFlowIdentifier",
				"RETURN_FLOW_NAME" AS "WC:ReturnFlowName")
			), 
			XMLELEMENT
				(name "WC:DetailLocation", 
					(SELECT XMLFOREST
						(B."VALUE" AS "WC:StateCode", 
						"REPORTING_UNIT_ID" AS "WC:ReportingUnitIdentifier",
						"COUNTY_FIPS" AS "WC:CountyFipsCode",
						"HUC" AS "WC:HydrologicUnitCode")
					),
					XMLELEMENT
						(name "WC:WFSReference",
							(SELECT XMLFOREST
								("WFS_FEATURE_REF" AS "WC:WFSFeatureIdentifier")
							)
						)
				),
				(SELECT "WADE_R"."XML_D_RETURN_FLOW_ACTUAL"
					(orgid, reportid, allocationid, "RETURN_FLOW_ID")
				)
			)
		)::text,''
	) 

	FROM "WADE"."DETAIL_RETURN_FLOW" A 
	LEFT OUTER JOIN "WADE"."LU_STATE" B ON (A."STATE"=B."LU_SEQ_NO")

	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "ALLOCATION_ID"=allocationid);



	RETURN;

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_RETURNFLOW_DETAIL"(text, text, text)
  OWNER TO "WADE";
