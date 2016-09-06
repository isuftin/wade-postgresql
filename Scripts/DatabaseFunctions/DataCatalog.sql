-- Function: "WADE_R"."DataCatalog"(text, text, text, text)

-- DROP FUNCTION "WADE_R"."DataCatalog"(text, text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."DataCatalog"(
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

		XMLELEMENT(name "WC:DataAvailable",
		(SELECT XMLFOREST("DATACATEGORY" AS "WC:DataCategory")), 
		XMLELEMENT(name "WC:DataTypes", 
		(SELECT "WADE_R"."DataTypeCatalog"(orgid,reportid,"DATACATEGORY",loctype,loctxt))))::text,'')
		FROM 
		(SELECT "DATACATEGORY" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE B."ORGANIZATION_ID"=orgid AND B."REPORT_ID"=reportid AND B."HUC"=loctxt
		GROUP BY "DATACATEGORY") AS TEMP);

END IF;

IF loctype='COUNTY' THEN

		text_output:= (SELECT STRING_AGG(		

		XMLELEMENT(name "WC:DataAvailable",(SELECT XMLFOREST("DATACATEGORY" AS "WC:DataCategory")), XMLELEMENT(name "WC:DataTypes", 

		(SELECT "WADE_R"."DataTypeCatalog"(orgid,reportid,"DATACATEGORY",loctype,loctxt))))::text,'')

		FROM 

		(SELECT "DATACATEGORY" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE B."ORGANIZATION_ID"=orgid AND B."REPORT_ID"=reportid AND B."COUNTY_FIPS"=loctxt

		GROUP BY "DATACATEGORY") AS TEMP);

END IF;

IF loctype='REPORTUNIT' THEN

		text_output:= (SELECT STRING_AGG(		

		XMLELEMENT(name "WC:DataAvailable",(SELECT XMLFOREST("DATACATEGORY" AS "WC:DataCategory")), XMLELEMENT(name "WC:DataTypes", 

		(SELECT "WADE_R"."DataTypeCatalog"(orgid,reportid,"DATACATEGORY",loctype,loctxt))))::text,'')

		FROM

		(SELECT "DATACATEGORY" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE B."ORGANIZATION_ID"=orgid AND B."REPORT_ID"=reportid AND B."REPORT_UNIT_ID"=loctxt

		GROUP BY "DATACATEGORY") AS TEMP);

END IF;

	

RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."DataCatalog"(text, text, text, text)
  OWNER TO "WADE";
