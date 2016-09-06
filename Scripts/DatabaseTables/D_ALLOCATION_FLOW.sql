-- Table: "WADE"."D_ALLOCATION_FLOW"

-- DROP TABLE "WADE"."D_ALLOCATION_FLOW";

CREATE TABLE "WADE"."D_ALLOCATION_FLOW"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier for the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifer for the report assigned by the reporting organziation.
  "ALLOCATION_ID" character varying(60) NOT NULL, -- Unique identifer for the allocation.
  "DETAIL_SEQ_NO" numeric(18,0) NOT NULL, -- Unique identifier for the detail information.
  "AMOUNT_VOLUME" numeric(18,3), -- Volume of water allocated for this use to this allocation.
  "UNIT_VOLUME" numeric(18,0), -- Volume unit of measure
  "AMOUNT_RATE" numeric(18,3), -- Rate of use allocated for this beneficial use.
  "UNIT_RATE" numeric(18,0), -- Unit of measure.
  "SOURCE_TYPE" numeric(18,0), -- Water source: ground, surface, reuse, total.
  "FRESH_SALINE_IND" numeric(18,0), -- Indicates whether the source is fresh water, saline water, or represents the total of both.
  "ALLOCATION_START" character varying(5), -- Starting date for the allcoation (in MM/DD).
  "ALLOCATION_END" character varying(5), -- Allocation end date as MM/DD.
  "SOURCE_NAME" character varying(60), -- Name of the aquifer for groundwater sources or river basin for surface water sources.
  CONSTRAINT "PK_D_ALLOCATION_FLOW" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "DETAIL_SEQ_NO"),
  CONSTRAINT "FK_D_ALLOCATION_FLOW-DETAIL_ALLOCATION" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID")
      REFERENCES "WADE"."DETAIL_ALLOCATION" ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_ALLOCATION_FLOW-LU_FRESH_SALINE_INDICATOR" FOREIGN KEY ("FRESH_SALINE_IND")
      REFERENCES "WADE"."LU_FRESH_SALINE_INDICATOR" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_ALLOCATION_FLOW-LU_SOURCE_TYPE" FOREIGN KEY ("SOURCE_TYPE")
      REFERENCES "WADE"."LU_SOURCE_TYPE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_ALLOCATION_FLOW-LU_UNITS" FOREIGN KEY ("UNIT_VOLUME")
      REFERENCES "WADE"."LU_UNITS" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_ALLOCATION_FLOW-LU_UNITS1" FOREIGN KEY ("UNIT_RATE")
      REFERENCES "WADE"."LU_UNITS" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."D_ALLOCATION_FLOW"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."D_ALLOCATION_FLOW"
  IS 'The amount of water allocated for this allocaiton.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_FLOW"."ORGANIZATION_ID" IS 'A unique identifier for the organization.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_FLOW"."REPORT_ID" IS 'A unique identifer for the report assigned by the reporting organziation.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_FLOW"."ALLOCATION_ID" IS 'Unique identifer for the allocation.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_FLOW"."DETAIL_SEQ_NO" IS 'Unique identifier for the detail information.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_FLOW"."AMOUNT_VOLUME" IS 'Volume of water allocated for this use to this allocation.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_FLOW"."UNIT_VOLUME" IS 'Volume unit of measure';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_FLOW"."AMOUNT_RATE" IS 'Rate of use allocated for this beneficial use.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_FLOW"."UNIT_RATE" IS 'Unit of measure.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_FLOW"."SOURCE_TYPE" IS 'Water source: ground, surface, reuse, total.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_FLOW"."FRESH_SALINE_IND" IS 'Indicates whether the source is fresh water, saline water, or represents the total of both.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_FLOW"."ALLOCATION_START" IS 'Starting date for the allcoation (in MM/DD).';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_FLOW"."ALLOCATION_END" IS 'Allocation end date as MM/DD.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_FLOW"."SOURCE_NAME" IS 'Name of the aquifer for groundwater sources or river basin for surface water sources.';


-- Index: "WADE"."FKI_D_ALLOCATION_FLOW-DETAIL_ALLOCATION"

-- DROP INDEX "WADE"."FKI_D_ALLOCATION_FLOW-DETAIL_ALLOCATION";

CREATE INDEX "FKI_D_ALLOCATION_FLOW-DETAIL_ALLOCATION"
  ON "WADE"."D_ALLOCATION_FLOW"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "ALLOCATION_ID" COLLATE pg_catalog."default");

-- Index: "WADE"."FKI_D_ALLOCATION_FLOW-LU_FRESH_SALINE_INDICATOR"

-- DROP INDEX "WADE"."FKI_D_ALLOCATION_FLOW-LU_FRESH_SALINE_INDICATOR";

CREATE INDEX "FKI_D_ALLOCATION_FLOW-LU_FRESH_SALINE_INDICATOR"
  ON "WADE"."D_ALLOCATION_FLOW"
  USING btree
  ("FRESH_SALINE_IND");

-- Index: "WADE"."FKI_D_ALLOCATION_FLOW-LU_SOURCE_TYPE"

-- DROP INDEX "WADE"."FKI_D_ALLOCATION_FLOW-LU_SOURCE_TYPE";

CREATE INDEX "FKI_D_ALLOCATION_FLOW-LU_SOURCE_TYPE"
  ON "WADE"."D_ALLOCATION_FLOW"
  USING btree
  ("SOURCE_TYPE");

-- Index: "WADE"."FKI_D_ALLOCATION_FLOW-LU_UNITS"

-- DROP INDEX "WADE"."FKI_D_ALLOCATION_FLOW-LU_UNITS";

CREATE INDEX "FKI_D_ALLOCATION_FLOW-LU_UNITS"
  ON "WADE"."D_ALLOCATION_FLOW"
  USING btree
  ("UNIT_VOLUME");

-- Index: "WADE"."FKI_D_ALLOCATION_FLOW-LU_UNITS1"

-- DROP INDEX "WADE"."FKI_D_ALLOCATION_FLOW-LU_UNITS1";

CREATE INDEX "FKI_D_ALLOCATION_FLOW-LU_UNITS1"
  ON "WADE"."D_ALLOCATION_FLOW"
  USING btree
  ("UNIT_RATE");

