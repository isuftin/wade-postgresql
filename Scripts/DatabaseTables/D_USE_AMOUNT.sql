-- Table: "WADE"."D_USE_AMOUNT"

-- DROP TABLE "WADE"."D_USE_AMOUNT";

CREATE TABLE "WADE"."D_USE_AMOUNT"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier for the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier for the report assigned by the reporting organization.
  "ALLOCATION_ID" character varying(60) NOT NULL, -- Unique identifier for the allocation.
  "WATER_USER_ID" character varying(50) NOT NULL,
  "BENEFICIAL_USE_ID" numeric(18,0) NOT NULL,
  "ROW_SEQ" numeric(18,0) NOT NULL, -- Unique identifier for this row of information.
  "AMOUNT_VOLUME" numeric(18,3), -- Volume of water actually diverted at this diversion.
  "UNIT_VOLUME" numeric(18,0), -- Volume unit of measure
  "VALUE_TYPE_VOLUME" numeric(18,0), -- Indicator on how the actual amount was determined
  "METHOD_ID_VOLUME" numeric(18,0), -- ID referencing the method used to estimate the volume
  "START_DATE" character varying(5), -- Starting date for the amount (in MM/DD).
  "END_DATE" character varying(5), -- Ending date for the amount as MM/DD.
  CONSTRAINT "PK_D_USE_AMOUNT" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "WATER_USER_ID", "BENEFICIAL_USE_ID", "ROW_SEQ"),
  CONSTRAINT "FK_D_USE_AMOUNT-D_CONSUMPTIVE_USE" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "WATER_USER_ID", "BENEFICIAL_USE_ID")
      REFERENCES "WADE"."D_CONSUMPTIVE_USE" ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "WATER_USER_ID", "BENEFICIAL_USE_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_USE_AMOUNT-LU_UNITS" FOREIGN KEY ("UNIT_VOLUME")
      REFERENCES "WADE"."LU_UNITS" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_USE_AMOUNT-LU_VALUE_TYPE" FOREIGN KEY ("VALUE_TYPE_VOLUME")
      REFERENCES "WADE"."LU_VALUE_TYPE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_USE_AMOUNT-METHODS" FOREIGN KEY ("METHOD_ID_VOLUME")
      REFERENCES "WADE"."METHODS" ("METHOD_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."D_USE_AMOUNT"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."D_USE_AMOUNT"
  IS 'The amount of water actually used for this use by this allocation.';
COMMENT ON COLUMN "WADE"."D_USE_AMOUNT"."ORGANIZATION_ID" IS 'A unique identifier for the organization.';
COMMENT ON COLUMN "WADE"."D_USE_AMOUNT"."REPORT_ID" IS 'A unique identifier for the report assigned by the reporting organization.';
COMMENT ON COLUMN "WADE"."D_USE_AMOUNT"."ALLOCATION_ID" IS 'Unique identifier for the allocation.';
COMMENT ON COLUMN "WADE"."D_USE_AMOUNT"."ROW_SEQ" IS 'Unique identifier for this row of information.';
COMMENT ON COLUMN "WADE"."D_USE_AMOUNT"."AMOUNT_VOLUME" IS 'Volume of water actually diverted at this diversion.';
COMMENT ON COLUMN "WADE"."D_USE_AMOUNT"."UNIT_VOLUME" IS 'Volume unit of measure';
COMMENT ON COLUMN "WADE"."D_USE_AMOUNT"."VALUE_TYPE_VOLUME" IS 'Indicator on how the actual amount was determined';
COMMENT ON COLUMN "WADE"."D_USE_AMOUNT"."METHOD_ID_VOLUME" IS 'ID referencing the method used to estimate the volume';
COMMENT ON COLUMN "WADE"."D_USE_AMOUNT"."START_DATE" IS 'Starting date for the amount (in MM/DD).';
COMMENT ON COLUMN "WADE"."D_USE_AMOUNT"."END_DATE" IS 'Ending date for the amount as MM/DD.';


-- Index: "WADE"."FKI_D_USE_AMOUNT-D_CONSUMPTIVE_USE"

-- DROP INDEX "WADE"."FKI_D_USE_AMOUNT-D_CONSUMPTIVE_USE";

CREATE INDEX "FKI_D_USE_AMOUNT-D_CONSUMPTIVE_USE"
  ON "WADE"."D_USE_AMOUNT"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "ALLOCATION_ID" COLLATE pg_catalog."default", "WATER_USER_ID" COLLATE pg_catalog."default", "BENEFICIAL_USE_ID");

-- Index: "WADE"."FKI_D_USE_AMOUNT-LU_UNITS"

-- DROP INDEX "WADE"."FKI_D_USE_AMOUNT-LU_UNITS";

CREATE INDEX "FKI_D_USE_AMOUNT-LU_UNITS"
  ON "WADE"."D_USE_AMOUNT"
  USING btree
  ("UNIT_VOLUME");

-- Index: "WADE"."FKI_D_USE_AMOUNT-LU_VALUE_TYPE"

-- DROP INDEX "WADE"."FKI_D_USE_AMOUNT-LU_VALUE_TYPE";

CREATE INDEX "FKI_D_USE_AMOUNT-LU_VALUE_TYPE"
  ON "WADE"."D_USE_AMOUNT"
  USING btree
  ("VALUE_TYPE_VOLUME");

-- Index: "WADE"."FKI_D_USE_AMOUNT-METHODS"

-- DROP INDEX "WADE"."FKI_D_USE_AMOUNT-METHODS";

CREATE INDEX "FKI_D_USE_AMOUNT-METHODS"
  ON "WADE"."D_USE_AMOUNT"
  USING btree
  ("METHOD_ID_VOLUME");

