-- Function: "WADE_R"."DataTypeCatalog"(text, text, text, text, text)

-- DROP FUNCTION "WADE_R"."DataTypeCatalog"(text, text, text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."DataTypeCatalog"(
    IN orgid text,
    IN reportid text,
    IN datacategory text,
    IN loctype text,
    IN loctxt text,
    OUT text_output xml)
  RETURNS xml AS
$BODY$



BEGIN

IF loctype='HUC' THEN

text_output:= (SELECT STRING_AGG(
	(SELECT XMLFOREST("DATATYPE" AS "WC:DataType"
	--		 ,"NUMOFALLOCATIONS" AS "WC:RecordsNumber"
	))::text,'')

		FROM  

		(SELECT "DATATYPE" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE B."ORGANIZATION_ID"=orgid AND B."REPORT_ID"=reportid AND "DATACATEGORY"=datacategory AND B."HUC"=loctxt

		GROUP BY "DATATYPE") AS TEMP);

END IF;

IF loctype='COUNTY' THEN

		text_output:= (SELECT STRING_AGG((SELECT XMLFOREST("DATATYPE" AS "WC:DataType"))::text,'')

		FROM  

		(SELECT "DATATYPE" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE B."ORGANIZATION_ID"=orgid AND B."REPORT_ID"=reportid AND "DATACATEGORY"=datacategory AND B."COUNTY_FIPS"=loctxt

		GROUP BY "DATATYPE") AS TEMP);

END IF;

IF loctype='REPORTUNIT' THEN

		text_output:= (SELECT STRING_AGG((SELECT XMLFOREST("DATATYPE" AS "WC:DataType"))::text,'')

		FROM  

		(SELECT "DATATYPE" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE B."ORGANIZATION_ID"=orgid AND B."REPORT_ID"=reportid AND "DATACATEGORY"=datacategory AND B."REPORT_UNIT_ID"=loctxt

		GROUP BY "DATATYPE") AS TEMP);

END IF;

	

RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."DataTypeCatalog"(text, text, text, text, text)
  OWNER TO "WADE";
