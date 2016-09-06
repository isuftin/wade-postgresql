-- Function: "WADE_R"."ReportDetail"(text, text, text, text, text)

-- DROP FUNCTION "WADE_R"."ReportDetail"(text, text, text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."ReportDetail"(
    IN orgid text,
    IN reportid text,
    IN loctype text,
    IN loctxt text,
    IN datatype text,
    OUT text_output xml)
  RETURNS xml AS
$BODY$



BEGIN

IF datatype <> 'ALL' THEN

	IF loctype='HUC' THEN

		text_output:= (SELECT STRING_AGG(

		XMLELEMENT(name "WC:Report", XMLCONCAT((SELECT XMLFOREST("REPORT_ID" AS "WC:ReportIdentifier", 
		"REPORTING_DATE" AS "WC:ReportingDate", 
		"REPORTING_YEAR" AS "WC:ReportingYear", 
		"REPORT_NAME" AS "WC:ReportName", 
		"REPORT_LINK" AS "WC:ReportLink", 
		"YEAR_TYPE" AS "WC:YearType")),
		(SELECT "WADE_R"."GeospatialRefDetail"(orgid,"REPORT_ID",datatype)),
		(SELECT "WADE_R"."XML_ALLOCATION_DETAIL"(orgid,"REPORT_ID",loctype,loctxt,datatype))))::text,'')
		FROM 
		"WADE"."REPORT" A WHERE EXISTS(SELECT DISTINCT "ORGANIZATION_ID" FROM "WADE_R"."DETAIL_LOCATION_MV" B WHERE 
		A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND A."REPORT_ID"=reportid AND B."ORGANIZATION_ID"=orgid AND "HUC" LIKE loctxt||'%' AND "DATATYPE"=datatype));

	END IF;

	IF loctype='COUNTY' THEN

		text_output:= (SELECT STRING_AGG(

		XMLELEMENT(name "WC:Report",XMLCONCAT((SELECT XMLFOREST("REPORT_ID" AS "WC:ReportIdentifier", 

		"REPORTING_DATE" AS "WC:ReportingDate", "REPORTING_YEAR" AS "WC:ReportingYear", "REPORT_NAME" AS "WC:ReportName", 
		"REPORT_LINK" AS "WC:ReportLink", "YEAR_TYPE" AS "WC:YearType")), 
		(SELECT "WADE_R"."GeospatialRefDetail"(orgid,"REPORT_ID",datatype)),
		(SELECT "WADE_R"."XML_ALLOCATION_DETAIL"(orgid,"REPORT_ID",loctype,loctxt,datatype))))::text,'')

		FROM 

		"WADE"."REPORT" A WHERE EXISTS(SELECT DISTINCT "ORGANIZATION_ID" FROM "WADE_R"."DETAIL_LOCATION_MV" B WHERE 

		A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND A."REPORT_ID"=reportid AND B."ORGANIZATION_ID"=orgid AND "COUNTY_FIPS"=loctxt AND "DATATYPE"=datatype));

	END IF;



IF loctype='REPORTUNIT' THEN

	text_output:= (SELECT STRING_AGG(

		XMLELEMENT(name "WC:Report",XMLCONCAT((SELECT XMLFOREST("REPORT_ID" AS "WC:ReportIdentifier", 

		"REPORTING_DATE" AS "WC:ReportingDate", "REPORTING_YEAR" AS "WC:ReportingYear", "REPORT_NAME" AS "WC:ReportName", 
		"REPORT_LINK" AS "WC:ReportLink", "YEAR_TYPE" AS "WC:YearType")),  
		(SELECT "WADE_R"."GeospatialRefDetail"(orgid,"REPORT_ID",datatype)),
		(SELECT "WADE_R"."XML_ALLOCATION_DETAIL"(orgid,"REPORT_ID",loctype,loctxt,datatype))))::text,'')

		FROM 

		"WADE"."REPORT" A WHERE EXISTS(SELECT DISTINCT "ORGANIZATION_ID" FROM "WADE_R"."DETAIL_LOCATION_MV" B WHERE 

		A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND A."REPORT_ID"=reportid AND B."ORGANIZATION_ID"=orgid AND "REPORTING_UNIT_ID"=loctxt AND "DATATYPE"=datatype));

	END IF;



ELSE

IF loctype='HUC' THEN

		text_output:= (SELECT STRING_AGG(
		XMLELEMENT(name "WC:Report",
		XMLCONCAT((SELECT XMLFOREST("REPORT_ID" AS "WC:ReportIdentifier", 
		"REPORTING_DATE" AS "WC:ReportingDate", 
		"REPORTING_YEAR" AS "WC:ReportingYear", 
		"REPORT_NAME" AS "WC:ReportName", 
		"REPORT_LINK" AS "WC:ReportLink", 
		"YEAR_TYPE" AS "WC:YearType")),  
		(SELECT "WADE_R"."GeospatialRefDetail"(orgid,"REPORT_ID",datatype)),
		(SELECT "WADE_R"."XML_ALLOCATION_DETAIL"(orgid,"REPORT_ID",loctype,loctxt,datatype))))::text,'')
		FROM 
		"WADE"."REPORT" A WHERE EXISTS(SELECT DISTINCT "ORGANIZATION_ID" FROM "WADE_R"."DETAIL_LOCATION_MV" B WHERE 
		A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND A."REPORT_ID"=reportid AND B."ORGANIZATION_ID"=orgid AND "HUC" LIKE loctxt||'%'));

	END IF;



	IF loctype='COUNTY' THEN

		text_output:= (SELECT STRING_AGG(

		XMLELEMENT(name "WC:Report",XMLCONCAT((SELECT XMLFOREST("REPORT_ID" AS "WC:ReportIdentifier", 

		"REPORTING_DATE" AS "WC:ReportingDate", "REPORTING_YEAR" AS "WC:ReportingYear", "REPORT_NAME" AS "WC:ReportName", 
		"REPORT_LINK" AS "WC:ReportLink", "YEAR_TYPE" AS "WC:YearType")), 
		(SELECT "WADE_R"."GeospatialRefDetail"(orgid,"REPORT_ID",datatype)),
		(SELECT "WADE_R"."XML_ALLOCATION_DETAIL"(orgid,"REPORT_ID",loctype,loctxt,datatype))))::text,'')

		FROM 

		"WADE"."REPORT" A WHERE EXISTS(SELECT DISTINCT "ORGANIZATION_ID" FROM "WADE_R"."DETAIL_LOCATION_MV" B WHERE 

		A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND A."REPORT_ID"=reportid AND B."ORGANIZATION_ID"=orgid AND "COUNTY_FIPS"=loctxt));

	END IF;



IF loctype='REPORTUNIT' THEN

	text_output:= (SELECT STRING_AGG(

		XMLELEMENT(name "WC:Report",XMLCONCAT((SELECT XMLFOREST("REPORT_ID" AS "WC:ReportIdentifier", 

		"REPORTING_DATE" AS "WC:ReportingDate", "REPORTING_YEAR" AS "WC:ReportingYear", "REPORT_NAME" AS "WC:ReportName", 
		"REPORT_LINK" AS "WC:ReportLink", "YEAR_TYPE" AS "WC:YearType")),  
		(SELECT "WADE_R"."GeospatialRefDetail"(orgid,"REPORT_ID",datatype)),
		(SELECT "WADE_R"."XML_ALLOCATION_DETAIL"(orgid,"REPORT_ID",loctype,loctxt,datatype))))::text,'')

		FROM 

		"WADE"."REPORT" A WHERE EXISTS(SELECT DISTINCT "ORGANIZATION_ID" FROM "WADE_R"."DETAIL_LOCATION_MV" B WHERE 

		A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND A."REPORT_ID"=reportid AND B."ORGANIZATION_ID"=orgid AND "REPORTING_UNIT_ID"=loctxt));

	END IF;

END IF;

RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."ReportDetail"(text, text, text, text, text)
  OWNER TO "WADE";
