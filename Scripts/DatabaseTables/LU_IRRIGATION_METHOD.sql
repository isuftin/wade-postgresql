-- Table: "WADE"."LU_IRRIGATION_METHOD"

-- DROP TABLE "WADE"."LU_IRRIGATION_METHOD";

CREATE TABLE "WADE"."LU_IRRIGATION_METHOD"
(
  "LU_SEQ_NO" numeric(18,0) NOT NULL, -- A unique identifier for the Look-up value.
  "CONTEXT" character varying(10) NOT NULL, -- Context for the lookk-up value
  "VALUE" character varying(30) NOT NULL, -- Look up value.
  "DESCRIPTION" character varying(255), -- Description of the look-up value.
  "STATE" character(2), -- State that the Look-up value applies to.
  "LAST_CHANGE_DATE" date, -- Last change date for the look-up.
  "RETIRED_FLAG" character(1),
  CONSTRAINT "PK_LU_IRRIGATION_METHOD" PRIMARY KEY ("LU_SEQ_NO"),
  CONSTRAINT "UK_LU_IRRIGATION_METHOD-CONTEXT_VALUE" UNIQUE ("CONTEXT", "VALUE")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."LU_IRRIGATION_METHOD"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."LU_IRRIGATION_METHOD"
  IS 'Look up table for Irrigation Methods.';
COMMENT ON COLUMN "WADE"."LU_IRRIGATION_METHOD"."LU_SEQ_NO" IS 'A unique identifier for the Look-up value.';
COMMENT ON COLUMN "WADE"."LU_IRRIGATION_METHOD"."CONTEXT" IS 'Context for the lookk-up value';
COMMENT ON COLUMN "WADE"."LU_IRRIGATION_METHOD"."VALUE" IS 'Look up value.';
COMMENT ON COLUMN "WADE"."LU_IRRIGATION_METHOD"."DESCRIPTION" IS 'Description of the look-up value.';
COMMENT ON COLUMN "WADE"."LU_IRRIGATION_METHOD"."STATE" IS 'State that the Look-up value applies to.';
COMMENT ON COLUMN "WADE"."LU_IRRIGATION_METHOD"."LAST_CHANGE_DATE" IS 'Last change date for the look-up.';


-- Trigger: TG_LU_IRRIGATION_METHOD_CHANGE on "WADE"."LU_IRRIGATION_METHOD"

-- DROP TRIGGER "TG_LU_IRRIGATION_METHOD_CHANGE" ON "WADE"."LU_IRRIGATION_METHOD";

CREATE TRIGGER "TG_LU_IRRIGATION_METHOD_CHANGE"
  BEFORE INSERT OR UPDATE
  ON "WADE"."LU_IRRIGATION_METHOD"
  FOR EACH ROW
  EXECUTE PROCEDURE "WADE"."UPDATE_CHANGE_DATE"();

