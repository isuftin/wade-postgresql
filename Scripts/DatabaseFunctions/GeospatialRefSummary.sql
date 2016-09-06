-- Function: "WADE_R"."GeospatialRefSummary"(text, text, text)

-- DROP FUNCTION "WADE_R"."GeospatialRefSummary"(text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."GeospatialRefSummary"(
    IN orgid text,
    IN reportid text,
    IN datatype text,
    OUT text_output xml)
  RETURNS xml AS
$BODY$

BEGIN
IF datatype <> 'ALL' THEN

text_output:= (SELECT STRING_AGG(
	XMLELEMENT(name "WC:GeospatialReference",
			(XMLELEMENT
				(name "WC:WFSType",
					(SELECT XMLFOREST
						("WFS_DATACATEGORY" AS "WC:WFSDataCategory",
						 "WFS_DATATYPE" AS "WC:WFSTypeName", 
						 "WFS_ADDRESS" AS "WC:WFSAddressLink",
						"WFS_FEATURE_ID_FIELD" AS "WC:WFSFeatureIDFieldText")
					)
				)	
			)
		)::text,''
	)

	FROM 

	"WADE"."GEOSPATIAL_REF" WHERE "ORGANIZATION_ID"=orgid AND "WFS_DATACATEGORY"='SUMMARY'
	AND "WFS_DATATYPE"=datatype AND "REPORT_ID"=reportid);

ELSE

text_output:= (SELECT STRING_AGG(
	XMLELEMENT(name "WC:GeospatialReference",
			(XMLELEMENT
				(name "WC:WFSType",
					(SELECT XMLFOREST
						("WFS_DATACATEGORY" AS "WC:WFSDataCategory",
						 "WFS_DATATYPE" AS "WC:WFSTypeName", 
						 "WFS_ADDRESS" AS "WC:WFSAddressLink",
						"WFS_FEATURE_ID_FIELD" AS "WC:WFSFeatureIDFieldText")
					)
				)	
			)
		)::text,''
	)

	FROM 

	"WADE"."GEOSPATIAL_REF" WHERE "ORGANIZATION_ID"=orgid AND "WFS_DATACATEGORY"='SUMMARY' AND "REPORT_ID"=reportid);
END IF;
RETURN;
END

$BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."GeospatialRefSummary"(text, text, text)
  OWNER TO "WADE";
