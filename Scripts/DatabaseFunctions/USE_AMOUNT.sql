-- Function: "WADE_R"."USE_AMOUNT"(text, text, text, text)

-- DROP FUNCTION "WADE_R"."USE_AMOUNT"(text, text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."USE_AMOUNT"(
    IN orgid text,
    IN reportid text,
    IN allocationid text,
    IN wateruserid text,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$



BEGIN



tmp_output := (SELECT STRING_AGG
	(XMLCONCAT
		(XMLFOREST
			(C."VALUE" AS "WC:SourceTypeName",
			 B."VALUE" AS "WC:FreshSalineIndicator",
			 "SOURCE_NAME" as "WC:SourceName"),
		(SELECT "WADE_R"."XML_D_COMMUNITY_WATER_SUPPLY"
			(orgid,reportid, allocationid, wateruserid, "BENEFICIAL_USE_ID")
		),
		(SELECT "WADE_R"."XML_D_IRRIGATION"
			(orgid,reportid, allocationid, wateruserid, "BENEFICIAL_USE_ID")
		),
		(SELECT "WADE_R"."XML_D_THERMOELECTRIC"
			(orgid,reportid, allocationid, wateruserid, "BENEFICIAL_USE_ID")
		),
		(SELECT "WADE_R"."XML_D_USE_AMOUNT"
			(orgid,reportid,allocationid,wateruserid, "BENEFICIAL_USE_ID")
		)
		)::text,''
	)
	
	FROM  

	"WADE"."D_CONSUMPTIVE_USE" A LEFT OUTER JOIN "WADE"."LU_FRESH_SALINE_INDICATOR" B ON (A."FRESH_SALINE_IND"=B."LU_SEQ_NO")
	LEFT OUTER JOIN "WADE"."LU_SOURCE_TYPE" C ON (A."SOURCE_TYPE"=C."LU_SEQ_NO") 
	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "ALLOCATION_ID"=allocationid AND "WATER_USER_ID"=wateruserid);

If tmp_output IS NULL THEN

ELSE

	tmp_output :='<WC:UseAmount>' || tmp_output || '</WC:UseAmount>';

END IF;

	RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."USE_AMOUNT"(text, text, text, text)
  OWNER TO "WADE";
