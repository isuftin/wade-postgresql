-- Function: "WADE_R"."ReportSummary"(text, text, text, text, text)

-- DROP FUNCTION "WADE_R"."ReportSummary"(text, text, text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."ReportSummary"(
    IN orgid text,
    IN reportid text,
    IN loctype text,
    IN loctxt text,
    IN datatype text,
    OUT text_output xml)
  RETURNS xml AS
$BODY$



BEGIN

text_output:= (SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:Report",
		XMLCONCAT(
			(SELECT XMLFOREST
				("REPORT_ID" AS "WC:ReportIdentifier", 
				"REPORTING_DATE" AS "WC:ReportingDate",
				"REPORTING_YEAR" AS "WC:ReportingYear", 
				"REPORT_NAME" AS "WC:ReportName", 
				"REPORT_LINK" AS "WC:ReportLink",
				"YEAR_TYPE" AS "WC:YearType")
			), 
			(SELECT "WADE_R"."GeospatialRefSummary"
				(orgid,reportid,datatype)
			),
			(SELECT "WADE_R"."ReportUnitSummary"
				(orgid,reportid,loctype,loctxt,datatype)
			)
			)
		)::text,''
	)

	FROM 

	"WADE"."REPORT" A WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid);

	

RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."ReportSummary"(text, text, text, text, text)
  OWNER TO "WADE";
