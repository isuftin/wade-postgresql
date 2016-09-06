-- Function: "WADE_R"."XML_REGULATORY_SUMMARY"(text, text, text)

-- DROP FUNCTION "WADE_R"."XML_REGULATORY_SUMMARY"(text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_REGULATORY_SUMMARY"(
    IN orgid text,
    IN reportid text,
    IN reportunitid text,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$



BEGIN







tmp_output:=(SELECT STRING_AGG
		(XMLELEMENT
			(name "WC:RegulatoryType",
				(XMLELEMENT
					(name "WC:WFSReference",
						(SELECT XMLFOREST
							("WFS_FEATURE_REF" AS "WC:WFSFeatureIdentifier")
				)	)	),
				(SELECT XMLFOREST
					("REGULATORY_TYPE" AS "WC:RegulatoryTypeName", 
					"VALUE" as "WC:RegulatoryStatusText",
					"OVERSIGHT_AGENCY" AS "WC:OversightAgencyName",
					"REGULATORY_DESCRIPTION" AS "WC:RegulatoryDescriptionText")
				)
			)::text,''
		)

	FROM  

	"WADE"."SUMMARY_REGULATORY" A LEFT OUTER JOIN "WADE"."LU_REGULATORY_STATUS" B ON (A."REGULATORY_STATUS"=B."LU_SEQ_NO") 
	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "REPORT_UNIT_ID"=reportunitid);

	

If tmp_output IS NULL THEN

ELSE

	tmp_output :='<WC:RegulatorySummary>' || tmp_output || '</WC:RegulatorySummary>';

END IF;

	RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_REGULATORY_SUMMARY"(text, text, text)
  OWNER TO "WADE";
