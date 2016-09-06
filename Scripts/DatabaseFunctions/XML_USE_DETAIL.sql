-- Function: "WADE_R"."XML_USE_DETAIL"(text, text, text)

-- DROP FUNCTION "WADE_R"."XML_USE_DETAIL"(text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_USE_DETAIL"(
    IN orgid text,
    IN reportid text,
    IN allocationid text,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$



BEGIN

tmp_output := (SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:ConsumptiveUse", 
			(SELECT XMLFOREST
				("WATER_USER_ID" AS "WC:UserIdentifier", 
				"WATER_USER_NAME" AS "WC:UserName")
			), 
			(SELECT "WADE_R"."XML_D_USE_LOCATION"
				(orgid,reportid,allocationid,"WATER_USER_ID")
			),
		
			(SELECT "WADE_R"."XML_D_CONSUMPTIVE_USE"
				(orgid,reportid,allocationid,"WATER_USER_ID")
			)
		)::text,''
	) 

	FROM "WADE"."DETAIL_USE" WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "ALLOCATION_ID"=allocationid);





	RETURN;

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_USE_DETAIL"(text, text, text)
  OWNER TO "WADE";
