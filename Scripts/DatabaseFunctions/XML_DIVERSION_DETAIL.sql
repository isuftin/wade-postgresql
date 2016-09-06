-- Function: "WADE_R"."XML_DIVERSION_DETAIL"(text, text, text)

-- DROP FUNCTION "WADE_R"."XML_DIVERSION_DETAIL"(text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_DIVERSION_DETAIL"(
    IN orgid text,
    IN reportid text,
    IN allocationid text,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$



BEGIN



tmp_output := (SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:Diversion", 
		XMLCONCAT((SELECT XMLFOREST
				("DIVERSION_ID" AS "WC:DiversionIdentifier",
				 "DIVERSION_NAME" AS "WC:DiversionName")
			), 
			XMLELEMENT
				(name "WC:DetailLocation", 
					(SELECT XMLFOREST
						(F."VALUE" AS "WC:StateCode", 
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
				(SELECT "WADE_R"."DIVERSION_AMOUNT"
					(orgid,reportid,allocationid,"DIVERSION_ID")
				)
			)
		)::text,''
	) 

	FROM "WADE"."DETAIL_DIVERSION" A LEFT OUTER JOIN "WADE"."LU_STATE" F ON (A."STATE"=F."LU_SEQ_NO") 

	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "ALLOCATION_ID" = allocationid);


	RETURN;

END



  $BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_DIVERSION_DETAIL"(text, text, text)
  OWNER TO "WADE";
