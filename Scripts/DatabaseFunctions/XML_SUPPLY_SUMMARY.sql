-- Function: "WADE_R"."XML_SUPPLY_SUMMARY"(text, text, text)

-- DROP FUNCTION "WADE_R"."XML_SUPPLY_SUMMARY"(text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_SUPPLY_SUMMARY"(
    IN orgid text,
    IN reportid text,
    IN reportunitid text,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$

BEGIN

tmp_output:=(SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:DerivedWaterSupplyType",
			(XMLELEMENT
				(name "WC:WFSReference",
					(SELECT XMLFOREST
						("WFS_FEATURE_REF" AS "WC:WFSFeatureIdentifier")
			)	)	),
			(SELECT XMLFOREST
				("VALUE" AS "WC:WaterSupplyTypeName")
			),
			(SELECT "WADE_R"."XML_S_WATER_SUPPLY_AMOUNT"
				(orgid, reportid, reportunitid, "SUMMARY_SEQ")
			)
		)::text,''
	)

	FROM  

	"WADE"."SUMMARY_WATER_SUPPLY" A LEFT OUTER JOIN "WADE"."LU_WATER_SUPPLY_TYPE" B ON (A."WATER_SUPPLY_TYPE"=B."LU_SEQ_NO")

	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "REPORT_UNIT_ID"=reportunitid);

	

If tmp_output IS NULL THEN

ELSE

	tmp_output :='<WC:DerivedWaterSupplySummary>' || tmp_output || '</WC:DerivedWaterSupplySummary>';

END IF;

	RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_SUPPLY_SUMMARY"(text, text, text)
  OWNER TO "WADE";
