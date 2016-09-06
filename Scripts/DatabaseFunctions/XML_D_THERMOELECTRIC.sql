-- Function: "WADE_R"."XML_D_THERMOELECTRIC"(text, text, text, text, numeric)

-- DROP FUNCTION "WADE_R"."XML_D_THERMOELECTRIC"(text, text, text, text, numeric);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_D_THERMOELECTRIC"(
    IN orgid text,
    IN reportid text,
    IN allocationid text,
    IN wateruserid text,
    IN useid numeric,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$



BEGIN



tmp_output := (SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:ThermoElectricWaterSupply", 
			(SELECT XMLFOREST
				("VALUE" AS "WC:GeneratorTypeName",
				 "POWER_CAPACITY" AS "WC:PowerCapacityNumber")
			)
		)::text,''
	)

	FROM  

	"WADE"."D_THERMOELECTRIC" A LEFT OUTER JOIN "WADE"."LU_GENERATOR_TYPE" B ON (A."GENERATOR_TYPE"=B."LU_SEQ_NO")
	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "ALLOCATION_ID"=allocationid AND "WATER_USER_ID"=wateruserid

	 AND "BENEFICIAL_USE_ID"=useid);



	RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_D_THERMOELECTRIC"(text, text, text, text, numeric)
  OWNER TO "WADE";
