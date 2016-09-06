-- Table: "WADE"."ORGANIZATION"

-- DROP TABLE "WADE"."ORGANIZATION";

CREATE TABLE "WADE"."ORGANIZATION"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- Unique identifier assigned to the organziation.
  "ORGANIZATION_NAME" character varying(150) NOT NULL, -- Name corresponding to the unique organization ID.
  "PURVUE_DESC" character varying(250), -- A description of the perview of the agency (i.e. water rights, consumptive use, planning, etc.)
  "FIRST_NAME" character varying(15) NOT NULL, -- First name of the contact person.
  "MIDDLE_INITIAL" character(1),
  "LAST_NAME" character varying(15) NOT NULL, -- last name of a person
  "TITLE" character varying(45), -- Title of the contact person.
  "EMAIL" character varying(240), -- email address
  "PHONE" character varying(15), -- Telephone number.
  "PHONE_EXT" character varying(6), -- Phone number extension.
  "FAX" character(15), -- Fax number
  "ADDRESS" character varying(30), -- Mailing adress
  "ADDRESS_EXT" character varying(30), -- Additional address information.
  "CITY" character varying(25), -- City or locality name.
  "STATE" character(2), -- State USPS code (i.e. KS)
  "COUNTRY" character(2), -- Country Code
  "ZIPCODE" character varying(14), -- ZIP CODE
  "WADE_URL" character varying(300),
  CONSTRAINT "PK_ORGANIZATION" PRIMARY KEY ("ORGANIZATION_ID")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."ORGANIZATION"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."ORGANIZATION"
  IS 'Organization responsible for the data reported.';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."ORGANIZATION_ID" IS 'Unique identifier assigned to the organziation.';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."ORGANIZATION_NAME" IS 'Name corresponding to the unique organization ID.';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."PURVUE_DESC" IS 'A description of the perview of the agency (i.e. water rights, consumptive use, planning, etc.)';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."FIRST_NAME" IS 'First name of the contact person.';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."LAST_NAME" IS 'last name of a person';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."TITLE" IS 'Title of the contact person.';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."EMAIL" IS 'email address';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."PHONE" IS 'Telephone number.';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."PHONE_EXT" IS 'Phone number extension.';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."FAX" IS 'Fax number';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."ADDRESS" IS 'Mailing adress';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."ADDRESS_EXT" IS 'Additional address information.';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."CITY" IS 'City or locality name.';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."STATE" IS 'State USPS code (i.e. KS)';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."COUNTRY" IS 'Country Code';
COMMENT ON COLUMN "WADE"."ORGANIZATION"."ZIPCODE" IS 'ZIP CODE';

