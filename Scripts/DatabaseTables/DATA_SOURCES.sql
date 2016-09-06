-- Table: "WADE"."DATA_SOURCES"

-- DROP TABLE "WADE"."DATA_SOURCES";

CREATE TABLE "WADE"."DATA_SOURCES"
(
  "SOURCE_ID" numeric(18,0) NOT NULL, -- A unique identifier for the look-up value.
  "SOURCE_CONTEXT" character varying(10) NOT NULL, -- Context for the look-up value
  "SOURCE_NAME" character varying(255) NOT NULL, -- Data Source Name
  "SOURCE_DESC" character varying(1000), -- Description of the data source
  "STATE" character(2), -- State that the look-up value applies to
  "SOURCE_START_DATE" date, -- Starting date used for data source
  "SOURCE_END_DATE" date, -- Ending date used for data source
  "SOURCE_LINK" character varying(1000), -- URL for acquiring more information about the data source
  "LAST_CHANGE_DATE" date, -- Last change date for the look-up.
  "RETIRED_FLAG" character(1),
  CONSTRAINT "PK_DATA_SOURCES" PRIMARY KEY ("SOURCE_ID")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."DATA_SOURCES"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."DATA_SOURCES"
  IS 'Look up table for Data Sources related to methods used.';
COMMENT ON COLUMN "WADE"."DATA_SOURCES"."SOURCE_ID" IS 'A unique identifier for the look-up value.';
COMMENT ON COLUMN "WADE"."DATA_SOURCES"."SOURCE_CONTEXT" IS 'Context for the look-up value';
COMMENT ON COLUMN "WADE"."DATA_SOURCES"."SOURCE_NAME" IS 'Data Source Name';
COMMENT ON COLUMN "WADE"."DATA_SOURCES"."SOURCE_DESC" IS 'Description of the data source';
COMMENT ON COLUMN "WADE"."DATA_SOURCES"."STATE" IS 'State that the look-up value applies to';
COMMENT ON COLUMN "WADE"."DATA_SOURCES"."SOURCE_START_DATE" IS 'Starting date used for data source';
COMMENT ON COLUMN "WADE"."DATA_SOURCES"."SOURCE_END_DATE" IS 'Ending date used for data source';
COMMENT ON COLUMN "WADE"."DATA_SOURCES"."SOURCE_LINK" IS 'URL for acquiring more information about the data source';
COMMENT ON COLUMN "WADE"."DATA_SOURCES"."LAST_CHANGE_DATE" IS 'Last change date for the look-up.';


-- Trigger: TG_DATA_SOURCES_CHANGE on "WADE"."DATA_SOURCES"

-- DROP TRIGGER "TG_DATA_SOURCES_CHANGE" ON "WADE"."DATA_SOURCES";

CREATE TRIGGER "TG_DATA_SOURCES_CHANGE"
  BEFORE INSERT OR UPDATE
  ON "WADE"."DATA_SOURCES"
  FOR EACH ROW
  EXECUTE PROCEDURE "WADE"."UPDATE_CHANGE_DATE"();