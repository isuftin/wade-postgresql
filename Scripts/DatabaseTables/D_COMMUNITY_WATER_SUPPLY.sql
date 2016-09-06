-- Table: "WADE"."D_COMMUNITY_WATER_SUPPLY"

-- DROP TABLE "WADE"."D_COMMUNITY_WATER_SUPPLY";

CREATE TABLE "WADE"."D_COMMUNITY_WATER_SUPPLY"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier assigned to the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the report by the reporting organization.
  "ALLOCATION_ID" character varying(60) NOT NULL, -- Unique identifier for the allocation.
  "WATER_USER_ID" character varying(50) NOT NULL, -- A unique identifier for the water user.
  "BENEFICIAL_USE_ID" numeric(18,0) NOT NULL, -- A unique identifier for the beneficial use.
  "DETAIL_SEQ_NO" numeric(18,0) NOT NULL, -- A unique identifier for the reported information.
  "POPULATION_SERVED" numeric(18,0) NOT NULL, -- Population served by the community water supply
  "WATER_SUPPLY_NAME" character varying(60), -- Name of the community.
  CONSTRAINT "PK_D_COMMUNITY_WATER_SUPPLY" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "WATER_USER_ID", "BENEFICIAL_USE_ID", "DETAIL_SEQ_NO"),
  CONSTRAINT "FK_D_COMMUNITY_WATER_SUPPLY-D_CONSUMPTIVE_USE" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "WATER_USER_ID", "BENEFICIAL_USE_ID")
      REFERENCES "WADE"."D_CONSUMPTIVE_USE" ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "WATER_USER_ID", "BENEFICIAL_USE_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."D_COMMUNITY_WATER_SUPPLY"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."D_COMMUNITY_WATER_SUPPLY"
  IS 'Additional metadata for community water supply uses.';
COMMENT ON COLUMN "WADE"."D_COMMUNITY_WATER_SUPPLY"."ORGANIZATION_ID" IS 'A unique identifier assigned to the organization.';
COMMENT ON COLUMN "WADE"."D_COMMUNITY_WATER_SUPPLY"."REPORT_ID" IS 'A unique identifier assigned to the report by the reporting organization.';
COMMENT ON COLUMN "WADE"."D_COMMUNITY_WATER_SUPPLY"."ALLOCATION_ID" IS 'Unique identifier for the allocation.';
COMMENT ON COLUMN "WADE"."D_COMMUNITY_WATER_SUPPLY"."WATER_USER_ID" IS 'A unique identifier for the water user.';
COMMENT ON COLUMN "WADE"."D_COMMUNITY_WATER_SUPPLY"."BENEFICIAL_USE_ID" IS 'A unique identifier for the beneficial use.';
COMMENT ON COLUMN "WADE"."D_COMMUNITY_WATER_SUPPLY"."DETAIL_SEQ_NO" IS 'A unique identifier for the reported information.';
COMMENT ON COLUMN "WADE"."D_COMMUNITY_WATER_SUPPLY"."POPULATION_SERVED" IS 'Population served by the community water supply';
COMMENT ON COLUMN "WADE"."D_COMMUNITY_WATER_SUPPLY"."WATER_SUPPLY_NAME" IS 'Name of the community.';


-- Index: "WADE"."FKI_D_COMMUNITY_WATER_SUPPLY-D_CONSUMPTIVE_USE"

-- DROP INDEX "WADE"."FKI_D_COMMUNITY_WATER_SUPPLY-D_CONSUMPTIVE_USE";

CREATE INDEX "FKI_D_COMMUNITY_WATER_SUPPLY-D_CONSUMPTIVE_USE"
  ON "WADE"."D_COMMUNITY_WATER_SUPPLY"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "ALLOCATION_ID" COLLATE pg_catalog."default", "WATER_USER_ID" COLLATE pg_catalog."default", "BENEFICIAL_USE_ID");

