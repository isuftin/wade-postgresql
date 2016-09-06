-- Function: "WADE_R"."ALLOCATION_AMOUNT"(text, text, text)

-- DROP FUNCTION "WADE_R"."ALLOCATION_AMOUNT"(text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."ALLOCATION_AMOUNT"(
    IN orgid text,
    IN reportid text,
    IN allocationid text,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$

BEGIN

tmp_output := (SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:AllocationAmount",
			XMLELEMENT
				(name "WC:WaterAllocated",
					(SELECT "WADE_R"."XML_D_ALLOCATION_USE"
						(orgid,reportid,allocationid,"DETAIL_SEQ_NO")
					),
					(SELECT CASE WHEN "AMOUNT_VOLUME" IS NOT NULL THEN XMLELEMENT
						(name "WC:AllocatedVolume", 
							(SELECT XMLFOREST
								("AMOUNT_VOLUME" AS "WC:AmountNumber",
								D."VALUE" AS "WC:AmountUnitsCode")
							)
						) END
					),
					(SELECT CASE WHEN "AMOUNT_RATE" IS NOT NULL THEN XMLELEMENT
						(name "WC:AllocatedRate", 
							(SELECT XMLFOREST
								("AMOUNT_RATE" AS "WC:AmountNumber",
								E."VALUE" AS "WC:AmountUnitsCode")
							)
						) END
					),
					(SELECT XMLFOREST
						(C."VALUE" AS "WC:SourceTypeName",
						B."VALUE" AS "WC:FreshSalineIndicator")
					),
					(XMLELEMENT
						(name "WC:TimeFrame",
							(SELECT XMLFOREST
								("ALLOCATION_START" AS "WC:TimeFrameStartName",
								"ALLOCATION_END" AS "WC:TimeFrameEndName")
							)
						)
					),
					(SELECT XMLFOREST
						("SOURCE_NAME" AS "WC:SourceName")
					),
					(SELECT "WADE_R"."XML_D_ALLOCATION_ACTUAL"
						(orgid,reportid,allocationid,"DETAIL_SEQ_NO")
					)
				)
		)::text,''
		
	)

	FROM  

	"WADE"."D_ALLOCATION_FLOW" A LEFT OUTER JOIN "WADE"."LU_FRESH_SALINE_INDICATOR" B ON (A."FRESH_SALINE_IND"=B."LU_SEQ_NO")
	LEFT OUTER JOIN "WADE"."LU_SOURCE_TYPE" C ON (A."SOURCE_TYPE"=C."LU_SEQ_NO")
	LEFT OUTER JOIN "WADE"."LU_UNITS" D ON (A."UNIT_VOLUME"=D."LU_SEQ_NO")
	LEFT OUTER JOIN "WADE"."LU_UNITS" E ON (A."UNIT_RATE"=E."LU_SEQ_NO")

	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "ALLOCATION_ID"=allocationid);

	RETURN;
END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."ALLOCATION_AMOUNT"(text, text, text)
  OWNER TO "WADE";
