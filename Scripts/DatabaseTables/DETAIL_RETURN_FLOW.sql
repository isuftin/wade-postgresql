-- Table: "WADE"."DETAIL_RETURN_FLOW"

-- DROP TABLE "WADE"."DETAIL_RETURN_FLOW";

CREATE TABLE "WADE"."DETAIL_RETURN_FLOW"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier for the reporting organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier for the report assigned by the reporting organization.
  "ALLOCATION_ID" character varying(60) NOT NULL, -- Unique identifier for the allocation.
  "RETURN_FLOW_ID" character varying(35) NOT NULL, -- Unique identifier for the return flow
  "RETURN_FLOW_NAME" character varying(80), -- Name for the return flow.
  "STATE" numeric(18,0) NOT NULL, -- Code representing the two-digit abbreviation for the state.
  "REPORTING_UNIT_ID" character(35), -- A unique identifier assigned to the reporting unit by the reporting organization.
  "COUNTY_FIPS" character(5), -- County FIPS code ( including the state FIPS code) representing the county.
  "HUC" character varying(12), -- Code representing the USGS Hydrologic Unit (or HUC) at hte  most detailed level that the assignment can be made (6-digit beign the lowest level of resolution allowed).  Leading 0's should be included.
  "WFS_FEATURE_REF" character varying(35), -- Column containing the Object ID or Feature ID unique key number for the corresponding WFS identified in the GEOSPATIAL_REF table.
  CONSTRAINT "PK_DETAIL_RETURN_FLOW" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "RETURN_FLOW_ID"),
  CONSTRAINT "FK_DETAIL_RETURN_FLOW-DETAIL_ALLOCATION" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID")
      REFERENCES "WADE"."DETAIL_ALLOCATION" ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_DETAIL_RETURN_FLOW-LU_STATE" FOREIGN KEY ("STATE")
      REFERENCES "WADE"."LU_STATE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."DETAIL_RETURN_FLOW"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."DETAIL_RETURN_FLOW"
  IS 'The amount and location of water returned';
COMMENT ON COLUMN "WADE"."DETAIL_RETURN_FLOW"."ORGANIZATION_ID" IS 'A unique identifier for the reporting organization.';
COMMENT ON COLUMN "WADE"."DETAIL_RETURN_FLOW"."REPORT_ID" IS 'A unique identifier for the report assigned by the reporting organization.';
COMMENT ON COLUMN "WADE"."DETAIL_RETURN_FLOW"."ALLOCATION_ID" IS 'Unique identifier for the allocation.';
COMMENT ON COLUMN "WADE"."DETAIL_RETURN_FLOW"."RETURN_FLOW_ID" IS 'Unique identifier for the return flow';
COMMENT ON COLUMN "WADE"."DETAIL_RETURN_FLOW"."RETURN_FLOW_NAME" IS 'Name for the return flow.';
COMMENT ON COLUMN "WADE"."DETAIL_RETURN_FLOW"."STATE" IS 'Code representing the two-digit abbreviation for the state.';
COMMENT ON COLUMN "WADE"."DETAIL_RETURN_FLOW"."REPORTING_UNIT_ID" IS 'A unique identifier assigned to the reporting unit by the reporting organization.';
COMMENT ON COLUMN "WADE"."DETAIL_RETURN_FLOW"."COUNTY_FIPS" IS 'County FIPS code ( including the state FIPS code) representing the county.';
COMMENT ON COLUMN "WADE"."DETAIL_RETURN_FLOW"."HUC" IS 'Code representing the USGS Hydrologic Unit (or HUC) at hte  most detailed level that the assignment can be made (6-digit beign the lowest level of resolution allowed).  Leading 0''s should be included.';
COMMENT ON COLUMN "WADE"."DETAIL_RETURN_FLOW"."WFS_FEATURE_REF" IS 'Column containing the Object ID or Feature ID unique key number for the corresponding WFS identified in the GEOSPATIAL_REF table.';


-- Index: "WADE"."FKI_DETAIL_RETURN_FLOW-DETAIL_ALLOCATION"

-- DROP INDEX "WADE"."FKI_DETAIL_RETURN_FLOW-DETAIL_ALLOCATION";

CREATE INDEX "FKI_DETAIL_RETURN_FLOW-DETAIL_ALLOCATION"
  ON "WADE"."DETAIL_RETURN_FLOW"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "ALLOCATION_ID" COLLATE pg_catalog."default");

-- Index: "WADE"."FKI_DETAIL_RETURN_FLOW-LU_STATE"

-- DROP INDEX "WADE"."FKI_DETAIL_RETURN_FLOW-LU_STATE";

CREATE INDEX "FKI_DETAIL_RETURN_FLOW-LU_STATE"
  ON "WADE"."DETAIL_RETURN_FLOW"
  USING btree
  ("STATE");

