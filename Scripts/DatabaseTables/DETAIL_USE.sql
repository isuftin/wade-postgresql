-- Table: "WADE"."DETAIL_USE"

-- DROP TABLE "WADE"."DETAIL_USE";

CREATE TABLE "WADE"."DETAIL_USE"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier assigned to the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the report by the reporting organization.
  "ALLOCATION_ID" character varying(60) NOT NULL, -- A unique identifier for the allocation.
  "WATER_USER_ID" character varying(50) NOT NULL, -- A unique identifier for the water user.
  "WATER_USER_NAME" character varying(100), -- The name of the water user.
  CONSTRAINT "PK_DETAIL_USE" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "WATER_USER_ID"),
  CONSTRAINT "FK_DETAIL_USE-DETAIL_ALLOCATION" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID")
      REFERENCES "WADE"."DETAIL_ALLOCATION" ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."DETAIL_USE"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."DETAIL_USE"
  IS 'Information about the use of the water';
COMMENT ON COLUMN "WADE"."DETAIL_USE"."ORGANIZATION_ID" IS 'A unique identifier assigned to the organization.';
COMMENT ON COLUMN "WADE"."DETAIL_USE"."REPORT_ID" IS 'A unique identifier assigned to the report by the reporting organization.';
COMMENT ON COLUMN "WADE"."DETAIL_USE"."ALLOCATION_ID" IS 'A unique identifier for the allocation.';
COMMENT ON COLUMN "WADE"."DETAIL_USE"."WATER_USER_ID" IS 'A unique identifier for the water user.';
COMMENT ON COLUMN "WADE"."DETAIL_USE"."WATER_USER_NAME" IS 'The name of the water user.';

