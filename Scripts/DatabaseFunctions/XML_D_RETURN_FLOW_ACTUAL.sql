-- Function: "WADE_R"."XML_D_RETURN_FLOW_ACTUAL"(text, text, text, text)

-- DROP FUNCTION "WADE_R"."XML_D_RETURN_FLOW_ACTUAL"(text, text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_D_RETURN_FLOW_ACTUAL"(
    IN orgid text,
    IN reportid text,
    IN allocationid text,
    IN returnflowid text,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$



BEGIN



tmp_output := (SELECT STRING_AGG(XMLELEMENT(name "WC:ReturnFlowAmount",

	(SELECT CASE WHEN "AMOUNT_VOLUME" IS NOT NULL THEN XMLELEMENT(name "WC:ReturnVolume", 
		(SELECT XMLFOREST("AMOUNT_VOLUME" AS "WC:AmountNumber", 
				D."VALUE" AS "WC:AmountUnitsCode", 
				F."DESCRIPTION" AS "WC:ValueTypeCode")), 
		(SELECT CASE WHEN "METHOD_ID_VOLUME" IS NOT NULL THEN XMLELEMENT(name "WC:Method", 
			(SELECT XMLFOREST(B."METHOD_CONTEXT" AS "WC:MethodContext", 
			B."METHOD_NAME" AS "WC:MethodName"))) END)) END), 

	(SELECT CASE WHEN "AMOUNT_RATE" IS NOT NULL THEN XMLELEMENT
		(name "WC:ReturnRate", 
			(SELECT XMLFOREST
				("AMOUNT_RATE" AS "WC:AmountNumber", 
				E."VALUE" AS "WC:AmountUnitsCode", 
				G."DESCRIPTION" AS "WC:ValueTypeCode")
			), 
			(SELECT CASE WHEN "METHOD_ID_RATE" IS NOT NULL THEN XMLELEMENT
				(name "WC:Method", 
					(SELECT XMLFOREST
						(C."METHOD_CONTEXT" AS "WC:MethodContext", 
						C."METHOD_NAME" AS "WC:MethodName")
					)
				) 
			END),
			XMLELEMENT
				(name "WC:TimeFrame",
					(SELECT XMLFOREST
						("START_DATE" AS "WC:TimeFrameStartName", 
						"END_DATE" AS "WC:TimeFrameEndName")
					)
				)
		) 
	END)
	
	)::text,'')


	FROM  

	"WADE"."D_RETURN_FLOW_ACTUAL" A LEFT OUTER JOIN "WADE"."METHODS" B ON (A."METHOD_ID_VOLUME"=B."METHOD_ID") 
	LEFT OUTER JOIN "WADE"."METHODS" C ON (A."METHOD_ID_RATE"=C."METHOD_ID")
	LEFT OUTER JOIN "WADE"."LU_UNITS" D ON (A."UNIT_VOLUME"=D."LU_SEQ_NO")
	LEFT OUTER JOIN "WADE"."LU_UNITS" E ON (A."UNIT_RATE"=E."LU_SEQ_NO")
	LEFT OUTER JOIN "WADE"."LU_VALUE_TYPE" F ON (A."VALUE_TYPE_VOLUME"=F."LU_SEQ_NO")
	LEFT OUTER JOIN "WADE"."LU_VALUE_TYPE" G ON (A."VALUE_TYPE_RATE"=G."LU_SEQ_NO")
	
	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "ALLOCATION_ID" =allocationid AND "RETURN_FLOW_ID"=returnflowid);

RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_D_RETURN_FLOW_ACTUAL"(text, text, text, text)
  OWNER TO "WADE";
