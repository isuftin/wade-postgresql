-- Table: "WADE"."D_ALLOCATION_LOCATION"

-- DROP TABLE "WADE"."D_ALLOCATION_LOCATION";

CREATE TABLE "WADE"."D_ALLOCATION_LOCATION"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier assigned to the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the report by the reporting organization.
  "ALLOCATION_ID" character varying(60) NOT NULL, -- Unique identifier for the allocation.
  "LOCATION_SEQ" numeric(18,0) NOT NULL, -- Unique identifier for the location.
  "STATE" numeric(18,0) NOT NULL, -- Code representing the 2-digit abbreviation for the state.
  "REPORTING_UNIT_ID" character varying(35), -- A unique identifier assigned tot he reporting unit by the reporting organization.
  "COUNTY_FIPS" character(5), -- County FIPS code (including the state FIPS code) representing the county.
  "HUC" character varying(12), -- Code representing the USGS Hydrologic Unit (or HUC) at the most detailed level that the assignment can be made (6-digit being the lowest level of resolution allowed).  Leading 0's should be included.
  "WFS_FEATURE_REF" character varying(35),
  CONSTRAINT "PK_D_ALLOCATION_LOCATION" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "LOCATION_SEQ"),
  CONSTRAINT "FK_D_ALLOCATION_LOCATION-DETAIL_ALLOCATION" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID")
      REFERENCES "WADE"."DETAIL_ALLOCATION" ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_ALLOCATION_LOCATION-LU_STATE" FOREIGN KEY ("STATE")
      REFERENCES "WADE"."LU_STATE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."D_ALLOCATION_LOCATION"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."D_ALLOCATION_LOCATION"
  IS 'Allocations of water rights assigned to specific entities.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_LOCATION"."ORGANIZATION_ID" IS 'A unique identifier assigned to the organization.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_LOCATION"."REPORT_ID" IS 'A unique identifier assigned to the report by the reporting organization.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_LOCATION"."ALLOCATION_ID" IS 'Unique identifier for the allocation.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_LOCATION"."LOCATION_SEQ" IS 'Unique identifier for the location.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_LOCATION"."STATE" IS 'Code representing the 2-digit abbreviation for the state.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_LOCATION"."REPORTING_UNIT_ID" IS 'A unique identifier assigned tot he reporting unit by the reporting organization.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_LOCATION"."COUNTY_FIPS" IS 'County FIPS code (including the state FIPS code) representing the county.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_LOCATION"."HUC" IS 'Code representing the USGS Hydrologic Unit (or HUC) at the most detailed level that the assignment can be made (6-digit being the lowest level of resolution allowed).  Leading 0''s should be included.';


-- Index: "WADE"."FKI_D_ALLOCATION_LOCATION-DETAIL_ALLOCATION"

-- DROP INDEX "WADE"."FKI_D_ALLOCATION_LOCATION-DETAIL_ALLOCATION";

CREATE INDEX "FKI_D_ALLOCATION_LOCATION-DETAIL_ALLOCATION"
  ON "WADE"."D_ALLOCATION_LOCATION"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "ALLOCATION_ID" COLLATE pg_catalog."default");

-- Index: "WADE"."FKI_D_ALLOCATION_LOCATION-LU_STATE"

-- DROP INDEX "WADE"."FKI_D_ALLOCATION_LOCATION-LU_STATE";

CREATE INDEX "FKI_D_ALLOCATION_LOCATION-LU_STATE"
  ON "WADE"."D_ALLOCATION_LOCATION"
  USING btree
  ("STATE");

