-- Table: "WADE"."LU_LEGAL_STATUS"

-- DROP TABLE "WADE"."LU_LEGAL_STATUS";

CREATE TABLE "WADE"."LU_LEGAL_STATUS"
(
  "LU_SEQ_NO" numeric(18,0) NOT NULL, -- A unique identifier for the Look-up value.
  "CONTEXT" character varying(10) NOT NULL, -- Context for the lookk-up value
  "VALUE" character varying(25) NOT NULL, -- Look up value.
  "DESCRIPTION" character varying(255), -- Description of the look-up value.
  "STATE" character(2), -- State that the Look-up value applies to.
  "LAST_CHANGE_DATE" date, -- Last change date for the look-up.
  "RETIRED_FLAG" character(1),
  CONSTRAINT "PK_LU_LEGAL_STATUS" PRIMARY KEY ("LU_SEQ_NO"),
  CONSTRAINT "UK_LU_LEGAL_STATUS-CONTEXT_VALUE" UNIQUE ("CONTEXT", "VALUE")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."LU_LEGAL_STATUS"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."LU_LEGAL_STATUS"
  IS 'Look up table for Legal Status.';
COMMENT ON COLUMN "WADE"."LU_LEGAL_STATUS"."LU_SEQ_NO" IS 'A unique identifier for the Look-up value.';
COMMENT ON COLUMN "WADE"."LU_LEGAL_STATUS"."CONTEXT" IS 'Context for the lookk-up value';
COMMENT ON COLUMN "WADE"."LU_LEGAL_STATUS"."VALUE" IS 'Look up value.';
COMMENT ON COLUMN "WADE"."LU_LEGAL_STATUS"."DESCRIPTION" IS 'Description of the look-up value.';
COMMENT ON COLUMN "WADE"."LU_LEGAL_STATUS"."STATE" IS 'State that the Look-up value applies to.';
COMMENT ON COLUMN "WADE"."LU_LEGAL_STATUS"."LAST_CHANGE_DATE" IS 'Last change date for the look-up.';


-- Trigger: TG_LU_LEGAL_STATUS_CHANGE on "WADE"."LU_LEGAL_STATUS"

-- DROP TRIGGER "TG_LU_LEGAL_STATUS_CHANGE" ON "WADE"."LU_LEGAL_STATUS";

CREATE TRIGGER "TG_LU_LEGAL_STATUS_CHANGE"
  BEFORE INSERT OR UPDATE
  ON "WADE"."LU_LEGAL_STATUS"
  FOR EACH ROW
  EXECUTE PROCEDURE "WADE"."UPDATE_CHANGE_DATE"();

