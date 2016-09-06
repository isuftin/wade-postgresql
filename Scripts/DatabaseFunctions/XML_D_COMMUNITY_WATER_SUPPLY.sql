-- Function: "WADE_R"."XML_D_COMMUNITY_WATER_SUPPLY"(text, text, text, text, numeric)

-- DROP FUNCTION "WADE_R"."XML_D_COMMUNITY_WATER_SUPPLY"(text, text, text, text, numeric);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_D_COMMUNITY_WATER_SUPPLY"(
    IN orgid text,
    IN reportid text,
    IN allocationid text,
    IN wateruserid text,
    IN useid numeric,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$

DECLARE

 v_data RECORD;

 sqlstr text;

BEGIN



tmp_output := (SELECT STRING_AGG(

	XMLELEMENT(name "WC:CommunityWaterSupply", (SELECT XMLFOREST("POPULATION_SERVED" AS "WC:TotalPopulationServedNumber", "WATER_SUPPLY_NAME" AS "WC:CommunityWaterSupplyName"))
	)::text,'')

	FROM  

	"WADE"."D_COMMUNITY_WATER_SUPPLY" WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "ALLOCATION_ID"=allocationid

	 AND "WATER_USER_ID"=wateruserid AND "BENEFICIAL_USE_ID"=useid);



	RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_D_COMMUNITY_WATER_SUPPLY"(text, text, text, text, numeric)
  OWNER TO "WADE";
