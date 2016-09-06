-- Table: "WADE"."D_IRRIGATION"

-- DROP TABLE "WADE"."D_IRRIGATION";

CREATE TABLE "WADE"."D_IRRIGATION"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier assigned to the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the report by the reporting organization.
  "ALLOCATION_ID" character varying(60) NOT NULL, -- Unique identifier for the allocation.
  "WATER_USER_ID" character varying(50) NOT NULL, -- A unique identifier for the water user.
  "BENEFICIAL_USE_ID" numeric(18,0) NOT NULL, -- A unique identifier for the beneficial use.
  "DETAIL_SEQ_NO" numeric(18,0) NOT NULL, -- A unique identifier for the reported information.
  "IRRIGATION_METHOD" numeric(18,0), -- Name of the method used to irrigate (i.e. sprinkler, flood, microirrigation, etc.)
  "ACRES_IRRIGATED" numeric(18,3) NOT NULL, -- Number of acres irrigated.
  "CROP_TYPE" numeric(18,0), -- Crop type being irrigated
  CONSTRAINT "PK_D_IRRIGATION" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "WATER_USER_ID", "BENEFICIAL_USE_ID", "DETAIL_SEQ_NO"),
  CONSTRAINT "FK_D_IRRIGATION-D_CONSUMPTIVE_USE" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "WATER_USER_ID", "BENEFICIAL_USE_ID")
      REFERENCES "WADE"."D_CONSUMPTIVE_USE" ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "WATER_USER_ID", "BENEFICIAL_USE_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_IRRIGATION-LU_CROP_TYPE" FOREIGN KEY ("CROP_TYPE")
      REFERENCES "WADE"."LU_CROP_TYPE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_IRRIGATION-LU_IRRIGATION_METHOD" FOREIGN KEY ("IRRIGATION_METHOD")
      REFERENCES "WADE"."LU_IRRIGATION_METHOD" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."D_IRRIGATION"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."D_IRRIGATION"
  IS 'Additional metadata for irrigation uses.';
COMMENT ON COLUMN "WADE"."D_IRRIGATION"."ORGANIZATION_ID" IS 'A unique identifier assigned to the organization.';
COMMENT ON COLUMN "WADE"."D_IRRIGATION"."REPORT_ID" IS 'A unique identifier assigned to the report by the reporting organization.';
COMMENT ON COLUMN "WADE"."D_IRRIGATION"."ALLOCATION_ID" IS 'Unique identifier for the allocation.';
COMMENT ON COLUMN "WADE"."D_IRRIGATION"."WATER_USER_ID" IS 'A unique identifier for the water user.';
COMMENT ON COLUMN "WADE"."D_IRRIGATION"."BENEFICIAL_USE_ID" IS 'A unique identifier for the beneficial use.';
COMMENT ON COLUMN "WADE"."D_IRRIGATION"."DETAIL_SEQ_NO" IS 'A unique identifier for the reported information.';
COMMENT ON COLUMN "WADE"."D_IRRIGATION"."IRRIGATION_METHOD" IS 'Name of the method used to irrigate (i.e. sprinkler, flood, microirrigation, etc.)';
COMMENT ON COLUMN "WADE"."D_IRRIGATION"."ACRES_IRRIGATED" IS 'Number of acres irrigated.';
COMMENT ON COLUMN "WADE"."D_IRRIGATION"."CROP_TYPE" IS 'Crop type being irrigated';


-- Index: "WADE"."FKI_D_IRRIGATION-D_CONSUMPTIVE_USE"

-- DROP INDEX "WADE"."FKI_D_IRRIGATION-D_CONSUMPTIVE_USE";

CREATE INDEX "FKI_D_IRRIGATION-D_CONSUMPTIVE_USE"
  ON "WADE"."D_IRRIGATION"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "ALLOCATION_ID" COLLATE pg_catalog."default", "WATER_USER_ID" COLLATE pg_catalog."default", "BENEFICIAL_USE_ID");

-- Index: "WADE"."FKI_D_IRRIGATION-LU_CROP_TYPE"

-- DROP INDEX "WADE"."FKI_D_IRRIGATION-LU_CROP_TYPE";

CREATE INDEX "FKI_D_IRRIGATION-LU_CROP_TYPE"
  ON "WADE"."D_IRRIGATION"
  USING btree
  ("CROP_TYPE");

-- Index: "WADE"."FKI_D_IRRIGATION-LU_IRRIGATION_METHOD"

-- DROP INDEX "WADE"."FKI_D_IRRIGATION-LU_IRRIGATION_METHOD";

CREATE INDEX "FKI_D_IRRIGATION-LU_IRRIGATION_METHOD"
  ON "WADE"."D_IRRIGATION"
  USING btree
  ("IRRIGATION_METHOD");

