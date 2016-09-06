-- Table: "WADE"."D_ALLOCATION_USE"

-- DROP TABLE "WADE"."D_ALLOCATION_USE";

CREATE TABLE "WADE"."D_ALLOCATION_USE"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier assigned to the organziation.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the report by the reporting organziation.
  "ALLOCATION_ID" character varying(60) NOT NULL, -- A unique identifier for the allocation.
  "DETAIL_SEQ_NO" numeric(18,0) NOT NULL,
  "BENEFICIAL_USE_ID" numeric(18,0) NOT NULL, -- A unique identifier identifying the beneficial use.
  CONSTRAINT "PK_D_ALLOCATION_USE" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "DETAIL_SEQ_NO", "BENEFICIAL_USE_ID"),
  CONSTRAINT "FK_D_ALLOCATION_USE-D_ALLOCATION_FLOW" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "DETAIL_SEQ_NO")
      REFERENCES "WADE"."D_ALLOCATION_FLOW" ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "DETAIL_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_ALLOCATION_USE-LU_BENEFICIAL_USE" FOREIGN KEY ("BENEFICIAL_USE_ID")
      REFERENCES "WADE"."LU_BENEFICIAL_USE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."D_ALLOCATION_USE"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."D_ALLOCATION_USE"
  IS 'Defines the amount of water attributed to the entire allocation.  If an allocation ahs diversions associated with it, then report the information for each diversion.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_USE"."ORGANIZATION_ID" IS ' A unique identifier assigned to the organziation.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_USE"."REPORT_ID" IS 'A unique identifier assigned to the report by the reporting organziation.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_USE"."ALLOCATION_ID" IS 'A unique identifier for the allocation.';
COMMENT ON COLUMN "WADE"."D_ALLOCATION_USE"."BENEFICIAL_USE_ID" IS 'A unique identifier identifying the beneficial use.';


-- Index: "WADE"."FKI_D_ALLOCATION_USE-D_ALLOCATION_FLOW"

-- DROP INDEX "WADE"."FKI_D_ALLOCATION_USE-D_ALLOCATION_FLOW";

CREATE INDEX "FKI_D_ALLOCATION_USE-D_ALLOCATION_FLOW"
  ON "WADE"."D_ALLOCATION_USE"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "ALLOCATION_ID" COLLATE pg_catalog."default", "DETAIL_SEQ_NO");

-- Index: "WADE"."FKI_D_ALLOCATION_USE-LU_BENEFICIAL_USE"

-- DROP INDEX "WADE"."FKI_D_ALLOCATION_USE-LU_BENEFICIAL_USE";

CREATE INDEX "FKI_D_ALLOCATION_USE-LU_BENEFICIAL_USE"
  ON "WADE"."D_ALLOCATION_USE"
  USING btree
  ("BENEFICIAL_USE_ID");

