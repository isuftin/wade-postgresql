-- Table: "WADE"."S_AVAILABILITY_METRIC"

-- DROP TABLE "WADE"."S_AVAILABILITY_METRIC";

CREATE TABLE "WADE"."S_AVAILABILITY_METRIC"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- Unique identifier assigned to the Organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the report by the reporting organization.
  "REPORT_UNIT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the reporting unit by the reporting organization.
  "SUMMARY_SEQ" numeric(18,0) NOT NULL, -- A unique sequence number assigned to the summary set of information for this reporting unit.
  "ROW_SEQ" numeric(18,0) NOT NULL, -- A unique sequence number assigned to this row.
  "METRIC_ID" numeric(18,0), -- Unique identifier referencing the metric.
  "METRIC_VALUE" numeric(18,3), -- Value of the metric.  Higher numbers should indicate more relative availability.
  "METRIC_SCALE" numeric(18,3), -- Highest allowed value for the metric.
  "REVERSE_SCALE_IND" character(1), -- This should be marked with a "Y" if the scale is reversed (i.e. higher numbers indicate less availability).
  "METHOD_ID" numeric(18,0) NOT NULL,
  "START_DATE" character(5) NOT NULL, -- The start date for the estimate in the format MM/DD.
  "END_DATE" character(5) NOT NULL, -- The end date for the estimate in the format MM/DD.
  CONSTRAINT "PK_S_AVAILABILITY_METRIC" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID", "SUMMARY_SEQ", "ROW_SEQ"),
  CONSTRAINT "FK_S_AVAILABILITY_METRIC-METHODS" FOREIGN KEY ("METHOD_ID")
      REFERENCES "WADE"."METHODS" ("METHOD_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_S_AVAILABILITY_METRIC-METRICS" FOREIGN KEY ("METRIC_ID")
      REFERENCES "WADE"."METRICS" ("METRIC_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_S_AVAILABILITY_METRIC-SUMMARY_AVAILABILITY" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID", "SUMMARY_SEQ")
      REFERENCES "WADE"."SUMMARY_AVAILABILITY" ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID", "SUMMARY_SEQ") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."S_AVAILABILITY_METRIC"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."S_AVAILABILITY_METRIC"
  IS 'Volume of water available in this reporting unit.';
COMMENT ON COLUMN "WADE"."S_AVAILABILITY_METRIC"."ORGANIZATION_ID" IS 'Unique identifier assigned to the Organization.';
COMMENT ON COLUMN "WADE"."S_AVAILABILITY_METRIC"."REPORT_ID" IS 'A unique identifier assigned to the report by the reporting organization.';
COMMENT ON COLUMN "WADE"."S_AVAILABILITY_METRIC"."REPORT_UNIT_ID" IS 'A unique identifier assigned to the reporting unit by the reporting organization.';
COMMENT ON COLUMN "WADE"."S_AVAILABILITY_METRIC"."SUMMARY_SEQ" IS 'A unique sequence number assigned to the summary set of information for this reporting unit.';
COMMENT ON COLUMN "WADE"."S_AVAILABILITY_METRIC"."ROW_SEQ" IS 'A unique sequence number assigned to this row.';
COMMENT ON COLUMN "WADE"."S_AVAILABILITY_METRIC"."METRIC_ID" IS 'Unique identifier referencing the metric.';
COMMENT ON COLUMN "WADE"."S_AVAILABILITY_METRIC"."METRIC_VALUE" IS 'Value of the metric.  Higher numbers should indicate more relative availability.';
COMMENT ON COLUMN "WADE"."S_AVAILABILITY_METRIC"."METRIC_SCALE" IS 'Highest allowed value for the metric.';
COMMENT ON COLUMN "WADE"."S_AVAILABILITY_METRIC"."REVERSE_SCALE_IND" IS 'This should be marked with a "Y" if the scale is reversed (i.e. higher numbers indicate less availability).';
COMMENT ON COLUMN "WADE"."S_AVAILABILITY_METRIC"."START_DATE" IS 'The start date for the estimate in the format MM/DD.';
COMMENT ON COLUMN "WADE"."S_AVAILABILITY_METRIC"."END_DATE" IS 'The end date for the estimate in the format MM/DD.';


-- Index: "WADE"."FKI_S_AVAILABILITY_METRIC-METHODS"

-- DROP INDEX "WADE"."FKI_S_AVAILABILITY_METRIC-METHODS";

CREATE INDEX "FKI_S_AVAILABILITY_METRIC-METHODS"
  ON "WADE"."S_AVAILABILITY_METRIC"
  USING btree
  ("METHOD_ID");

-- Index: "WADE"."FKI_S_AVAILABILITY_METRIC-METRICS"

-- DROP INDEX "WADE"."FKI_S_AVAILABILITY_METRIC-METRICS";

CREATE INDEX "FKI_S_AVAILABILITY_METRIC-METRICS"
  ON "WADE"."S_AVAILABILITY_METRIC"
  USING btree
  ("METRIC_ID");

-- Index: "WADE"."FKI_S_AVAILABILITY_METRIC-SUMMARY_AVAILABILITY"

-- DROP INDEX "WADE"."FKI_S_AVAILABILITY_METRIC-SUMMARY_AVAILABILITY";

CREATE INDEX "FKI_S_AVAILABILITY_METRIC-SUMMARY_AVAILABILITY"
  ON "WADE"."S_AVAILABILITY_METRIC"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "REPORT_UNIT_ID" COLLATE pg_catalog."default", "SUMMARY_SEQ");

