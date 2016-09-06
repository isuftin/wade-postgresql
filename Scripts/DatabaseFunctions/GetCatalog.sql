-- Function: "WADE_R"."GetCatalog"(character varying, character varying, character varying, numeric)

-- DROP FUNCTION "WADE_R"."GetCatalog"(character varying, character varying, character varying, numeric);

CREATE OR REPLACE FUNCTION "WADE_R"."GetCatalog"(
    IN loctype character varying,
    IN loctxt character varying,
    IN orgid character varying,
    IN state numeric,
    OUT text_output xml)
  RETURNS xml AS
$BODY$

DECLARE

namespace character varying;

BEGIN

namespace:='http://www.exchangenetwork.net/schema/WaDE/0.2';

IF state='58' THEN
IF orgid='ALL' THEN
IF loctype='HUC' THEN	

text_output:= (SELECT STRING_AGG(

XMLELEMENT(name "WC:WaDECatalog", XMLATTRIBUTES(namespace as "xmlns:WC"),
	XMLELEMENT(name "WC:Organization",
	XMLCONCAT((SELECT XMLFOREST
			("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
			"ORGANIZATION_NAME" AS "WC:OrganizationName", 
			"WADE_URL" AS "WC:WaDEURLAddress",
			"PURVUE_DESC" AS "WC:PurviewDescription")),
			XMLELEMENT(name "WC:Contact",
				(SELECT XMLFOREST
					("FIRST_NAME" AS "WC:FirstName",
					"MIDDLE_INITIAL" AS "WC:MiddleInitial",
					"LAST_NAME" AS "WC:LastName", 
					"TITLE" AS "WC:IndividualTitleText", 
					"EMAIL" AS "WC:EmailAddressText", 
					"PHONE" AS "WC:TelephoneNumberText", 
					"PHONE_EXT" AS "WC:PhoneExtensionText", 
					"FAX" AS "WC:FaxNumberText")),
					XMLELEMENT(name "WC:MailingAddress",
						(SELECT XMLFOREST
							("ADDRESS" AS "WC:MailingAddressText",
							"ADDRESS_EXT" AS "WC:SupplementalAddressText", 
							"CITY" AS "WC:MailingAddressCityName", 
							"STATE" AS "WC:MailingAddressStateUSPSCode", 
							"COUNTRY" AS "WC:MailingAddressCountryCode", 
							"ZIPCODE" AS "WC:MailingAddressZIPCode")
						))	
				),
			(SELECT "WADE_R"."ReportCatalog"("ORGANIZATION_ID",loctype,loctxt))
		)
	)
	)::text,'')

	FROM "WADE"."ORGANIZATION" A WHERE EXISTS(SELECT B."ORGANIZATION_ID" 
	FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND B."HUC"=loctxt));

END IF;

IF loctype='COUNTY' THEN	

text_output:= (SELECT STRING_AGG(

XMLELEMENT(name "WC:WaDECatalog", XMLATTRIBUTES(namespace as "xmlns:WC"),
	XMLELEMENT(name "WC:Organization",
	XMLCONCAT((SELECT XMLFOREST
			("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
			"WADE_URL" AS "WC:WaDEURLAddress",
			"ORGANIZATION_NAME" AS "WC:OrganizationName", 
			"PURVUE_DESC" AS "WC:PurviewDescription")),
			XMLELEMENT(name "WC:Contact",
				(SELECT XMLFOREST
					("FIRST_NAME" AS "WC:FirstName",
					"MIDDLE_INITIAL" AS "WC:MiddleInitial",
					"LAST_NAME" AS "WC:LastName", 
					"TITLE" AS "WC:IndividualTitleText", 
					"EMAIL" AS "WC:EmailAddressText", 
					"PHONE" AS "WC:TelephoneNumberText", 
					"PHONE_EXT" AS "WC:PhoneExtensionText", 
					"FAX" AS "WC:FaxNumberText")),
					XMLELEMENT(name "WC:MailingAddress",
						(SELECT XMLFOREST
							("ADDRESS" AS "WC:MailingAddressText",
							"ADDRESS_EXT" AS "WC:SupplementalAddressText", 
							"CITY" AS "WC:MailingAddressCityName", 
							"STATE" AS "WC:MailingAddressStateUSPSCode", 
							"COUNTRY" AS "WC:MailingAddressCountryCode", 
							"ZIPCODE" AS "WC:MailingAddressZIPCode")
						))	
				),
			(SELECT "WADE_R"."ReportCatalog"("ORGANIZATION_ID",loctype,loctxt))
		)
	)
	)::text,'')
	FROM "WADE"."ORGANIZATION" A WHERE EXISTS(SELECT B."ORGANIZATION_ID" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND B."COUNTY_FIPS"=loctxt));

END IF;

IF loctype='REPORTUNIT' THEN	

text_output:= (SELECT STRING_AGG(

XMLELEMENT(name "WC:WaDECatalog", XMLATTRIBUTES(namespace as "xmlns:WC"),
	XMLELEMENT(name "WC:Organization",
	XMLCONCAT((SELECT XMLFOREST
			("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
			"ORGANIZATION_NAME" AS "WC:OrganizationName", 
			"WADE_URL" AS "WC:WaDEURLAddress",
			"PURVUE_DESC" AS "WC:PurviewDescription")),
			XMLELEMENT(name "WC:Contact",
				(SELECT XMLFOREST
					("FIRST_NAME" AS "WC:FirstName",
					"MIDDLE_INITIAL" AS "WC:MiddleInitial",
					"LAST_NAME" AS "WC:LastName", 
					"TITLE" AS "WC:IndividualTitleText", 
					"EMAIL" AS "WC:EmailAddressText", 
					"PHONE" AS "WC:TelephoneNumberText", 
					"PHONE_EXT" AS "WC:PhoneExtensionText", 
					"FAX" AS "WC:FaxNumberText")),
					XMLELEMENT(name "WC:MailingAddress",
						(SELECT XMLFOREST
							("ADDRESS" AS "WC:MailingAddressText",
							"ADDRESS_EXT" AS "WC:SupplementalAddressText", 
							"CITY" AS "WC:MailingAddressCityName", 
							"STATE" AS "WC:MailingAddressStateUSPSCode", 
							"COUNTRY" AS "WC:MailingAddressCountryCode", 
							"ZIPCODE" AS "WC:MailingAddressZIPCode")
						))	
				),
			(SELECT "WADE_R"."ReportCatalog"("ORGANIZATION_ID",loctype,loctxt))
		)
	)
	)::text,'')

	FROM "WADE"."ORGANIZATION" A WHERE EXISTS(SELECT B."ORGANIZATION_ID" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND B."REPORT_UNIT_ID"=loctxt));

END IF;

ELSE

IF loctype='HUC' THEN

text_output:= (SELECT STRING_AGG(

XMLELEMENT(name "WC:WaDECatalog", XMLATTRIBUTES(namespace as "xmlns:WC"),
	XMLELEMENT(name "WC:Organization",
	XMLCONCAT((SELECT XMLFOREST
			("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
			"ORGANIZATION_NAME" AS "WC:OrganizationName", 
			"WADE_URL" AS "WC:WaDEURLAddress",			
			"PURVUE_DESC" AS "WC:PurviewDescription")),
			XMLELEMENT(name "WC:Contact",
				(SELECT XMLFOREST
					("FIRST_NAME" AS "WC:FirstName",
					"MIDDLE_INITIAL" AS "WC:MiddleInitial",
					"LAST_NAME" AS "WC:LastName", 
					"TITLE" AS "WC:IndividualTitleText", 
					"EMAIL" AS "WC:EmailAddressText", 
					"PHONE" AS "WC:TelephoneNumberText", 
					"PHONE_EXT" AS "WC:PhoneExtensionText", 
					"FAX" AS "WC:FaxNumberText")),
					XMLELEMENT(name "WC:MailingAddress",
						(SELECT XMLFOREST
							("ADDRESS" AS "WC:MailingAddressText",
							"ADDRESS_EXT" AS "WC:SupplementalAddressText", 
							"CITY" AS "WC:MailingAddressCityName", 
							"STATE" AS "WC:MailingAddressStateUSPSCode", 
							"COUNTRY" AS "WC:MailingAddressCountryCode", 
							"ZIPCODE" AS "WC:MailingAddressZIPCode")
						))	
				),
			(SELECT "WADE_R"."ReportCatalog"("ORGANIZATION_ID",loctype,loctxt))
		)
	)
	)::text,'')

	FROM "WADE"."ORGANIZATION" A WHERE EXISTS(SELECT B."ORGANIZATION_ID" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND B."HUC"=loctxt AND B."ORGANIZATION_ID"=orgid));

END IF;

IF loctype='COUNTY' THEN	

text_output:= (SELECT STRING_AGG(

XMLELEMENT(name "WC:WaDECatalog", XMLATTRIBUTES(namespace as "xmlns:WC"),
	XMLELEMENT(name "WC:Organization",
	XMLCONCAT((SELECT XMLFOREST
			("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
			"ORGANIZATION_NAME" AS "WC:OrganizationName", 
			"WADE_URL" AS "WC:WaDEURLAddress",			
			"PURVUE_DESC" AS "WC:PurviewDescription")),
			XMLELEMENT(name "WC:Contact",
				(SELECT XMLFOREST
					("FIRST_NAME" AS "WC:FirstName",
					"MIDDLE_INITIAL" AS "WC:MiddleInitial",
					"LAST_NAME" AS "WC:LastName", 
					"TITLE" AS "WC:IndividualTitleText", 
					"EMAIL" AS "WC:EmailAddressText", 
					"PHONE" AS "WC:TelephoneNumberText", 
					"PHONE_EXT" AS "WC:PhoneExtensionText", 
					"FAX" AS "WC:FaxNumberText")),
					XMLELEMENT(name "WC:MailingAddress",
						(SELECT XMLFOREST
							("ADDRESS" AS "WC:MailingAddressText",
							"ADDRESS_EXT" AS "WC:SupplementalAddressText", 
							"CITY" AS "WC:MailingAddressCityName", 
							"STATE" AS "WC:MailingAddressStateUSPSCode", 
							"COUNTRY" AS "WC:MailingAddressCountryCode", 
							"ZIPCODE" AS "WC:MailingAddressZIPCode")
						))	
				),
			(SELECT "WADE_R"."ReportCatalog"("ORGANIZATION_ID",loctype,loctxt))
		)
	)
	)::text,'')

	FROM "WADE"."ORGANIZATION" A WHERE EXISTS(SELECT B."ORGANIZATION_ID" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND B."COUNTY_FIPS"=loctxt AND B."ORGANIZATION_ID"=orgid));

END IF;

IF loctype='REPORTUNIT' THEN	

text_output:= (SELECT STRING_AGG(

XMLELEMENT(name "WC:WaDECatalog", XMLATTRIBUTES(namespace as "xmlns:WC"),
	XMLELEMENT(name "WC:Organization",
	XMLCONCAT((SELECT XMLFOREST
			("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
			"ORGANIZATION_NAME" AS "WC:OrganizationName", 
			"WADE_URL" AS "WC:WaDEURLAddress",			
			"PURVUE_DESC" AS "WC:PurviewDescription")),
			XMLELEMENT(name "WC:Contact",
				(SELECT XMLFOREST
					("FIRST_NAME" AS "WC:FirstName",
					"MIDDLE_INITIAL" AS "WC:MiddleInitial",
					"LAST_NAME" AS "WC:LastName", 
					"TITLE" AS "WC:IndividualTitleText", 
					"EMAIL" AS "WC:EmailAddressText", 
					"PHONE" AS "WC:TelephoneNumberText", 
					"PHONE_EXT" AS "WC:PhoneExtensionText", 
					"FAX" AS "WC:FaxNumberText")),
					XMLELEMENT(name "WC:MailingAddress",
						(SELECT XMLFOREST
							("ADDRESS" AS "WC:MailingAddressText",
							"ADDRESS_EXT" AS "WC:SupplementalAddressText", 
							"CITY" AS "WC:MailingAddressCityName", 
							"STATE" AS "WC:MailingAddressStateUSPSCode", 
							"COUNTRY" AS "WC:MailingAddressCountryCode", 
							"ZIPCODE" AS "WC:MailingAddressZIPCode")
						))	
				),
			(SELECT "WADE_R"."ReportCatalog"("ORGANIZATION_ID",loctype,loctxt))
		)
	)
	)::text,'')
	FROM "WADE"."ORGANIZATION" A WHERE EXISTS(SELECT B."ORGANIZATION_ID" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND B."REPORT_UNIT_ID"=loctxt AND B."ORGANIZATION_ID"=orgid));

END IF;

END IF;

ELSE

IF orgid='ALL' THEN
IF loctype='HUC' THEN	

text_output:= (SELECT STRING_AGG(

XMLELEMENT(name "WC:WaDECatalog", XMLATTRIBUTES(namespace as "xmlns:WC"),
	XMLELEMENT(name "WC:Organization",
	XMLCONCAT((SELECT XMLFOREST
			("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
			"ORGANIZATION_NAME" AS "WC:OrganizationName", 
			"WADE_URL" AS "WC:WaDEURLAddress",			
			"PURVUE_DESC" AS "WC:PurviewDescription")),
			XMLELEMENT(name "WC:Contact",
				(SELECT XMLFOREST
					("FIRST_NAME" AS "WC:FirstName",
					"MIDDLE_INITIAL" AS "WC:MiddleInitial",
					"LAST_NAME" AS "WC:LastName", 
					"TITLE" AS "WC:IndividualTitleText", 
					"EMAIL" AS "WC:EmailAddressText", 
					"PHONE" AS "WC:TelephoneNumberText", 
					"PHONE_EXT" AS "WC:PhoneExtensionText", 
					"FAX" AS "WC:FaxNumberText")),
					XMLELEMENT(name "WC:MailingAddress",
						(SELECT XMLFOREST
							("ADDRESS" AS "WC:MailingAddressText",
							"ADDRESS_EXT" AS "WC:SupplementalAddressText", 
							"CITY" AS "WC:MailingAddressCityName", 
							"STATE" AS "WC:MailingAddressStateUSPSCode", 
							"COUNTRY" AS "WC:MailingAddressCountryCode", 
							"ZIPCODE" AS "WC:MailingAddressZIPCode")
						))	
				),
			(SELECT "WADE_R"."ReportCatalog"("ORGANIZATION_ID",loctype,loctxt))
		)
	)
	)::text,'')
	FROM "WADE"."ORGANIZATION" A WHERE EXISTS(SELECT B."ORGANIZATION_ID" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND B."STATE"=state AND B."HUC"=loctxt));

END IF;

IF loctype='COUNTY' THEN	

text_output:= (SELECT STRING_AGG(

XMLELEMENT(name "WC:WaDECatalog", XMLATTRIBUTES(namespace as "xmlns:WC"),
	XMLELEMENT(name "WC:Organization",
	XMLCONCAT((SELECT XMLFOREST
			("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
			"ORGANIZATION_NAME" AS "WC:OrganizationName", 
			"WADE_URL" AS "WC:WaDEURLAddress",			
			"PURVUE_DESC" AS "WC:PurviewDescription")),
			XMLELEMENT(name "WC:Contact",
				(SELECT XMLFOREST
					("FIRST_NAME" AS "WC:FirstName",
					"MIDDLE_INITIAL" AS "WC:MiddleInitial",
					"LAST_NAME" AS "WC:LastName", 
					"TITLE" AS "WC:IndividualTitleText", 
					"EMAIL" AS "WC:EmailAddressText", 
					"PHONE" AS "WC:TelephoneNumberText", 
					"PHONE_EXT" AS "WC:PhoneExtensionText", 
					"FAX" AS "WC:FaxNumberText")),
					XMLELEMENT(name "WC:MailingAddress",
						(SELECT XMLFOREST
							("ADDRESS" AS "WC:MailingAddressText",
							"ADDRESS_EXT" AS "WC:SupplementalAddressText", 
							"CITY" AS "WC:MailingAddressCityName", 
							"STATE" AS "WC:MailingAddressStateUSPSCode", 
							"COUNTRY" AS "WC:MailingAddressCountryCode", 
							"ZIPCODE" AS "WC:MailingAddressZIPCode")
						))	
				),
			(SELECT "WADE_R"."ReportCatalog"("ORGANIZATION_ID",loctype,loctxt))
		)
	)
	)::text,'')
	FROM "WADE"."ORGANIZATION" A WHERE EXISTS(SELECT B."ORGANIZATION_ID" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND B."STATE"=state AND B."COUNTY_FIPS"=loctxt));

END IF;

IF loctype='REPORTUNIT' THEN	

text_output:= (SELECT STRING_AGG(

XMLELEMENT(name "WC:WaDECatalog", XMLATTRIBUTES(namespace as "xmlns:WC"),
	XMLELEMENT(name "WC:Organization",
	XMLCONCAT((SELECT XMLFOREST
			("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
			"ORGANIZATION_NAME" AS "WC:OrganizationName", 
			"WADE_URL" AS "WC:WaDEURLAddress",			
			"PURVUE_DESC" AS "WC:PurviewDescription")),
			XMLELEMENT(name "WC:Contact",
				(SELECT XMLFOREST
					("FIRST_NAME" AS "WC:FirstName",
					"MIDDLE_INITIAL" AS "WC:MiddleInitial",
					"LAST_NAME" AS "WC:LastName", 
					"TITLE" AS "WC:IndividualTitleText", 
					"EMAIL" AS "WC:EmailAddressText", 
					"PHONE" AS "WC:TelephoneNumberText", 
					"PHONE_EXT" AS "WC:PhoneExtensionText", 
					"FAX" AS "WC:FaxNumberText")),
					XMLELEMENT(name "WC:MailingAddress",
						(SELECT XMLFOREST
							("ADDRESS" AS "WC:MailingAddressText",
							"ADDRESS_EXT" AS "WC:SupplementalAddressText", 
							"CITY" AS "WC:MailingAddressCityName", 
							"STATE" AS "WC:MailingAddressStateUSPSCode", 
							"COUNTRY" AS "WC:MailingAddressCountryCode", 
							"ZIPCODE" AS "WC:MailingAddressZIPCode")
						))	
				),
			(SELECT "WADE_R"."ReportCatalog"("ORGANIZATION_ID",loctype,loctxt))
		)
	)
	)::text,'')
	FROM "WADE"."ORGANIZATION" A WHERE EXISTS(SELECT B."ORGANIZATION_ID" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND B."STATE"=state AND B."REPORT_UNIT_ID"=loctxt));

END IF;
ELSE
IF loctype='HUC' THEN	

text_output:= (SELECT STRING_AGG(

XMLELEMENT(name "WC:WaDECatalog", XMLATTRIBUTES(namespace as "xmlns:WC"),
	XMLELEMENT(name "WC:Organization",
	XMLCONCAT((SELECT XMLFOREST
			("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
			"ORGANIZATION_NAME" AS "WC:OrganizationName", 
			"WADE_URL" AS "WC:WaDEURLAddress",			
			"PURVUE_DESC" AS "WC:PurviewDescription")),
			XMLELEMENT(name "WC:Contact",
				(SELECT XMLFOREST
					("FIRST_NAME" AS "WC:FirstName",
					"MIDDLE_INITIAL" AS "WC:MiddleInitial",
					"LAST_NAME" AS "WC:LastName", 
					"TITLE" AS "WC:IndividualTitleText", 
					"EMAIL" AS "WC:EmailAddressText", 
					"PHONE" AS "WC:TelephoneNumberText", 
					"PHONE_EXT" AS "WC:PhoneExtensionText", 
					"FAX" AS "WC:FaxNumberText")),
					XMLELEMENT(name "WC:MailingAddress",
						(SELECT XMLFOREST
							("ADDRESS" AS "WC:MailingAddressText",
							"ADDRESS_EXT" AS "WC:SupplementalAddressText", 
							"CITY" AS "WC:MailingAddressCityName", 
							"STATE" AS "WC:MailingAddressStateUSPSCode", 
							"COUNTRY" AS "WC:MailingAddressCountryCode", 
							"ZIPCODE" AS "WC:MailingAddressZIPCode")
						))	
				),
			(SELECT "WADE_R"."ReportCatalog"("ORGANIZATION_ID",loctype,loctxt))
		)
	)
	)::text,'')

	FROM "WADE"."ORGANIZATION" A WHERE EXISTS(SELECT B."ORGANIZATION_ID" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND B."STATE"=state AND B."HUC"=loctxt AND B."ORGANIZATION_ID"=orgid));

END IF;

IF loctype='COUNTY' THEN	

text_output:= (SELECT STRING_AGG(

XMLELEMENT(name "WC:WaDECatalog", XMLATTRIBUTES(namespace as "xmlns:WC"),
	XMLELEMENT(name "WC:Organization",
	XMLCONCAT((SELECT XMLFOREST
			("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
			"ORGANIZATION_NAME" AS "WC:OrganizationName", 
			"WADE_URL" AS "WC:WaDEURLAddress",			
			"PURVUE_DESC" AS "WC:PurviewDescription")),
			XMLELEMENT(name "WC:Contact",
				(SELECT XMLFOREST
					("FIRST_NAME" AS "WC:FirstName",
					"MIDDLE_INITIAL" AS "WC:MiddleInitial",
					"LAST_NAME" AS "WC:LastName", 
					"TITLE" AS "WC:IndividualTitleText", 
					"EMAIL" AS "WC:EmailAddressText", 
					"PHONE" AS "WC:TelephoneNumberText", 
					"PHONE_EXT" AS "WC:PhoneExtensionText", 
					"FAX" AS "WC:FaxNumberText")),
					XMLELEMENT(name "WC:MailingAddress",
						(SELECT XMLFOREST
							("ADDRESS" AS "WC:MailingAddressText",
							"ADDRESS_EXT" AS "WC:SupplementalAddressText", 
							"CITY" AS "WC:MailingAddressCityName", 
							"STATE" AS "WC:MailingAddressStateUSPSCode", 
							"COUNTRY" AS "WC:MailingAddressCountryCode", 
							"ZIPCODE" AS "WC:MailingAddressZIPCode")
						))	
				),
			(SELECT "WADE_R"."ReportCatalog"("ORGANIZATION_ID",loctype,loctxt))
		)
	)
	)::text,'')

	FROM "WADE"."ORGANIZATION" A WHERE EXISTS(SELECT B."ORGANIZATION_ID" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND B."STATE"=state AND B."COUNTY_FIPS"=loctxt AND B."ORGANIZATION_ID"=orgid));

END IF;

IF loctype='REPORTUNIT' THEN	

text_output:= (SELECT STRING_AGG(

XMLELEMENT(name "WC:WaDECatalog", XMLATTRIBUTES(namespace as "xmlns:WC"),
	XMLELEMENT(name "WC:Organization",
	XMLCONCAT((SELECT XMLFOREST
			("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
			"ORGANIZATION_NAME" AS "WC:OrganizationName", 
			"WADE_URL" AS "WC:WaDEURLAddress",			
			"PURVUE_DESC" AS "WC:PurviewDescription")),
			XMLELEMENT(name "WC:Contact",
				(SELECT XMLFOREST
					("FIRST_NAME" AS "WC:FirstName",
					"MIDDLE_INITIAL" AS "WC:MiddleInitial",
					"LAST_NAME" AS "WC:LastName", 
					"TITLE" AS "WC:IndividualTitleText", 
					"EMAIL" AS "WC:EmailAddressText", 
					"PHONE" AS "WC:TelephoneNumberText", 
					"PHONE_EXT" AS "WC:PhoneExtensionText", 
					"FAX" AS "WC:FaxNumberText")),
					XMLELEMENT(name "WC:MailingAddress",
						(SELECT XMLFOREST
							("ADDRESS" AS "WC:MailingAddressText",
							"ADDRESS_EXT" AS "WC:SupplementalAddressText", 
							"CITY" AS "WC:MailingAddressCityName", 
							"STATE" AS "WC:MailingAddressStateUSPSCode", 
							"COUNTRY" AS "WC:MailingAddressCountryCode", 
							"ZIPCODE" AS "WC:MailingAddressZIPCode")
						))	
				),
			(SELECT "WADE_R"."ReportCatalog"("ORGANIZATION_ID",loctype,loctxt))
		)
	)
	)::text,'')

	FROM "WADE"."ORGANIZATION" A WHERE EXISTS(SELECT B."ORGANIZATION_ID" FROM "WADE_R"."CATALOG_SUMMARY_MV" B WHERE A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND B."STATE"=state AND B."REPORT_UNIT_ID"=loctxt AND B."ORGANIZATION_ID"=orgid));
END IF;
END IF;	
END IF;

RETURN;	

END



  $BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."GetCatalog"(character varying, character varying, character varying, numeric)
  OWNER TO admin;
