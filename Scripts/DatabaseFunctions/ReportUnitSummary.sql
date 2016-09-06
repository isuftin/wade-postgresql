-- Function: "WADE_R"."ReportUnitSummary"(text, text, text, text, text)

-- DROP FUNCTION "WADE_R"."ReportUnitSummary"(text, text, text, text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."ReportUnitSummary"(
    IN orgid text,
    IN reportid text,
    IN loctype text,
    IN loctxt text,
    IN datatype text,
    OUT tmp_output xml)
  RETURNS xml AS
$BODY$


BEGIN

IF datatype <>'ALL' THEN	

IF loctype='HUC' THEN



	tmp_output:=(SELECT STRING_AGG
		(XMLELEMENT
			(name "WC:ReportingUnit",XMLCONCAT
				(
					(SELECT XMLFOREST
						("REPORT_UNIT_ID" AS "WC:ReportingUnitIdentifier", 
						"REPORTING_UNIT_NAME" as "WC:ReportingUnitName", 	
						"REPORTING_UNIT_TYPE" AS "WC:ReportingUnitTypeName")
					), 
					XMLELEMENT
						(name "WC:Location",
							(SELECT XMLFOREST
								(B."VALUE" AS "WC:StateCode", 
								"COUNTY_FIPS" AS "WC:CountyFipsCode", 
								"HUC" AS "WC:HydrologicUnitCode")
							)
						),
						(SELECT CASE WHEN datatype='AVAILABILITY' THEN 
							(SELECT "WADE_R"."XML_AVAILABILITY_SUMMARY"
								(orgid,"REPORT_ID","REPORT_UNIT_ID")
							)
						WHEN datatype='ALLOCATION' THEN 
							(SELECT "WADE_R"."XML_ALLOCATION_SUMMARY"
								(orgid, "REPORT_ID", "REPORT_UNIT_ID")
						)
						WHEN datatype='USE' THEN 
							(SELECT "WADE_R"."XML_USE_SUMMARY"
								(orgid, "REPORT_ID", "REPORT_UNIT_ID")
							)
						WHEN datatype='SUPPLY' THEN 
							(SELECT "WADE_R"."XML_SUPPLY_SUMMARY"
								(orgid, "REPORT_ID", "REPORT_UNIT_ID")
							)
						WHEN datatype='REGULATORY' THEN 
							(SELECT "WADE_R"."XML_REGULATORY_SUMMARY"
								(orgid, "REPORT_ID", "REPORT_UNIT_ID")
							)END
						)
				)
			)::text,''
		)

	FROM 

	"WADE"."REPORTING_UNIT" A LEFT OUTER JOIN "WADE"."LU_STATE" B ON (A."STATE"=B."LU_SEQ_NO") WHERE EXISTS 
	(SELECT B."REPORT_UNIT_ID" FROM "WADE_R"."SUMMARY_LOCATION_MV" B WHERE
	A."ORGANIZATION_ID"=B."ORGANIZATION_ID" 
	AND A."REPORT_ID"=B."REPORT_ID" 
	AND A."REPORT_UNIT_ID"=B."REPORT_UNIT_ID" 
	AND B."ORGANIZATION_ID"=orgid 
	AND B."REPORT_ID"=reportid 
	AND B."HUC"=loctxt 
	AND B."DATATYPE"=datatype) 
	AND A."ORGANIZATION_ID"=orgid 
	AND A."REPORT_ID"=reportid);

END IF;



IF loctype='COUNTY' THEN



	tmp_output:=(SELECT STRING_AGG(XMLELEMENT(name "WC:ReportingUnit",XMLCONCAT((SELECT XMLFOREST("REPORT_UNIT_ID" AS 

	"WC:ReportingUnitIdentifier", "REPORTING_UNIT_NAME" as "WC:ReportingUnitName", 

	"REPORTING_UNIT_TYPE" AS "WC:ReportingUnitTypeName")), XMLELEMENT(name "WC:Location", 

	(SELECT XMLFOREST(B."VALUE" AS "WC:StateCode", "COUNTY_FIPS" AS "WC:CountyFipsCode", "HUC" AS 

	"WC:HydrologicUnitCode"))),

	(SELECT CASE WHEN datatype='AVAILABILITY' THEN (SELECT "WADE_R"."XML_AVAILABILITY_SUMMARY"(orgid,"REPORT_ID","REPORT_UNIT_ID"))

	WHEN datatype='ALLOCATION' THEN (SELECT "WADE_R"."XML_ALLOCATION_SUMMARY"(orgid, "REPORT_ID", "REPORT_UNIT_ID"))

	WHEN datatype='USE' THEN (SELECT "WADE_R"."XML_USE_SUMMARY"(orgid, "REPORT_ID", "REPORT_UNIT_ID"))

	WHEN datatype='SUPPLY' THEN (SELECT "WADE_R"."XML_SUPPLY_SUMMARY"(orgid, "REPORT_ID", "REPORT_UNIT_ID"))

	WHEN datatype='REGULATORY' THEN (SELECT "WADE_R"."XML_REGULATORY_SUMMARY"(orgid, "REPORT_ID", "REPORT_UNIT_ID")) END)

	))::text,'')

	FROM 

	"WADE"."REPORTING_UNIT" A LEFT OUTER JOIN "WADE"."LU_STATE" B ON (A."STATE"=B."LU_SEQ_NO") WHERE EXISTS(SELECT B."REPORT_UNIT_ID" FROM "WADE_R"."SUMMARY_LOCATION_MV" B WHERE

	A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND A."REPORT_ID"=B."REPORT_ID" AND A."REPORT_UNIT_ID"=B."REPORT_UNIT_ID" AND B."ORGANIZATION_ID"=orgid AND B."REPORT_ID"=reportid AND 

	B."COUNTY_FIPS"=loctxt AND B."DATATYPE"=datatype) AND A."ORGANIZATION_ID"=orgid AND A."REPORT_ID"=reportid);

END IF;



IF loctype='REPORTUNIT' THEN



	tmp_output:=(SELECT STRING_AGG(XMLELEMENT(name "WC:ReportingUnit",XMLCONCAT((SELECT XMLFOREST("REPORT_UNIT_ID" AS 

	"WC:ReportingUnitIdentifier", "REPORTING_UNIT_NAME" as "WC:ReportingUnitName", 

	"REPORTING_UNIT_TYPE" AS "WC:ReportingUnitTypeName")), XMLELEMENT(name "WC:Location", 

	(SELECT XMLFOREST(B."VALUE" AS "WC:StateCode", "COUNTY_FIPS" AS "WC:CountyFipsCode", "HUC" AS 

	"WC:HydrologicUnitCode"))),

	(SELECT CASE WHEN datatype='AVAILABILITY' THEN (SELECT "WADE_R"."XML_AVAILABILITY_SUMMARY"(orgid,"REPORT_ID","REPORT_UNIT_ID"))

	WHEN datatype='ALLOCATION' THEN (SELECT "WADE_R"."XML_ALLOCATION_SUMMARY"(orgid, "REPORT_ID", "REPORT_UNIT_ID"))

	WHEN datatype='USE' THEN (SELECT "WADE_R"."XML_USE_SUMMARY"(orgid, "REPORT_ID", "REPORT_UNIT_ID"))

	WHEN datatype='SUPPLY' THEN (SELECT "WADE_R"."XML_SUPPLY_SUMMARY"(orgid, "REPORT_ID", "REPORT_UNIT_ID"))

	WHEN datatype='REGULATORY' THEN (SELECT "WADE_R"."XML_REGULATORY_SUMMARY"(orgid, "REPORT_ID", "REPORT_UNIT_ID")) END)

	))::text,'')

	FROM 

	"WADE"."REPORTING_UNIT" A LEFT OUTER JOIN "WADE"."LU_STATE" B ON (A."STATE"=B."LU_SEQ_NO") WHERE EXISTS(SELECT B."REPORT_UNIT_ID" FROM "WADE_R"."SUMMARY_LOCATION_MV" B WHERE

	A."ORGANIZATION_ID"=B."ORGANIZATION_ID" AND A."REPORT_ID"=B."REPORT_ID" AND A."REPORT_UNIT_ID"=B."REPORT_UNIT_ID" AND B."ORGANIZATION_ID"=orgid AND B."REPORT_ID"=reportid AND 

	B."REPORT_UNIT_ID"=loctxt AND B."DATATYPE"=datatype) AND A."ORGANIZATION_ID"=orgid AND A."REPORT_ID"=reportid);

END IF;

ELSE

IF loctype='HUC' THEN

	tmp_output:=(SELECT STRING_AGG
		(XMLELEMENT
			(name "WC:ReportingUnit",
			XMLCONCAT (
					(SELECT XMLFOREST
						("REPORT_UNIT_ID" AS "WC:ReportingUnitIdentifier",
						"REPORTING_UNIT_NAME" as "WC:ReportingUnitName", 
						"REPORTING_UNIT_TYPE" AS "WC:ReportingUnitTypeName")
					),
					XMLELEMENT
						(name "WC:Location", 
						  
							(SELECT XMLFOREST
								(B."VALUE" AS "WC:StateCode", 
								"COUNTY_FIPS" AS "WC:CountyFipsCode", 
								"HUC" AS "WC:HydrologicUnitCode")
							)
						),
						(SELECT "WADE_R"."XML_AVAILABILITY_SUMMARY"
							(orgid,"REPORT_ID","REPORT_UNIT_ID")
						),							
						(SELECT "WADE_R"."XML_ALLOCATION_SUMMARY"
							(orgid, "REPORT_ID", "REPORT_UNIT_ID")
						),
						(SELECT "WADE_R"."XML_USE_SUMMARY"
							(orgid, "REPORT_ID", "REPORT_UNIT_ID")
						),
						(SELECT "WADE_R"."XML_SUPPLY_SUMMARY"
							(orgid, "REPORT_ID", "REPORT_UNIT_ID")
						),
						(SELECT "WADE_R"."XML_REGULATORY_SUMMARY"
							(orgid, "REPORT_ID", "REPORT_UNIT_ID")
						)
				)  
			
				
			)::text,''
		)
	

	FROM 

	"WADE"."REPORTING_UNIT" A LEFT OUTER JOIN "WADE"."LU_STATE" B ON (A."STATE"=B."LU_SEQ_NO") WHERE EXISTS 
	(SELECT B."REPORT_UNIT_ID" FROM "WADE_R"."SUMMARY_LOCATION_MV" B WHERE 
	A."ORGANIZATION_ID"=B."ORGANIZATION_ID" 
	AND A."REPORT_ID"=B."REPORT_ID" 
	AND A."REPORT_UNIT_ID"=B."REPORT_UNIT_ID" 
	AND B."ORGANIZATION_ID"=orgid 
	AND B."REPORT_ID"=reportid 
	AND B."HUC"=loctxt)
	AND A."ORGANIZATION_ID"=orgid
	AND A."REPORT_ID"=reportid);

END IF;

IF loctype='COUNTY' THEN

tmp_output:=(SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:ReportingUnit",
		XMLCONCAT(
			(SELECT XMLFOREST
				("REPORT_UNIT_ID" AS "WC:ReportingUnitIdentifier",
				 "REPORTING_UNIT_NAME" as "WC:ReportingUnitName", 
				"REPORTING_UNIT_TYPE" AS "WC:ReportingUnitTypeName")
			),
			XMLELEMENT(name "WC:Location", 
				(SELECT XMLFOREST
					(B."VALUE" AS "WC:StateCode",
					"COUNTY_FIPS" AS "WC:CountyFipsCode",
					"HUC" AS "WC:HydrologicUnitCode")
				)
				),
				(SELECT "WADE_R"."XML_AVAILABILITY_SUMMARY"
					(orgid,"REPORT_ID","REPORT_UNIT_ID")
				),
				(SELECT "WADE_R"."XML_ALLOCATION_SUMMARY"
					(orgid, "REPORT_ID", "REPORT_UNIT_ID")
				),
				(SELECT "WADE_R"."XML_USE_SUMMARY"
					(orgid, "REPORT_ID", "REPORT_UNIT_ID")
				),
				(SELECT "WADE_R"."XML_SUPPLY_SUMMARY"
					(orgid, "REPORT_ID", "REPORT_UNIT_ID")
				),
				(SELECT "WADE_R"."XML_REGULATORY_SUMMARY"
					(orgid, "REPORT_ID", "REPORT_UNIT_ID")
				) 
			)
		)::text,''
	)

	FROM 

	"WADE"."REPORTING_UNIT" A LEFT OUTER JOIN "WADE"."LU_STATE" B ON (A."STATE"=B."LU_SEQ_NO") WHERE EXISTS (SELECT B."REPORT_UNIT_ID" FROM "WADE_R"."SUMMARY_LOCATION_MV" B WHERE

	A."ORGANIZATION_ID"=B."ORGANIZATION_ID" 
	AND A."REPORT_ID"=B."REPORT_ID" 
	AND A."REPORT_UNIT_ID"=B."REPORT_UNIT_ID" 
	AND B."ORGANIZATION_ID"=orgid 
	AND B."REPORT_ID"=reportid 
	AND B."COUNTY_FIPS"=loctxt)
	AND A."ORGANIZATION_ID"=orgid
	AND A."REPORT_ID"=reportid);
	
END IF;

IF loctype='REPORTUNIT' THEN


	tmp_output:=(SELECT STRING_AGG
			(XMLELEMENT
				(name "WC:ReportingUnit",
				XMLCONCAT(
					(SELECT XMLFOREST
						("REPORT_UNIT_ID" AS "WC:ReportingUnitIdentifier", 
						"REPORTING_UNIT_NAME" as "WC:ReportingUnitName",
						"REPORTING_UNIT_TYPE" AS "WC:ReportingUnitTypeName")
					),
					XMLELEMENT(name "WC:Location", 
						(SELECT XMLFOREST
							(B."VALUE" AS "WC:StateCode",
							"COUNTY_FIPS" AS "WC:CountyFipsCode",
							"HUC" AS "WC:HydrologicUnitCode")
						)
						),
						(SELECT "WADE_R"."XML_AVAILABILITY_SUMMARY"
							(orgid,"REPORT_ID","REPORT_UNIT_ID")
						),
						(SELECT "WADE_R"."XML_ALLOCATION_SUMMARY"
							(orgid, "REPORT_ID", "REPORT_UNIT_ID")
						),
						(SELECT "WADE_R"."XML_USE_SUMMARY"
							(orgid, "REPORT_ID", "REPORT_UNIT_ID")
						),
						(SELECT "WADE_R"."XML_SUPPLY_SUMMARY"
							(orgid, "REPORT_ID", "REPORT_UNIT_ID")
						),
						(SELECT "WADE_R"."XML_REGULATORY_SUMMARY"
							(orgid, "REPORT_ID", "REPORT_UNIT_ID")
						) 
					)
				)::text,''
			)
		

	FROM 

	"WADE"."REPORTING_UNIT" A LEFT OUTER JOIN "WADE"."LU_STATE" B ON (A."STATE"=B."LU_SEQ_NO") WHERE EXISTS(SELECT B."REPORT_UNIT_ID" FROM "WADE_R"."SUMMARY_LOCATION_MV" B WHERE

	A."ORGANIZATION_ID"=B."ORGANIZATION_ID"
	AND A."REPORT_ID"=B."REPORT_ID" 
	AND A."REPORT_UNIT_ID"=B."REPORT_UNIT_ID" 
	AND B."ORGANIZATION_ID"=orgid 
	AND B."REPORT_ID"=reportid 
	AND B."REPORT_UNIT_ID"=loctxt)
	AND A."ORGANIZATION_ID"=orgid
	AND A."REPORT_ID"=reportid);
	

END IF;

END IF;	

RETURN;


END



  $BODY$
  LANGUAGE plpgsql STABLE
  COST 1000;
ALTER FUNCTION "WADE_R"."ReportUnitSummary"(text, text, text, text, text)
  OWNER TO "WADE";
