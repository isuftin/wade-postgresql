-- Table: "WADE"."D_THERMOELECTRIC"

-- DROP TABLE "WADE"."D_THERMOELECTRIC";

CREATE TABLE "WADE"."D_THERMOELECTRIC"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier assigned to the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the report by the reporting organization.
  "ALLOCATION_ID" character varying(60) NOT NULL, -- Unique identifier for the allocation.
  "WATER_USER_ID" character varying(50) NOT NULL, -- A unique identifier for the water user.
  "BENEFICIAL_USE_ID" numeric(18,0) NOT NULL, -- A unique identifier for the beneficial use.
  "DETAIL_SEQ_NO" numeric(18,0) NOT NULL, -- A unique identifier for the reported information.
  "GENERATOR_TYPE" numeric(18,0) NOT NULL, -- The type of generator used to generate electricity.
  "POWER_CAPACITY" numeric(18,0) NOT NULL, -- The amount of power capacity in megawatt hours.
  CONSTRAINT "PK_D_THERMOELECTRIC" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "WATER_USER_ID", "BENEFICIAL_USE_ID", "DETAIL_SEQ_NO"),
  CONSTRAINT "FK_D_THERMOELECTRIC-D_CONSUMPTIVE_USE" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "WATER_USER_ID", "BENEFICIAL_USE_ID")
      REFERENCES "WADE"."D_CONSUMPTIVE_USE" ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "WATER_USER_ID", "BENEFICIAL_USE_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_THERMOELECTRIC-LU_GENERATOR_TYPE" FOREIGN KEY ("GENERATOR_TYPE")
      REFERENCES "WADE"."LU_GENERATOR_TYPE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."D_THERMOELECTRIC"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."D_THERMOELECTRIC"
  IS 'Additional metadata for thermoelectric uses.';
COMMENT ON COLUMN "WADE"."D_THERMOELECTRIC"."ORGANIZATION_ID" IS 'A unique identifier assigned to the organization.';
COMMENT ON COLUMN "WADE"."D_THERMOELECTRIC"."REPORT_ID" IS 'A unique identifier assigned to the report by the reporting organization.';
COMMENT ON COLUMN "WADE"."D_THERMOELECTRIC"."ALLOCATION_ID" IS 'Unique identifier for the allocation.';
COMMENT ON COLUMN "WADE"."D_THERMOELECTRIC"."WATER_USER_ID" IS 'A unique identifier for the water user.';
COMMENT ON COLUMN "WADE"."D_THERMOELECTRIC"."BENEFICIAL_USE_ID" IS 'A unique identifier for the beneficial use.';
COMMENT ON COLUMN "WADE"."D_THERMOELECTRIC"."DETAIL_SEQ_NO" IS 'A unique identifier for the reported information.';
COMMENT ON COLUMN "WADE"."D_THERMOELECTRIC"."GENERATOR_TYPE" IS 'The type of generator used to generate electricity.';
COMMENT ON COLUMN "WADE"."D_THERMOELECTRIC"."POWER_CAPACITY" IS 'The amount of power capacity in megawatt hours.';


-- Index: "WADE"."FKI_D_THERMOELECTRIC-D_CONSUMPTIVE_USE"

-- DROP INDEX "WADE"."FKI_D_THERMOELECTRIC-D_CONSUMPTIVE_USE";

CREATE INDEX "FKI_D_THERMOELECTRIC-D_CONSUMPTIVE_USE"
  ON "WADE"."D_THERMOELECTRIC"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "ALLOCATION_ID" COLLATE pg_catalog."default", "WATER_USER_ID" COLLATE pg_catalog."default", "BENEFICIAL_USE_ID");

-- Index: "WADE"."FKI_D_THERMOELECTRIC-LU_GENERATOR_TYPE"

-- DROP INDEX "WADE"."FKI_D_THERMOELECTRIC-LU_GENERATOR_TYPE";

CREATE INDEX "FKI_D_THERMOELECTRIC-LU_GENERATOR_TYPE"
  ON "WADE"."D_THERMOELECTRIC"
  USING btree
  ("GENERATOR_TYPE");

