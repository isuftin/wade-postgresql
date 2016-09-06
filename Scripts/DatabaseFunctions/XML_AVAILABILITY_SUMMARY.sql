-- Function: "WADE_R"."XML_AVAILABILITY_SUMMARY"(text, text, text)

-- DROP FUNCTION "WADE_R"."XML_AVAILABILITY_SUMMARY"(text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_AVAILABILITY_SUMMARY"(
    IN orgid text,
    IN reportid text,
    IN reportunitid text,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$

BEGIN

tmp_output:=(SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:AvailabilitySummary",
			(XMLELEMENT
					(name "WC:WFSReference",
						(SELECT XMLFOREST
							("WFS_FEATURE_REF" AS "WC:WFSFeatureIdentifier")
				)	)	),
			(SELECT XMLFOREST
				("AVAILABILITY_TYPE" AS "WC:AvailabilityTypeName", 
				B."VALUE" as "WC:FreshSalineIndicator", 
				C."VALUE" AS "WC:SourceTypeName")
			),
			XMLELEMENT
				(name "WC:AvailabilityEstimate",
					(SELECT "WADE_R"."XML_S_AVAILABILITY_AMOUNT"
						(orgid, reportid, reportunitid, "SUMMARY_SEQ")
					),
					(SELECT "WADE_R"."XML_S_AVAILABILITY_METRIC"
						(orgid, reportid, reportunitid, "SUMMARY_SEQ")
					)
				)
		)::text,''
	)

	FROM  

	"WADE"."SUMMARY_AVAILABILITY" A LEFT OUTER JOIN "WADE"."LU_FRESH_SALINE_INDICATOR" B ON (A."FRESH_SALINE_IND"=B."LU_SEQ_NO")
	LEFT JOIN "WADE"."LU_SOURCE_TYPE" C ON (A."SOURCE_TYPE"=C."LU_SEQ_NO")

	WHERE 

	"ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "REPORT_UNIT_ID"=reportunitid

	);

	RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_AVAILABILITY_SUMMARY"(text, text, text)
  OWNER TO "WADE";
