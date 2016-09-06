-- Table: "WADE"."SUMMARY_WATER_SUPPLY"

-- DROP TABLE "WADE"."SUMMARY_WATER_SUPPLY";

CREATE TABLE "WADE"."SUMMARY_WATER_SUPPLY"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- unique identifier assigned to the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the report by the organization.
  "REPORT_UNIT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the reporting unit by the organization.
  "SUMMARY_SEQ" numeric(18,0) NOT NULL, -- A unique identifier for the summary.
  "WATER_SUPPLY_TYPE" numeric(18,0) NOT NULL, -- Name of the water supply type (i.e. flow, storage, etc.)
  "WFS_FEATURE_REF" character varying(35),
  CONSTRAINT "PK_SUMMARY_WATER_SUPPLY" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID", "SUMMARY_SEQ"),
  CONSTRAINT "FK_SUMMARY_WATER_SUPPLY-LU_WATER_SUPPLY_TYPE" FOREIGN KEY ("WATER_SUPPLY_TYPE")
      REFERENCES "WADE"."LU_WATER_SUPPLY_TYPE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_SUMMARY_WATER_SUPPLY-REPORTING_UNIT" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID")
      REFERENCES "WADE"."REPORTING_UNIT" ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."SUMMARY_WATER_SUPPLY"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."SUMMARY_WATER_SUPPLY"
  IS 'Summary of derived water supply within the reporting unit for the reporting year.';
COMMENT ON COLUMN "WADE"."SUMMARY_WATER_SUPPLY"."ORGANIZATION_ID" IS 'unique identifier assigned to the organization.';
COMMENT ON COLUMN "WADE"."SUMMARY_WATER_SUPPLY"."REPORT_ID" IS 'A unique identifier assigned to the report by the organization.';
COMMENT ON COLUMN "WADE"."SUMMARY_WATER_SUPPLY"."REPORT_UNIT_ID" IS 'A unique identifier assigned to the reporting unit by the organization.';
COMMENT ON COLUMN "WADE"."SUMMARY_WATER_SUPPLY"."SUMMARY_SEQ" IS 'A unique identifier for the summary.';
COMMENT ON COLUMN "WADE"."SUMMARY_WATER_SUPPLY"."WATER_SUPPLY_TYPE" IS 'Name of the water supply type (i.e. flow, storage, etc.)';


-- Index: "WADE"."FKI_SUMMARY_WATER_SUPPLY-LU_WATER_SUPPLY_TYPE"

-- DROP INDEX "WADE"."FKI_SUMMARY_WATER_SUPPLY-LU_WATER_SUPPLY_TYPE";

CREATE INDEX "FKI_SUMMARY_WATER_SUPPLY-LU_WATER_SUPPLY_TYPE"
  ON "WADE"."SUMMARY_WATER_SUPPLY"
  USING btree
  ("WATER_SUPPLY_TYPE");

-- Index: "WADE"."FKI_SUMMARY_WATER_SUPPLY-REPORTING_UNIT"

-- DROP INDEX "WADE"."FKI_SUMMARY_WATER_SUPPLY-REPORTING_UNIT";

CREATE INDEX "FKI_SUMMARY_WATER_SUPPLY-REPORTING_UNIT"
  ON "WADE"."SUMMARY_WATER_SUPPLY"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "REPORT_UNIT_ID" COLLATE pg_catalog."default");

