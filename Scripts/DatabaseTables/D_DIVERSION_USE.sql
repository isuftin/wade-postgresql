-- Table: "WADE"."D_DIVERSION_USE"

-- DROP TABLE "WADE"."D_DIVERSION_USE";

CREATE TABLE "WADE"."D_DIVERSION_USE"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier assigned to the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the report by the reporting organization.
  "ALLOCATION_ID" character varying(60) NOT NULL, -- A unique identifier for the allocation.
  "DIVERSION_ID" character varying(35) NOT NULL, -- A unique identifier for the diversion.
  "DETAIL_SEQ_NO" numeric(18,0) NOT NULL,
  "BENEFICIAL_USE_ID" numeric(18,0) NOT NULL, -- A unique identifier identifying the beneficial use.
  CONSTRAINT "PK_D_DIVERSION_USE" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "DETAIL_SEQ_NO", "DIVERSION_ID", "BENEFICIAL_USE_ID"),
  CONSTRAINT "FK_D_DIVERSION_USE-D_DIVERSION_FLOW" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "DIVERSION_ID", "DETAIL_SEQ_NO")
      REFERENCES "WADE"."D_DIVERSION_FLOW" ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "DIVERSION_ID", "DETAIL_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_DIVERSION_USE-LU_BENEFICIAL_USE" FOREIGN KEY ("BENEFICIAL_USE_ID")
      REFERENCES "WADE"."LU_BENEFICIAL_USE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."D_DIVERSION_USE"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."D_DIVERSION_USE"
  IS 'Uses associated with an allocated amount at each diversion.';
COMMENT ON COLUMN "WADE"."D_DIVERSION_USE"."ORGANIZATION_ID" IS ' A unique identifier assigned to the organization.';
COMMENT ON COLUMN "WADE"."D_DIVERSION_USE"."REPORT_ID" IS 'A unique identifier assigned to the report by the reporting organization.';
COMMENT ON COLUMN "WADE"."D_DIVERSION_USE"."ALLOCATION_ID" IS 'A unique identifier for the allocation.';
COMMENT ON COLUMN "WADE"."D_DIVERSION_USE"."DIVERSION_ID" IS 'A unique identifier for the diversion.';
COMMENT ON COLUMN "WADE"."D_DIVERSION_USE"."BENEFICIAL_USE_ID" IS 'A unique identifier identifying the beneficial use.';


-- Index: "WADE"."FKI_D_DIVERSION_USE-D_DIVERSION_FLOW"

-- DROP INDEX "WADE"."FKI_D_DIVERSION_USE-D_DIVERSION_FLOW";

CREATE INDEX "FKI_D_DIVERSION_USE-D_DIVERSION_FLOW"
  ON "WADE"."D_DIVERSION_USE"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "ALLOCATION_ID" COLLATE pg_catalog."default", "DIVERSION_ID" COLLATE pg_catalog."default", "DETAIL_SEQ_NO");

-- Index: "WADE"."FKI_D_DIVERSION_USE-LU_BENEFICIAL_USE"

-- DROP INDEX "WADE"."FKI_D_DIVERSION_USE-LU_BENEFICIAL_USE";

CREATE INDEX "FKI_D_DIVERSION_USE-LU_BENEFICIAL_USE"
  ON "WADE"."D_DIVERSION_USE"
  USING btree
  ("BENEFICIAL_USE_ID");

