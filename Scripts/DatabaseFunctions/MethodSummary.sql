-- Function: "WADE_R"."MethodSummary"(text, text)

-- DROP FUNCTION "WADE_R"."MethodSummary"(text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."MethodSummary"(
    IN methodid text,
    IN methodname text,
    OUT text_output xml)
  RETURNS xml AS
$BODY$



BEGIN

IF methodname='ALL' THEN

text_output:= (SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:Method",
		XMLCONCAT(
			(SELECT XMLFOREST
				("METHOD_ID" AS "WC:MethodIdentifier", 
				"METHOD_NAME" AS "WC:MethodName",
				"METHOD_DESC" AS "WC:MethodDescriptionText", 
				"METHOD_DATE" AS "WC:MethodDevelopmentDate",
				"METHOD_TYPE" AS "WC:MethodTypeText",
				"TIME_SCALE" AS "WC:TimeScaleText",
				"METHOD_LINK" AS "WC:MethodLinkText")
			),
			XMLELEMENT
				(name "WC:ResourceType",
					(SELECT XMLFOREST
						("RESOURCE_TYPE" AS "WC:ResourceTypeText")
					)
				),
				XMLELEMENT
					(name "WC:ApplicableAreas",
						(SELECT XMLFOREST
							("LOCATION_NAME" AS "WC:LocationNameText")
						)
					),
					XMLELEMENT
						(name "WC:DataSource",
							(SELECT XMLFOREST
								(B."SOURCE_ID" AS "WC:DataSourceIdentifier",
								"SOURCE_NAME" AS "WC:DataSourceName",
								"SOURCE_DESC" AS "WC:DataSourceDescription")
							),
							XMLELEMENT
								(name "WC:DataSourceTimePeriod",
									(SELECT XMLFOREST
										("SOURCE_START_DATE" AS "WC:TimePeriodStartDate",
										"SOURCE_END_DATE" AS "WC:TimePeriodEndDate")
									)
								),
								(SELECT XMLFOREST
									("SOURCE_LINK" AS "WC:DataSourceLinkText")
								)
						)
			
			)
		)::text,''	
	)

	FROM 

	"WADE"."METHODS" A LEFT OUTER JOIN "WADE"."DATA_SOURCES" B ON (A."SOURCE_ID"=B."SOURCE_ID")

	WHERE "METHOD_CONTEXT"=methodid);
	
ELSE


text_output:= (SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:Method",
		XMLCONCAT(
			(SELECT XMLFOREST
				("METHOD_ID" AS "WC:MethodIdentifier", 
				"METHOD_NAME" AS "WC:MethodName",
				"METHOD_DESC" AS "WC:MethodDescriptionText", 
				"METHOD_DATE" AS "WC:MethodDevelopmentDate",
				"METHOD_TYPE" AS "WC:MethodTypeText",	 
				"TIME_SCALE" AS "WC:TimeScaleText",
				"METHOD_LINK" AS "WC:MethodLinkText")
			),
			XMLELEMENT
				(name "WC:ResourceType",
					(SELECT XMLFOREST
						("RESOURCE_TYPE" AS "WC:ResourceTypeText")
					)
				),
				XMLELEMENT
					(name "WC:ApplicableAreas",
						(SELECT XMLFOREST
							("LOCATION_NAME" AS "WC:LocationNameText")
						)
					),
					XMLELEMENT
						(name "WC:DataSource",
							(SELECT XMLFOREST
								(B."SOURCE_ID" AS "WC:DataSourceIdentifier",
								"SOURCE_NAME" AS "WC:DataSourceName",
								"SOURCE_DESC" AS "WC:DataSourceDescription")
							),
							XMLELEMENT
								(name "WC:DataSourceTimePeriod",
									(SELECT XMLFOREST
										("SOURCE_START_DATE" AS "WC:TimePeriodStartDate",
										"SOURCE_END_DATE" AS "WC:TimePeriodEndDate")
									)
								),
								(SELECT XMLFOREST
									("SOURCE_LINK" AS "WC:DataSourceLinkText")
								)
						)
			
			)
		)::text,''	
	)

	FROM 

	"WADE"."METHODS" A LEFT OUTER JOIN "WADE"."DATA_SOURCES" B ON (A."SOURCE_ID"=B."SOURCE_ID")

	WHERE "METHOD_CONTEXT"=methodid AND "METHOD_NAME"=methodname);
	
END IF;

RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."MethodSummary"(text, text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION "WADE_R"."MethodSummary"(text, text) TO postgres;
GRANT EXECUTE ON FUNCTION "WADE_R"."MethodSummary"(text, text) TO public;
GRANT EXECUTE ON FUNCTION "WADE_R"."MethodSummary"(text, text) TO "WADE_ADMIN" WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION "WADE_R"."MethodSummary"(text, text) TO "WADE_APP";
