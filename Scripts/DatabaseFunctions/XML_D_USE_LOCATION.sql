-- Function: "WADE_R"."XML_D_USE_LOCATION"(text, text, text, text)

-- DROP FUNCTION "WADE_R"."XML_D_USE_LOCATION"(text, text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_D_USE_LOCATION"(
    IN orgid text,
    IN reportid text,
    IN allocationid text,
    IN wateruserid text,
    OUT text_output xml)
  RETURNS xml AS
$BODY$



BEGIN


	
text_output := (SELECT STRING_AGG
	(XMLELEMENT
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
		)::text,''
	)
	
	FROM
	"WADE"."D_USE_LOCATION" A LEFT OUTER JOIN "WADE"."LU_STATE" B ON (A."STATE"=B."LU_SEQ_NO") 
	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "ALLOCATION_ID"=allocationid AND "WATER_USER_ID"=wateruserid
	);

RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_D_USE_LOCATION"(text, text, text, text)
  OWNER TO "WADE";
