-- Table: "WADE"."DETAIL_ALLOCATION"

-- DROP TABLE "WADE"."DETAIL_ALLOCATION";

CREATE TABLE "WADE"."DETAIL_ALLOCATION"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier assigned to the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the report by the reporting organziation.
  "ALLOCATION_ID" character varying(60) NOT NULL, -- Unique identifier for the allocation.
  "ALLOCATION_OWNER" character varying(100), -- Name of the entity with the allocation.
  "APPLICATION_DATE" date, -- The date on which the water right was applied for.
  "PRIORITY_DATE" date, -- The priority date for the water right.
  "END_DATE" date,
  "LEGAL_STATUS" numeric(18,0), -- The legal status of the water right (i.e. is it a proven right, perfected, or being adjudicated, etc.)
  CONSTRAINT "PK_DETAIL_ALLOCATION" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID"),
  CONSTRAINT "FK_DETAIL_ALLOCATION-LU_LEGAL_STATUS" FOREIGN KEY ("LEGAL_STATUS")
      REFERENCES "WADE"."LU_LEGAL_STATUS" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "FK_DETAIL_ALLOCATION-REPORT" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID")
      REFERENCES "WADE"."REPORT" ("ORGANIZATION_ID", "REPORT_ID") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."DETAIL_ALLOCATION"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."DETAIL_ALLOCATION"
  IS 'Allocations of water rights assigned to specific entities.';
COMMENT ON COLUMN "WADE"."DETAIL_ALLOCATION"."ORGANIZATION_ID" IS 'A unique identifier assigned to the organization.';
COMMENT ON COLUMN "WADE"."DETAIL_ALLOCATION"."REPORT_ID" IS 'A unique identifier assigned to the report by the reporting organziation.';
COMMENT ON COLUMN "WADE"."DETAIL_ALLOCATION"."ALLOCATION_ID" IS 'Unique identifier for the allocation.';
COMMENT ON COLUMN "WADE"."DETAIL_ALLOCATION"."ALLOCATION_OWNER" IS 'Name of the entity with the allocation.';
COMMENT ON COLUMN "WADE"."DETAIL_ALLOCATION"."APPLICATION_DATE" IS 'The date on which the water right was applied for.';
COMMENT ON COLUMN "WADE"."DETAIL_ALLOCATION"."PRIORITY_DATE" IS 'The priority date for the water right.';
COMMENT ON COLUMN "WADE"."DETAIL_ALLOCATION"."LEGAL_STATUS" IS 'The legal status of the water right (i.e. is it a proven right, perfected, or being adjudicated, etc.)';


-- Index: "WADE"."FKI_DETAIL_ALLOCATION-LU_LEGAL_STATUS"

-- DROP INDEX "WADE"."FKI_DETAIL_ALLOCATION-LU_LEGAL_STATUS";

CREATE INDEX "FKI_DETAIL_ALLOCATION-LU_LEGAL_STATUS"
  ON "WADE"."DETAIL_ALLOCATION"
  USING btree
  ("LEGAL_STATUS");

