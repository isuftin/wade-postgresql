-- Function: "WADE_R"."GetMethod"(character varying, character varying)

-- DROP FUNCTION "WADE_R"."GetMethod"(character varying, character varying);

CREATE OR REPLACE FUNCTION "WADE_R"."GetMethod"(
    IN methodid character varying,
    IN methodname character varying,
    OUT text_output xml)
  RETURNS xml AS
$BODY$

DECLARE

namespace character varying;

BEGIN

namespace:='http://www.exchangenetwork.net/schema/WaDE/0.2';

text_output:= (SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:MethodDescriptor", XMLATTRIBUTES(namespace as "xmlns:WC"),
		XMLELEMENT
			(name "WC:Organization",
			XMLCONCAT((SELECT XMLFOREST
					("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
					"ORGANIZATION_NAME" AS "WC:OrganizationName")
				),
				XMLELEMENT
					(name "WC:Contact",
						(SELECT XMLFOREST
							("FIRST_NAME" AS "WC:FirstName",
							"MIDDLE_INITIAL" AS "WC:MiddleInitial",
							"LAST_NAME" AS "WC:LastName", 
							"TITLE" AS "WC:IndividualTitleText", 
							"EMAIL" AS "WC:EmailAddressText", 
							"PHONE" AS "WC:TelephoneNumberText", 
							"PHONE_EXT" AS "WC:PhoneExtensionText", 
							"FAX" AS "WC:FaxNumberText")
						)
					),	
					(SELECT "WADE_R"."MethodSummary"("ORGANIZATION_ID",methodname)
					)
				)
			)
		)::text,''
	)

FROM "WADE"."ORGANIZATION" A WHERE "ORGANIZATION_ID"=methodid);

RETURN;

END
  $BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."GetMethod"(character varying, character varying)
  OWNER TO "WADE";
