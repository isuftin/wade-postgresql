-- Function: "WADE_R"."GeospatialRefDetail"(text, text, text)

-- DROP FUNCTION "WADE_R"."GeospatialRefDetail"(text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."GeospatialRefDetail"(
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

	"WADE"."GEOSPATIAL_REF" A WHERE "ORGANIZATION_ID"=orgid 
	AND "REPORT_ID"=reportid AND "WFS_DATACATEGORY"='DETAIL' AND "WFS_DATATYPE"=datatype);
	
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

	"WADE"."GEOSPATIAL_REF" A WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "WFS_DATACATEGORY"='DETAIL');
END IF;
RETURN;
END
$BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."GeospatialRefDetail"(text, text, text)
  OWNER TO "WADE";
