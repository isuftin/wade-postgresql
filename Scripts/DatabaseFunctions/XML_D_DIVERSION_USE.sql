-- Function: "WADE_R"."XML_D_DIVERSION_USE"(text, text, text, text, numeric)

-- DROP FUNCTION "WADE_R"."XML_D_DIVERSION_USE"(text, text, text, text, numeric);

CREATE OR REPLACE FUNCTION "WADE_R"."XML_D_DIVERSION_USE"(
    IN orgid text,
    IN reportid text,
    IN allocationid text,
    IN diversionid text,
    IN seqno numeric,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$



BEGIN



tmp_output := (SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:BeneficialUse", 
			(SELECT XMLFOREST
				(B."CONTEXT" AS "WC:BeneficialUseContext", 
				B."DESCRIPTION" as "WC:BeneficialUseTypeName")
			)
		)::text,''
	)

	FROM  

	"WADE"."D_DIVERSION_USE" A LEFT OUTER JOIN "WADE"."LU_BENEFICIAL_USE" B ON (A."BENEFICIAL_USE_ID"=B."LU_SEQ_NO")
	WHERE "ORGANIZATION_ID"=orgid AND "REPORT_ID"=reportid AND "ALLOCATION_ID"=allocationid AND "DIVERSION_ID"=diversionid AND "DETAIL_SEQ_NO"=seqno);



RETURN;

		

END



  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000;
ALTER FUNCTION "WADE_R"."XML_D_DIVERSION_USE"(text, text, text, text, numeric)
  OWNER TO "WADE";
