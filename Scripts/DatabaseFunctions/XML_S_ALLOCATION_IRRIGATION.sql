-- Function: "WADE_R"."XML_S_ALLOCATION_IRRIGATION"(text, text, text, numeric)

-- DROP FUNCTION "WADE_R"."XML_S_ALLOCATION_IRRIGATION"(text, text, text, numeric);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_S_ALLOCATION_IRRIGATION"(
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
		(name "WC:IrrigationWaterSupply",
			(SELECT XMLFOREST
				(C."VALUE" AS "WC:IrrigationMethodName", 
				"ACRES_IRRIGATED" as "WC:AcresIrrigatedNumber", 
				B."VALUE" AS "WC:CropTypeName")
			)
		)::text,''
	)

	FROM  

	"WADE"."S_ALLOCATION_IRRIGATION" A LEFT OUTER JOIN "WADE"."LU_CROP_TYPE" B ON (A."CROP_TYPE"=B."LU_SEQ_NO")
	LEFT OUTER JOIN "WADE"."LU_IRRIGATION_METHOD" C ON (A."IRRIGATION_METHOD"=C."LU_SEQ_NO")
	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "REPORT_UNIT_ID"=reportunitid AND "SUMMARY_SEQ"=seqno);

	RETURN;
	

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_S_ALLOCATION_IRRIGATION"(text, text, text, numeric)
  OWNER TO "WADE";
