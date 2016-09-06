-- Function: "WADE_R"."ReportCatalog"(text, text, text)

-- DROP FUNCTION "WADE_R"."ReportCatalog"(text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."ReportCatalog"(
    IN orgid text,
    IN loctype text,
    IN loctxt text,
    OUT text_output xml)
  RETURNS xml AS
$BODY$



BEGIN

IF loctype='HUC' THEN

text_output:= (SELECT STRING_AGG(
	XMLELEMENT(name "WC:Report",
	XMLCONCAT((SELECT XMLFOREST("REPORT_ID" AS "WC:ReportIdentifier", 
		"REPORTING_DATE" AS "WC:ReportingDate", 
		"REPORTING_YEAR" AS "WC:ReportingYear", 
		"REPORT_NAME" AS "WC:ReportName", 
		"REPORT_LINK" AS "WC:ReportLink", 
		"YEAR_TYPE" AS "WC:YearType")), 
		(SELECT "WADE_R"."LocationCatalog"(orgid,A."REPORT_ID",loctype,loctxt))))::text,'')

		FROM 

		"WADE"."REPORT" A WHERE "ORGANIZATION_ID"=orgid AND EXISTS(SELECT B."ORGANIZATION_ID", B."REPORT_ID" FROM
		"WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND A."REPORT_ID"=B."REPORT_ID" AND B."HUC"=loctxt));

END IF;

IF loctype='COUNTY' THEN

		text_output:= (SELECT STRING_AGG(

		XMLELEMENT(name "WC:Report",XMLCONCAT((SELECT XMLFOREST("REPORT_ID" AS "WC:ReportIdentifier", 

		
		"REPORTING_DATE" AS "WC:ReportingDate", "REPORTING_YEAR" AS "WC:ReportingYear", "REPORT_NAME" AS "WC:ReportName", 
		"REPORT_LINK" AS "WC:ReportLink", "YEAR_TYPE" AS "WC:YearType")), 

		(SELECT "WADE_R"."LocationCatalog"(orgid,A."REPORT_ID",loctype,loctxt))))::text,'')

		FROM 

		"WADE"."REPORT" A WHERE "ORGANIZATION_ID"=orgid AND EXISTS(SELECT B."ORGANIZATION_ID", B."REPORT_ID" FROM

		"WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND A."REPORT_ID"=B."REPORT_ID" AND B."COUNTY_FIPS"=loctxt));

END IF;

IF loctype='REPORTUNIT' THEN

		text_output:= (SELECT STRING_AGG(

		XMLELEMENT(name "WC:Report",XMLCONCAT((SELECT XMLFOREST("REPORT_ID" AS "WC:ReportIdentifier", 

		
		"REPORTING_DATE" AS "WC:ReportingDate", "REPORTING_YEAR" AS "WC:ReportingYear", "REPORT_NAME" AS "WC:ReportName", 
		"REPORT_LINK" AS "WC:ReportLink", "YEAR_TYPE" AS "WC:YearType")), 

		(SELECT "WADE_R"."LocationCatalog"(orgid,A."REPORT_ID",loctype,loctxt))))::text,'')

		FROM 

		"WADE"."REPORT" A WHERE "ORGANIZATION_ID"=orgid AND EXISTS(SELECT B."ORGANIZATION_ID", B."REPORT_ID" FROM

		"WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND A."REPORT_ID"=B."REPORT_ID" AND B."REPORT_UNIT_ID"=loctxt));

END IF;

	

RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."ReportCatalog"(text, text, text)
  OWNER TO "WADE";
