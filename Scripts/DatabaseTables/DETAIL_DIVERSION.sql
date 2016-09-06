-- Table: "WADE"."DETAIL_DIVERSION"

-- DROP TABLE "WADE"."DETAIL_DIVERSION";

CREATE TABLE "WADE"."DETAIL_DIVERSION"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier assigned to the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the report by the reporting organziation.
  "ALLOCATION_ID" character varying(60) NOT NULL, -- Unique identifier for the allocation.
  "DIVERSION_ID" character varying(35) NOT NULL, -- Unique identifier for the diversion.
  "DIVERSION_NAME" character varying(255), -- Name of the diversion.
  "STATE" numeric(18,0) NOT NULL, -- Code representing the 2-digit abbreviation for the state.
  "REPORTING_UNIT_ID" character varying(35), -- A unique identifier assigned tot he reporting unit by the reporting ...
  "COUNTY_FIPS" character(5), -- County FIPS code (including the state FIPS code) representing the county.
  "HUC" character varying(12), -- Code representing the USGS Hydrologic Unit (or HUC) at the most detailed level that the ...
  "WFS_FEATURE_REF" character varying(35), -- Column containing the Object ID or Feature ID unique key number for the corresponding WFS identified in the GEOSPATIAL_REF table.
  CONSTRAINT "PK_DETAIL_DIVERSION" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "DIVERSION_ID"),
  CONSTRAINT "FK_DETAIL_DIVERSION-DETAIL_ALLOCATION" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID")
      REFERENCES "WADE"."DETAIL_ALLOCATION" ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_DETAIL_DIVERSION-LU_STATE" FOREIGN KEY ("STATE")
      REFERENCES "WADE"."LU_STATE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."DETAIL_DIVERSION"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."DETAIL_DIVERSION"
  IS 'Description of the location of the diverted water.';
COMMENT ON COLUMN "WADE"."DETAIL_DIVERSION"."ORGANIZATION_ID" IS 'A unique identifier assigned to the organization.';
COMMENT ON COLUMN "WADE"."DETAIL_DIVERSION"."REPORT_ID" IS 'A unique identifier assigned to the report by the reporting organziation.';
COMMENT ON COLUMN "WADE"."DETAIL_DIVERSION"."ALLOCATION_ID" IS 'Unique identifier for the allocation.';
COMMENT ON COLUMN "WADE"."DETAIL_DIVERSION"."DIVERSION_ID" IS 'Unique identifier for the diversion.';
COMMENT ON COLUMN "WADE"."DETAIL_DIVERSION"."DIVERSION_NAME" IS 'Name of the diversion.';
COMMENT ON COLUMN "WADE"."DETAIL_DIVERSION"."STATE" IS 'Code representing the 2-digit abbreviation for the state.';
COMMENT ON COLUMN "WADE"."DETAIL_DIVERSION"."REPORTING_UNIT_ID" IS 'A unique identifier assigned tot he reporting unit by the reporting 

organization.';
COMMENT ON COLUMN "WADE"."DETAIL_DIVERSION"."COUNTY_FIPS" IS 'County FIPS code (including the state FIPS code) representing the county.';
COMMENT ON COLUMN "WADE"."DETAIL_DIVERSION"."HUC" IS 'Code representing the USGS Hydrologic Unit (or HUC) at the most detailed level that the 

assignment can be made (6-digit being the lowest level of resolution allowed).  Leading 0''s should be included.';
COMMENT ON COLUMN "WADE"."DETAIL_DIVERSION"."WFS_FEATURE_REF" IS 'Column containing the Object ID or Feature ID unique key number for the corresponding WFS identified in the GEOSPATIAL_REF table.';


-- Index: "WADE"."FKI_DETAIL_DIVERSION-DETAIL_ALLOCATION"

-- DROP INDEX "WADE"."FKI_DETAIL_DIVERSION-DETAIL_ALLOCATION";

CREATE INDEX "FKI_DETAIL_DIVERSION-DETAIL_ALLOCATION"
  ON "WADE"."DETAIL_DIVERSION"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "ALLOCATION_ID" COLLATE pg_catalog."default");

-- Index: "WADE"."FKI_DETAIL_DIVERSION-LU_STATE"

-- DROP INDEX "WADE"."FKI_DETAIL_DIVERSION-LU_STATE";

CREATE INDEX "FKI_DETAIL_DIVERSION-LU_STATE"
  ON "WADE"."DETAIL_DIVERSION"
  USING btree
  ("STATE");

-- Index: "WADE"."IX_LOCATION_DIVERSION"

-- DROP INDEX "WADE"."IX_LOCATION_DIVERSION";

CREATE INDEX "IX_LOCATION_DIVERSION"
  ON "WADE"."DETAIL_DIVERSION"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "ALLOCATION_ID" COLLATE pg_catalog."default", "STATE", "REPORTING_UNIT_ID" COLLATE pg_catalog."default", "COUNTY_FIPS" COLLATE pg_catalog."default", "HUC" COLLATE pg_catalog."default");

