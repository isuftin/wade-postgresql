-- Table: "WADE"."METRICS"

-- DROP TABLE "WADE"."METRICS";

CREATE TABLE "WADE"."METRICS"
(
  "METRIC_ID" numeric(18,0) NOT NULL, -- A unique identifier for the Look-up value.
  "CONTEXT" character varying(10) NOT NULL, -- Context for the lookk-up value
  "VALUE" character varying(35) NOT NULL, -- Look up value.
  "DESCRIPTION" character varying(255), -- Description of the look-up value.
  "STATE" character(2), -- State that the Look-up value applies to.
  "LAST_CHANGE_DATE" date, -- Last change date for the look-up.
  "RETIRED_FLAG" character(1),
  CONSTRAINT "PK_METRICS" PRIMARY KEY ("METRIC_ID")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."METRICS"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."METRICS"
  IS 'Look up table for County.';
COMMENT ON COLUMN "WADE"."METRICS"."METRIC_ID" IS 'A unique identifier for the Look-up value.';
COMMENT ON COLUMN "WADE"."METRICS"."CONTEXT" IS 'Context for the lookk-up value';
COMMENT ON COLUMN "WADE"."METRICS"."VALUE" IS 'Look up value.';
COMMENT ON COLUMN "WADE"."METRICS"."DESCRIPTION" IS 'Description of the look-up value.';
COMMENT ON COLUMN "WADE"."METRICS"."STATE" IS 'State that the Look-up value applies to.';
COMMENT ON COLUMN "WADE"."METRICS"."LAST_CHANGE_DATE" IS 'Last change date for the look-up.';


-- Trigger: TG_METRICS_CHANGE on "WADE"."METRICS"

-- DROP TRIGGER "TG_METRICS_CHANGE" ON "WADE"."METRICS";

CREATE TRIGGER "TG_METRICS_CHANGE"
  BEFORE INSERT OR UPDATE
  ON "WADE"."METRICS"
  FOR EACH ROW
  EXECUTE PROCEDURE "WADE"."UPDATE_CHANGE_DATE"();

