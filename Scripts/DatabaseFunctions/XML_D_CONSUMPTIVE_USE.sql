-- Function: "WADE_R"."XML_D_CONSUMPTIVE_USE"(text, text, text, text)

-- DROP FUNCTION "WADE_R"."XML_D_CONSUMPTIVE_USE"(text, text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_D_CONSUMPTIVE_USE"(
    IN orgid text,
    IN reportid text,
    IN allocationid text,
    IN wateruserid text,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$

DECLARE

BEGIN



tmp_output := (SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:UseEstimate", 
			(SELECT XMLFOREST
				(B."CONTEXT" AS "WC:BeneficialUseContext", 
				B."VALUE" AS "WC:BeneficialUseTypeName")
			),
			(SELECT "WADE_R"."USE_AMOUNT"
				(orgid, reportid, allocationid, wateruserid)
			)
		)::text,''
	)

	FROM  

	"WADE"."D_CONSUMPTIVE_USE" A LEFT OUTER JOIN "WADE"."LU_BENEFICIAL_USE" B ON (A."BENEFICIAL_USE_ID"=B."LU_SEQ_NO") 

	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "ALLOCATION_ID"=allocationid 

	AND "WATER_USER_ID"=wateruserid);





	RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_D_CONSUMPTIVE_USE"(text, text, text, text)
  OWNER TO "WADE";
