-- Function: "WADE_R"."XML_D_ALLOCATION_ACTUAL"(text, text, text, numeric)

-- DROP FUNCTION "WADE_R"."XML_D_ALLOCATION_ACTUAL"(text, text, text, numeric);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_D_ALLOCATION_ACTUAL"(
    IN orgid text,
    IN reportid text,
    IN allocationid text,
    IN seqno numeric,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$



BEGIN



tmp_output := (SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:ActualFlow", 
			(SELECT CASE WHEN "AMOUNT_VOLUME" IS NOT NULL THEN XMLELEMENT
				(name "WC:ActualVolume", 
					(SELECT XMLFOREST
						("AMOUNT_VOLUME" as "WC:ActualAmountNumber",
						 D."VALUE" AS "WC:ActualAmountUnitsCode", 
						 F."DESCRIPTION" AS "WC:ValueTypeCode")
					), 
					XMLELEMENT
						(name "WC:Method", 
							(SELECT XMLFOREST
								(B."METHOD_CONTEXT" AS "WC:MethodContext",
								 B."METHOD_NAME" AS "WC:MethodName")
							)
						)
				) END
			),
			(SELECT CASE WHEN "AMOUNT_RATE" IS NOT NULL THEN XMLELEMENT
				(name "WC:ActualRate", 
					(SELECT XMLFOREST
						("AMOUNT_RATE" as "WC:ActualAmountNumber", 
						E."VALUE" AS "WC:ActualAmountUnitsCode", 
						G."DESCRIPTION" AS "WC:ValueTypeCode")
					), 
					XMLELEMENT
						(name "WC:Method", 
							(SELECT XMLFOREST
								(C."METHOD_CONTEXT" AS "WC:MethodContext",
								 C."METHOD_NAME" AS "WC:MethodName")
							)
						)
				) END
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

	"WADE"."D_ALLOCATION_ACTUAL" A LEFT OUTER JOIN "WADE"."METHODS" B ON (A."METHOD_ID_VOLUME"=B."METHOD_ID") 
	LEFT OUTER JOIN "WADE"."METHODS" C ON (A."METHOD_ID_RATE"=C."METHOD_ID")
	LEFT OUTER JOIN "WADE"."LU_UNITS" D ON (A."UNIT_VOLUME"=D."LU_SEQ_NO")
	LEFT OUTER JOIN "WADE"."LU_UNITS" E ON (A."UNIT_RATE"=E."LU_SEQ_NO")
	LEFT OUTER JOIN "WADE"."LU_VALUE_TYPE" F ON (A."VALUE_TYPE_VOLUME"=F."LU_SEQ_NO")
	LEFT OUTER JOIN "WADE"."LU_VALUE_TYPE" G ON (A."VALUE_TYPE_RATE"=G."LU_SEQ_NO")
	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "ALLOCATION_ID" =allocationid AND "DETAIL_SEQ_NO"=seqno);

RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_D_ALLOCATION_ACTUAL"(text, text, text, numeric)
  OWNER TO "WADE";
