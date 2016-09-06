-- Table: "WADE"."LU_STATE"

-- DROP TABLE "WADE"."LU_STATE";

CREATE TABLE "WADE"."LU_STATE"
(
  "LU_SEQ_NO" numeric(18,0) NOT NULL, -- A unique identifier for the Look-up value.
  "CONTEXT" character varying(10) NOT NULL, -- Context for the lookk-up value
  "VALUE" character varying(2) NOT NULL, -- Look up value.
  "DESCRIPTION" character varying(255), -- Description of the look-up value.
  "STATE" character(2), -- State that the Look-up value applies to.
  "LAST_CHANGE_DATE" date, -- Last change date for the look-up.
  "RETIRED_FLAG" character(1),
  CONSTRAINT "PK_LU_STATE" PRIMARY KEY ("LU_SEQ_NO"),
  CONSTRAINT "UK_LU_STATE-CONTEXT_VALUE" UNIQUE ("CONTEXT", "VALUE")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."LU_STATE"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."LU_STATE"
  IS 'Look up table for State.';
COMMENT ON COLUMN "WADE"."LU_STATE"."LU_SEQ_NO" IS 'A unique identifier for the Look-up value.';
COMMENT ON COLUMN "WADE"."LU_STATE"."CONTEXT" IS 'Context for the lookk-up value';
COMMENT ON COLUMN "WADE"."LU_STATE"."VALUE" IS 'Look up value.';
COMMENT ON COLUMN "WADE"."LU_STATE"."DESCRIPTION" IS 'Description of the look-up value.';
COMMENT ON COLUMN "WADE"."LU_STATE"."STATE" IS 'State that the Look-up value applies to.';
COMMENT ON COLUMN "WADE"."LU_STATE"."LAST_CHANGE_DATE" IS 'Last change date for the look-up.';


-- Trigger: TG_LU_STATE_CHANGE on "WADE"."LU_STATE"

-- DROP TRIGGER "TG_LU_STATE_CHANGE" ON "WADE"."LU_STATE";

CREATE TRIGGER "TG_LU_STATE_CHANGE"
  BEFORE INSERT OR UPDATE
  ON "WADE"."LU_STATE"
  FOR EACH ROW
  EXECUTE PROCEDURE "WADE"."UPDATE_CHANGE_DATE"();

