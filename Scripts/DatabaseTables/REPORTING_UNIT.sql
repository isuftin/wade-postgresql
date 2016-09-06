-- Table: "WADE"."REPORTING_UNIT"

-- DROP TABLE "WADE"."REPORTING_UNIT";

CREATE TABLE "WADE"."REPORTING_UNIT"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier for the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- water summary or water detail report.
  "REPORT_UNIT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the reporting unit by the reporting organization.
  "REPORTING_UNIT_NAME" character varying(240) NOT NULL, -- Name of the reporting unit.
  "REPORTING_UNIT_TYPE" character varying(35) NOT NULL, -- The type of unit being reported (i.e. county, HUC-8, user-defined boundary, etc.)
  "STATE" numeric(18,0) NOT NULL, -- code representing the 2 digit abbreviation for the state.
  "COUNTY_FIPS" character(5), -- County FIPS code (including the state FIPS code) representing the county.
  "HUC" character varying(12), -- code representing the USGS Hydrologic Unit Code (or HUC) at the most detailed level that the assignment can be made (6-digit being the lowest level resolution allowed).  Leading 0's should be included.
  CONSTRAINT "PK_REPORTING_UNIT" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID"),
  CONSTRAINT "FK_REPORTING_UNIT-LU_STATE" FOREIGN KEY ("STATE")
      REFERENCES "WADE"."LU_STATE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_REPORTING_UNIT-REPORT" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID")
      REFERENCES "WADE"."REPORT" ("ORGANIZATION_ID", "REPORT_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."REPORTING_UNIT"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."REPORTING_UNIT"
  IS 'The unit for which the allocaiton or estimate is being reported.';
COMMENT ON COLUMN "WADE"."REPORTING_UNIT"."ORGANIZATION_ID" IS 'A unique identifier for the organization.';
COMMENT ON COLUMN "WADE"."REPORTING_UNIT"."REPORT_ID" IS 'water summary or water detail report.';
COMMENT ON COLUMN "WADE"."REPORTING_UNIT"."REPORT_UNIT_ID" IS 'A unique identifier assigned to the reporting unit by the reporting organization.';
COMMENT ON COLUMN "WADE"."REPORTING_UNIT"."REPORTING_UNIT_NAME" IS 'Name of the reporting unit.';
COMMENT ON COLUMN "WADE"."REPORTING_UNIT"."REPORTING_UNIT_TYPE" IS 'The type of unit being reported (i.e. county, HUC-8, user-defined boundary, etc.)';
COMMENT ON COLUMN "WADE"."REPORTING_UNIT"."STATE" IS 'code representing the 2 digit abbreviation for the state.';
COMMENT ON COLUMN "WADE"."REPORTING_UNIT"."COUNTY_FIPS" IS 'County FIPS code (including the state FIPS code) representing the county.';
COMMENT ON COLUMN "WADE"."REPORTING_UNIT"."HUC" IS 'code representing the USGS Hydrologic Unit Code (or HUC) at the most detailed level that the assignment can be made (6-digit being the lowest level resolution allowed).  Leading 0''s should be included.';


-- Index: "WADE"."FKI_REPORTING_UNIT-LU_STATE"

-- DROP INDEX "WADE"."FKI_REPORTING_UNIT-LU_STATE";

CREATE INDEX "FKI_REPORTING_UNIT-LU_STATE"
  ON "WADE"."REPORTING_UNIT"
  USING btree
  ("STATE");

-- Index: "WADE"."FKI_REPORTING_UNIT-REPORT"

-- DROP INDEX "WADE"."FKI_REPORTING_UNIT-REPORT";

CREATE INDEX "FKI_REPORTING_UNIT-REPORT"
  ON "WADE"."REPORTING_UNIT"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default");

