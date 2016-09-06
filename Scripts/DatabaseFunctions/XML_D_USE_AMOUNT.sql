-- Function: "WADE_R"."XML_D_USE_AMOUNT"(text, text, text, text, numeric)

-- DROP FUNCTION "WADE_R"."XML_D_USE_AMOUNT"(text, text, text, text, numeric);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_D_USE_AMOUNT"(
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
		(name "WC:UseVolume", 
			(SELECT XMLFOREST
				("AMOUNT_VOLUME" as "WC:AmountNumber",
				C."VALUE" AS "WC:AmountUnitsCode", 
				D."DESCRIPTION" AS "WC:ValueTypeCode")
			), 
			XMLELEMENT
				(name "WC:Method", 
					(SELECT XMLFOREST
						(B."METHOD_CONTEXT" AS "WC:MethodContext", 
						B."METHOD_NAME" AS "WC:MethodName")
					)
				),
				XMLELEMENT
					(name "WC:TimeFrame", 
						(SELECT XMLFOREST
							("START_DATE" AS "WC:TimeFrameStartName", 
							"END_DATE" AS "WC:TimeFrameEndName")
						)
					)
		)::text,''
	)

	FROM  

	"WADE"."D_USE_AMOUNT" A LEFT OUTER JOIN "WADE"."METHODS" B ON (A."METHOD_ID_VOLUME"=B."METHOD_ID") 
	LEFT OUTER JOIN "WADE"."LU_UNITS" C ON (A."UNIT_VOLUME"=C."LU_SEQ_NO") 
	LEFT OUTER JOIN "WADE"."LU_VALUE_TYPE" D ON (A."VALUE_TYPE_VOLUME"=D."LU_SEQ_NO")
	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "ALLOCATION_ID" =allocationid 
	AND "WATER_USER_ID"=wateruserid AND "BENEFICIAL_USE_ID"=useid);



RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_D_USE_AMOUNT"(text, text, text, text, numeric)
  OWNER TO "WADE";
