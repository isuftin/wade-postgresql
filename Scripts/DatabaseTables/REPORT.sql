-- Table: "WADE"."REPORT"

-- DROP TABLE "WADE"."REPORT";

CREATE TABLE "WADE"."REPORT"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- Unique identifier assigned to the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- Unique identifier assigned to the report by the reporting organization.
  "REPORTING_DATE" date NOT NULL, -- Date on which the report was created.
  "REPORTING_YEAR" character(4) NOT NULL, -- year for which the report was created.
  "REPORT_NAME" character varying(80), -- Name of the report
  "REPORT_LINK" character varying(255), -- Link to the PDF or web page for teh narrative report that contains the information.
  "YEAR_TYPE" character varying(25), -- Report year type: Calendar year, Water Year, etc.  If not provided, then Calendar year will be assumed.
  CONSTRAINT "PK_REPORT" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID"),
  CONSTRAINT "FK_REPORT-ORGANIZATION" FOREIGN KEY ("ORGANIZATION_ID")
      REFERENCES "WADE"."ORGANIZATION" ("ORGANIZATION_ID") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."REPORT"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."REPORT"
  IS 'Water Summary or Water Detail Report';
COMMENT ON COLUMN "WADE"."REPORT"."ORGANIZATION_ID" IS 'Unique identifier assigned to the organization.';
COMMENT ON COLUMN "WADE"."REPORT"."REPORT_ID" IS 'Unique identifier assigned to the report by the reporting organization.';
COMMENT ON COLUMN "WADE"."REPORT"."REPORTING_DATE" IS 'Date on which the report was created.';
COMMENT ON COLUMN "WADE"."REPORT"."REPORTING_YEAR" IS 'year for which the report was created.';
COMMENT ON COLUMN "WADE"."REPORT"."REPORT_NAME" IS 'Name of the report';
COMMENT ON COLUMN "WADE"."REPORT"."REPORT_LINK" IS 'Link to the PDF or web page for teh narrative report that contains the information.';
COMMENT ON COLUMN "WADE"."REPORT"."YEAR_TYPE" IS 'Report year type: Calendar year, Water Year, etc.  If not provided, then Calendar year will be assumed.';

