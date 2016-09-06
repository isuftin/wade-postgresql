-- Table: "WADE"."S_WATER_SUPPLY_AMOUNT"

-- DROP TABLE "WADE"."S_WATER_SUPPLY_AMOUNT";

CREATE TABLE "WADE"."S_WATER_SUPPLY_AMOUNT"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- Unique identifier assigned to the Organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the report by the reporting organization.
  "REPORT_UNIT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the reporting unit by the reporting organization.
  "SUMMARY_SEQ" numeric(18,0) NOT NULL, -- A unique sequence number assigned to the summary set of information for this reporting unit.
  "ROW_SEQ" numeric(18,0) NOT NULL, -- A unique sequence number assigned to this row.
  "AMOUNT" numeric(18,3), -- Value reported, measured, calculated, or estimated
  "METHOD_ID" numeric(18,0) NOT NULL, -- Unique identifier referencing the method.
  "START_DATE" character(5) NOT NULL, -- The start date for the estimate in the format MM/DD.
  "END_DATE" character(5) NOT NULL, -- The end date for the estimate in the format MM/DD.
  CONSTRAINT "PK_S_WATER_SUPPLY_AMOUNT" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID", "SUMMARY_SEQ", "ROW_SEQ"),
  CONSTRAINT "FK_S_WATER_SUPPLY_AMOUNT-METHODS" FOREIGN KEY ("METHOD_ID")
      REFERENCES "WADE"."METHODS" ("METHOD_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_S_WATER_SUPPLY_AMOUNT-SUMMARY_WATER_SUPPLY" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID", "SUMMARY_SEQ")
      REFERENCES "WADE"."SUMMARY_WATER_SUPPLY" ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID", "SUMMARY_SEQ") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."S_WATER_SUPPLY_AMOUNT"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."S_WATER_SUPPLY_AMOUNT"
  IS 'Volume of water available in this reporting unit.';
COMMENT ON COLUMN "WADE"."S_WATER_SUPPLY_AMOUNT"."ORGANIZATION_ID" IS 'Unique identifier assigned to the Organization.';
COMMENT ON COLUMN "WADE"."S_WATER_SUPPLY_AMOUNT"."REPORT_ID" IS 'A unique identifier assigned to the report by the reporting organization.';
COMMENT ON COLUMN "WADE"."S_WATER_SUPPLY_AMOUNT"."REPORT_UNIT_ID" IS 'A unique identifier assigned to the reporting unit by the reporting organization.';
COMMENT ON COLUMN "WADE"."S_WATER_SUPPLY_AMOUNT"."SUMMARY_SEQ" IS 'A unique sequence number assigned to the summary set of information for this reporting unit.';
COMMENT ON COLUMN "WADE"."S_WATER_SUPPLY_AMOUNT"."ROW_SEQ" IS 'A unique sequence number assigned to this row.';
COMMENT ON COLUMN "WADE"."S_WATER_SUPPLY_AMOUNT"."AMOUNT" IS 'Value reported, measured, calculated, or estimated';
COMMENT ON COLUMN "WADE"."S_WATER_SUPPLY_AMOUNT"."METHOD_ID" IS 'Unique identifier referencing the method.';
COMMENT ON COLUMN "WADE"."S_WATER_SUPPLY_AMOUNT"."START_DATE" IS 'The start date for the estimate in the format MM/DD.';
COMMENT ON COLUMN "WADE"."S_WATER_SUPPLY_AMOUNT"."END_DATE" IS 'The end date for the estimate in the format MM/DD.';


-- Index: "WADE"."FKI_S_WATER_SUPPLY_AMOUNT-METHODS"

-- DROP INDEX "WADE"."FKI_S_WATER_SUPPLY_AMOUNT-METHODS";

CREATE INDEX "FKI_S_WATER_SUPPLY_AMOUNT-METHODS"
  ON "WADE"."S_WATER_SUPPLY_AMOUNT"
  USING btree
  ("METHOD_ID");

-- Index: "WADE"."FKI_S_WATER_SUPPLY_AMOUNT-SUMMARY_WATER_SUPPLY"

-- DROP INDEX "WADE"."FKI_S_WATER_SUPPLY_AMOUNT-SUMMARY_WATER_SUPPLY";

CREATE INDEX "FKI_S_WATER_SUPPLY_AMOUNT-SUMMARY_WATER_SUPPLY"
  ON "WADE"."S_WATER_SUPPLY_AMOUNT"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "REPORT_UNIT_ID" COLLATE pg_catalog."default", "SUMMARY_SEQ");

