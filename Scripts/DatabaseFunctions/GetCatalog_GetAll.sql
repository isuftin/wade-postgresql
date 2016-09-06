-- Function: "WADE_R"."GetCatalog_GetAll"(character varying)

-- DROP FUNCTION "WADE_R"."GetCatalog_GetAll"(character varying);

CREATE OR REPLACE FUNCTION "WADE_R"."GetCatalog_GetAll"(
    IN orgid character varying,
    OUT text_output xml)
  RETURNS xml AS
$BODY$

DECLARE
str1 character varying;
namespace character varying;

BEGIN

namespace:='http://www.exchangenetwork.net/schema/WaDE/0.2';
str1:='<WC:WaDECatalog xmlns:WC="http://www.exchangenetwork.net/schema/WaDE/0.2">';

text_output:= (SELECT STRING_AGG
				(XMLELEMENT
					(name "WC:Organization",
						XMLCONCAT(XMLFOREST
						(A."ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
						"WADE_URL" AS "WC:WaDEURLAdress",
						"REPORT_ID" AS "WC:ReportIdentifier",
						"DATACATEGORY" AS "WC:DataCategory",
						"DATATYPE" AS "WC:DataType",
						A."STATE" AS "WC:State",
						"REPORT_UNIT_ID" AS "WC:ReportUnitIdentifier",
						"COUNTY_FIPS" AS "WC:CountFIPS",
						"HUC" AS "WC:HUC")	
							)
					)::text,''		
				)
			
		
	FROM 
	"WADE_R"."CATALOG_SUMMARY_MV" A LEFT OUTER JOIN "WADE"."ORGANIZATION" B ON (A."ORGANIZATION_ID"=B."ORGANIZATION_ID"));
text_output:= str1 || text_output || '</WC:WaDECatalog>';
text_output:= XMLPARSE(DOCUMENT text_output);
			
RETURN;	

END




  $BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."GetCatalog_GetAll"(character varying)
  OWNER TO admin;
