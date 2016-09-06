-- Table: "WADE"."SUMMARY_REGULATORY"

-- DROP TABLE "WADE"."SUMMARY_REGULATORY";

CREATE TABLE "WADE"."SUMMARY_REGULATORY"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- Unique identifier assigned to the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- Unique identifier assigned to the report by the organization.
  "REPORT_UNIT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the reporting unit by the organization.
  "SUMMARY_SEQ" numeric(18,0) NOT NULL, -- A unique identifier assigned to the summary.
  "REGULATORY_TYPE" character varying(50) NOT NULL, -- Name of the type of restriction on surface water, groundwater, or reuse.
  "REGULATORY_STATUS" numeric(18,0) NOT NULL, -- Description of the regulatory status in the reporting unit (i.e. open, closed, partial, etc.)
  "OVERSIGHT_AGENCY" character varying(60), -- Name of the special management district or oversight committee/basin group.
  "REGULATORY_DESCRIPTION" character varying(255), -- Description of the regulatory restriction.
  "WFS_FEATURE_REF" character varying(35),
  CONSTRAINT "PK_SUMMARY_REGULATORY" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID", "SUMMARY_SEQ"),
  CONSTRAINT "FK_REGULATORY_SUMMARY-REPORTING_UNIT" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID")
      REFERENCES "WADE"."REPORTING_UNIT" ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_SUMMARY_REGULATORY-LU_REGULATORY_STATUS" FOREIGN KEY ("REGULATORY_STATUS")
      REFERENCES "WADE"."LU_REGULATORY_STATUS" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."SUMMARY_REGULATORY"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."SUMMARY_REGULATORY"
  IS 'Summary of regulatory status for the reporting unit.';
COMMENT ON COLUMN "WADE"."SUMMARY_REGULATORY"."ORGANIZATION_ID" IS 'Unique identifier assigned to the organization.';
COMMENT ON COLUMN "WADE"."SUMMARY_REGULATORY"."REPORT_ID" IS 'Unique identifier assigned to the report by the organization.';
COMMENT ON COLUMN "WADE"."SUMMARY_REGULATORY"."REPORT_UNIT_ID" IS 'A unique identifier assigned to the reporting unit by the organization.';
COMMENT ON COLUMN "WADE"."SUMMARY_REGULATORY"."SUMMARY_SEQ" IS 'A unique identifier assigned to the summary.';
COMMENT ON COLUMN "WADE"."SUMMARY_REGULATORY"."REGULATORY_TYPE" IS 'Name of the type of restriction on surface water, groundwater, or reuse.';
COMMENT ON COLUMN "WADE"."SUMMARY_REGULATORY"."REGULATORY_STATUS" IS 'Description of the regulatory status in the reporting unit (i.e. open, closed, partial, etc.)';
COMMENT ON COLUMN "WADE"."SUMMARY_REGULATORY"."OVERSIGHT_AGENCY" IS 'Name of the special management district or oversight committee/basin group.';
COMMENT ON COLUMN "WADE"."SUMMARY_REGULATORY"."REGULATORY_DESCRIPTION" IS 'Description of the regulatory restriction.';


-- Index: "WADE"."FKI_REGULATORY_SUMMARY-REPORTING_UNIT"

-- DROP INDEX "WADE"."FKI_REGULATORY_SUMMARY-REPORTING_UNIT";

CREATE INDEX "FKI_REGULATORY_SUMMARY-REPORTING_UNIT"
  ON "WADE"."SUMMARY_REGULATORY"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "REPORT_UNIT_ID" COLLATE pg_catalog."default");

-- Index: "WADE"."FKI_SUMMARY_REGULATORY-LU_REGULATORY_STATUS"

-- DROP INDEX "WADE"."FKI_SUMMARY_REGULATORY-LU_REGULATORY_STATUS";

CREATE INDEX "FKI_SUMMARY_REGULATORY-LU_REGULATORY_STATUS"
  ON "WADE"."SUMMARY_REGULATORY"
  USING btree
  ("REGULATORY_STATUS");

