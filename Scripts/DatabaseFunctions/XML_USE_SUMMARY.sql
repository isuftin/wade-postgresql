-- Function: "WADE_R"."XML_USE_SUMMARY"(text, text, text)

-- DROP FUNCTION "WADE_R"."XML_USE_SUMMARY"(text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_USE_SUMMARY"(
    IN orgid text,
    IN reportid text,
    IN reportunitid text,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$

BEGIN

tmp_output:=(SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:WaterUse",
			(XMLELEMENT
				(name "WC:WFSReference",
					(SELECT XMLFOREST
						("WFS_FEATURE_REF" AS "WC:WFSFeatureIdentifier")
					)	
				)	
			),
			(SELECT XMLFOREST
				(B."CONTEXT" AS "WC:WaterUseContext",
				B."VALUE" AS "WC:WaterUseTypeName")
			),
			XMLELEMENT(name "WC:WaterUseAmountSummary",
				(SELECT XMLFOREST
					(C."VALUE" AS "WC:FreshSalineIndicator",
					 D."VALUE" AS "WC:SourceTypeName",
					 "POWER_GENERATED" AS "WC:PowerGeneratedNumber",
					 "POPULATION_SERVED" AS "WC:PopulationServedNumber")
				),
			(SELECT "WADE_R"."XML_S_USE_IRRIGATION"
				(orgid, reportid, reportunitid, "SUMMARY_SEQ", "BENEFICIAL_USE_ID")
			),
			(SELECT "WADE_R"."XML_S_USE_AMOUNT"
				(orgid, reportid, reportunitid, "SUMMARY_SEQ", "BENEFICIAL_USE_ID")
			)
				)
		)::text,''
	)

	FROM  

	"WADE"."SUMMARY_USE" A LEFT OUTER JOIN "WADE"."LU_BENEFICIAL_USE" B ON (A."BENEFICIAL_USE_ID"=B."LU_SEQ_NO") 
	LEFT OUTER JOIN "WADE"."LU_FRESH_SALINE_INDICATOR" C ON (A."FRESH_SALINE_IND"=C."LU_SEQ_NO")
	LEFT OUTER JOIN "WADE"."LU_SOURCE_TYPE" D ON (A."SOURCE_TYPE"=D."LU_SEQ_NO")

	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "REPORT_UNIT_ID"=reportunitid);



If tmp_output IS NULL THEN

ELSE

	tmp_output :='<WC:WaterUseSummary>' || tmp_output || '</WC:WaterUseSummary>';

END IF;

	RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_USE_SUMMARY"(text, text, text)
  OWNER TO "WADE";
