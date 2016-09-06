-- Table: "WADE"."LU_GENERATOR_TYPE"

-- DROP TABLE "WADE"."LU_GENERATOR_TYPE";

CREATE TABLE "WADE"."LU_GENERATOR_TYPE"
(
  "LU_SEQ_NO" numeric(18,0) NOT NULL, -- A unique identifier for the Look-up value.
  "CONTEXT" character varying(10) NOT NULL, -- Context for the lookk-up value
  "VALUE" character varying(60) NOT NULL, -- Look up value.
  "DESCRIPTION" character varying(255), -- Description of the look-up value.
  "STATE" character(2), -- State that the Look-up value applies to.
  "LAST_CHANGE_DATE" date, -- Last change date for the look-up.
  "RETIRED_FLAG" character(1),
  CONSTRAINT "PK_LU_GENERATOR_TYPE" PRIMARY KEY ("LU_SEQ_NO"),
  CONSTRAINT "UK_LU_GENERATOR_TYPE-CONTEXT_VALUE" UNIQUE ("CONTEXT", "VALUE")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."LU_GENERATOR_TYPE"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."LU_GENERATOR_TYPE"
  IS 'Look up table for Generator Type.';
COMMENT ON COLUMN "WADE"."LU_GENERATOR_TYPE"."LU_SEQ_NO" IS 'A unique identifier for the Look-up value.';
COMMENT ON COLUMN "WADE"."LU_GENERATOR_TYPE"."CONTEXT" IS 'Context for the lookk-up value';
COMMENT ON COLUMN "WADE"."LU_GENERATOR_TYPE"."VALUE" IS 'Look up value.';
COMMENT ON COLUMN "WADE"."LU_GENERATOR_TYPE"."DESCRIPTION" IS 'Description of the look-up value.';
COMMENT ON COLUMN "WADE"."LU_GENERATOR_TYPE"."STATE" IS 'State that the Look-up value applies to.';
COMMENT ON COLUMN "WADE"."LU_GENERATOR_TYPE"."LAST_CHANGE_DATE" IS 'Last change date for the look-up.';


-- Trigger: TG_LU_GENERATOR_TYPE_CHANGE on "WADE"."LU_GENERATOR_TYPE"

-- DROP TRIGGER "TG_LU_GENERATOR_TYPE_CHANGE" ON "WADE"."LU_GENERATOR_TYPE";

CREATE TRIGGER "TG_LU_GENERATOR_TYPE_CHANGE"
  BEFORE INSERT OR UPDATE
  ON "WADE"."LU_GENERATOR_TYPE"
  FOR EACH ROW
  EXECUTE PROCEDURE "WADE"."UPDATE_CHANGE_DATE"();

