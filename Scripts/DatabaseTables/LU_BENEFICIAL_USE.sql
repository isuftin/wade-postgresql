﻿-- Table: "WADE"."LU_BENEFICIAL_USE"

-- DROP TABLE "WADE"."LU_BENEFICIAL_USE";

CREATE TABLE "WADE"."LU_BENEFICIAL_USE"
(
  "LU_SEQ_NO" numeric(18,0) NOT NULL, -- A unique identifier for the Look-up value.
  "CONTEXT" character varying(10) NOT NULL, -- Context for the lookk-up value
  "VALUE" character varying(35) NOT NULL, -- Look up value.
  "DESCRIPTION" character varying(255), -- Description of the look-up value.
  "STATE" character(2), -- State that the Look-up value applies to.
  "LAST_CHANGE_DATE" date, -- Last change date for the look-up.
  "RETIRED_FLAG" character(1),
  CONSTRAINT "PK_LU_BENEFICIAL_USE" PRIMARY KEY ("LU_SEQ_NO"),
  CONSTRAINT "UK_LU_BENEFICIAL_USE-CONTEXT_VALUE" UNIQUE ("CONTEXT", "VALUE")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."LU_BENEFICIAL_USE"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."LU_BENEFICIAL_USE"
  IS 'Look up table for Beneficial Uses.';
COMMENT ON COLUMN "WADE"."LU_BENEFICIAL_USE"."LU_SEQ_NO" IS 'A unique identifier for the Look-up value.';
COMMENT ON COLUMN "WADE"."LU_BENEFICIAL_USE"."CONTEXT" IS 'Context for the lookk-up value';
COMMENT ON COLUMN "WADE"."LU_BENEFICIAL_USE"."VALUE" IS 'Look up value.';
COMMENT ON COLUMN "WADE"."LU_BENEFICIAL_USE"."DESCRIPTION" IS 'Description of the look-up value.';
COMMENT ON COLUMN "WADE"."LU_BENEFICIAL_USE"."STATE" IS 'State that the Look-up value applies to.';
COMMENT ON COLUMN "WADE"."LU_BENEFICIAL_USE"."LAST_CHANGE_DATE" IS 'Last change date for the look-up.';


-- Trigger: TG_LU_BENEFICIAL_USE_CHANGE on "WADE"."LU_BENEFICIAL_USE"

-- DROP TRIGGER "TG_LU_BENEFICIAL_USE_CHANGE" ON "WADE"."LU_BENEFICIAL_USE";

CREATE TRIGGER "TG_LU_BENEFICIAL_USE_CHANGE"
  BEFORE INSERT OR UPDATE
  ON "WADE"."LU_BENEFICIAL_USE"
  FOR EACH ROW
  EXECUTE PROCEDURE "WADE"."UPDATE_CHANGE_DATE"();

