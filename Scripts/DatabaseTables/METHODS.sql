-- Table: "WADE"."METHODS"

-- DROP TABLE "WADE"."METHODS";

CREATE TABLE "WADE"."METHODS"
(
  "METHOD_ID" numeric(18,0) NOT NULL, -- A unique identifier for the look-up value.
  "METHOD_CONTEXT" character varying(10) NOT NULL, -- Context for the look-up value
  "METHOD_NAME" character varying(255) NOT NULL, -- Method Name
  "METHOD_DESC" character varying(400), -- Description of the method
  "STATE" character(2), -- State that the look-up value applies to
  "METHOD_DATE" date, -- Date that the method was developed or came into use
  "METHOD_TYPE" character varying(50), -- Describes whether method used for water availability, consumptive use or other
  "TIME_SCALE" character varying(40), -- Timescale that the method applies to - daily, weekly, monthly, seasonal, annual
  "METHOD_LINK" character varying(1000), -- URL for acquiring more information about the method
  "SOURCE_ID" numeric(18,0), -- Unique key for DATA_SOURCES table
  "RESOURCE_TYPE" character varying(50), -- Text describing the water resource type, surface water, groundwater, surface/ground, wastewater reuse
  "LOCATION_NAME" character varying(100), -- Areas for which the method is used, statewide, HUC, aquifer source, basin
  "LAST_CHANGE_DATE" date, -- Last change date for the look-up.
  "RETIRED_FLAG" character(1),
  CONSTRAINT "PK_METHODS" PRIMARY KEY ("METHOD_ID"),
  CONSTRAINT "FK_METHODS-DATA_SOURCES" FOREIGN KEY ("SOURCE_ID")
      REFERENCES "WADE"."DATA_SOURCES" ("SOURCE_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."METHODS"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."METHODS"
  IS 'Look up table for Methods.';
COMMENT ON COLUMN "WADE"."METHODS"."METHOD_ID" IS 'A unique identifier for the look-up value.';
COMMENT ON COLUMN "WADE"."METHODS"."METHOD_CONTEXT" IS 'Context for the look-up value';
COMMENT ON COLUMN "WADE"."METHODS"."METHOD_NAME" IS 'Method Name';
COMMENT ON COLUMN "WADE"."METHODS"."METHOD_DESC" IS 'Description of the method';
COMMENT ON COLUMN "WADE"."METHODS"."STATE" IS 'State that the look-up value applies to';
COMMENT ON COLUMN "WADE"."METHODS"."METHOD_DATE" IS 'Date that the method was developed or came into use';
COMMENT ON COLUMN "WADE"."METHODS"."METHOD_TYPE" IS 'Describes whether method used for water availability, consumptive use or other';
COMMENT ON COLUMN "WADE"."METHODS"."TIME_SCALE" IS 'Timescale that the method applies to - daily, weekly, monthly, seasonal, annual';
COMMENT ON COLUMN "WADE"."METHODS"."METHOD_LINK" IS 'URL for acquiring more information about the method';
COMMENT ON COLUMN "WADE"."METHODS"."SOURCE_ID" IS 'Unique key for DATA_SOURCES table';
COMMENT ON COLUMN "WADE"."METHODS"."RESOURCE_TYPE" IS 'Text describing the water resource type, surface water, groundwater, surface/ground, wastewater reuse';
COMMENT ON COLUMN "WADE"."METHODS"."LOCATION_NAME" IS 'Areas for which the method is used, statewide, HUC, aquifer source, basin';
COMMENT ON COLUMN "WADE"."METHODS"."LAST_CHANGE_DATE" IS 'Last change date for the look-up.';


-- Index: "WADE"."FKI_METHODS-DATA_SOURCES"

-- DROP INDEX "WADE"."FKI_METHODS-DATA_SOURCES";

CREATE INDEX "FKI_METHODS-DATA_SOURCES"
  ON "WADE"."METHODS"
  USING btree
  ("SOURCE_ID");


-- Trigger: TG_METHODS_CHANGE on "WADE"."METHODS"

-- DROP TRIGGER "TG_METHODS_CHANGE" ON "WADE"."METHODS";

CREATE TRIGGER "TG_METHODS_CHANGE"
  BEFORE INSERT OR UPDATE
  ON "WADE"."METHODS"
  FOR EACH ROW
  EXECUTE PROCEDURE "WADE"."UPDATE_CHANGE_DATE"();

