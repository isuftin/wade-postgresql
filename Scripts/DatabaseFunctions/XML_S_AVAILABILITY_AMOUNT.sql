-- Function: "WADE_R"."XML_S_AVAILABILITY_AMOUNT"(text, text, text, numeric)

-- DROP FUNCTION "WADE_R"."XML_S_AVAILABILITY_AMOUNT"(text, text, text, numeric);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_S_AVAILABILITY_AMOUNT"(
    IN orgid text,
    IN reportid text,
    IN reportunitid text,
    IN seqno numeric,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$

BEGIN

tmp_output:=(SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:AvailabilityAmount",
			(SELECT XMLFOREST
				("AMOUNT" AS "WC:AmountNumber")
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

	"WADE"."S_AVAILABILITY_AMOUNT" A LEFT JOIN "WADE"."METHODS" B ON (A."METHOD_ID"=B."METHOD_ID") 

	WHERE 

	"ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "REPORT_UNIT_ID"=reportunitid AND "SUMMARY_SEQ"=seqno);

	RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_S_AVAILABILITY_AMOUNT"(text, text, text, numeric)
  OWNER TO "WADE";
