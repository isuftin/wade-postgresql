-- Function: "WADE_R"."LocationCatalog"(text, text, text, text)

-- DROP FUNCTION "WADE_R"."LocationCatalog"(text, text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."LocationCatalog"(
    IN orgid text,
    IN reportid text,
    IN loctype text,
    IN loctxt text,
    OUT text_output xml)
  RETURNS xml AS
$BODY$



BEGIN

IF loctype='HUC' THEN
text_output:= (SELECT STRING_AGG(
	XMLELEMENT(name "WC:Location",
	(SELECT XMLFOREST('HUC' AS "WC:LocationType", 
	"HUC" AS "WC:LocationText")), 
	(SELECT "WADE_R"."DataCatalog"(orgid,reportid,loctype,loctxt)))::text,'')

	FROM 

	(SELECT "HUC" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE B."ORGANIZATION_ID"=orgid AND B."REPORT_ID"=reportid AND B."HUC"=loctxt
	GROUP BY "HUC") AS TEMP);

END IF;

IF loctype='COUNTY' THEN

		text_output:= (SELECT STRING_AGG(

		XMLELEMENT(name "WC:Location",(SELECT XMLFOREST('COUNTY' AS "WC:LocationType", 

		"COUNTY_FIPS" AS "WC:LocationText")), 

		(SELECT "WADE_R"."DataCatalog"(orgid,reportid,loctype,loctxt)))::text,'')

		FROM 

		(SELECT "COUNTY_FIPS" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE B."ORGANIZATION_ID"=orgid AND B."REPORT_ID"=reportid AND B."COUNTY_FIPS"=loctxt

		GROUP BY "COUNTY_FIPS") AS TEMP);

END IF;

IF loctype='REPORTUNIT' THEN

		text_output:= (SELECT STRING_AGG(

		XMLELEMENT(name "WC:Location",(SELECT XMLFOREST('REPORTUNIT' AS "WC:LocationType", 

		"REPORT_UNIT_ID" AS "WC:LocationText")), 

		(SELECT "WADE_R"."DataCatalog"(orgid,reportid,loctype,loctxt)))::text,'')

		FROM 

		(SELECT "REPORT_UNIT_ID" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE B."ORGANIZATION_ID"=orgid AND B."REPORT_ID"=reportid AND B."REPORT_UNIT_ID"=loctxt

		GROUP BY "REPORT_UNIT_ID") AS TEMP);

END IF;

	

RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."LocationCatalog"(text, text, text, text)
  OWNER TO "WADE";
