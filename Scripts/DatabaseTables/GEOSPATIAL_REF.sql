-- Table: "WADE"."GEOSPATIAL_REF"

-- DROP TABLE "WADE"."GEOSPATIAL_REF";

CREATE TABLE "WADE"."GEOSPATIAL_REF"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- Unique identifier assigned to the organziation.
  "REPORT_ID" character varying(35) NOT NULL, -- Report identifier.
  "WFS_ID" character varying(35) NOT NULL, -- Unique identifier for each web feature service.
  "WFS_DATACATEGORY" character varying(80) NOT NULL, -- Datacategory of the web feature service. Use summary view table.
  "WFS_DATATYPE" character varying(80) NOT NULL, -- Datatype of the web feature service. Use summary view table.
  "WFS_ADDRESS" character varying(200) NOT NULL, -- URL address of the web feature service.
  "WFS_FEATURE_ID_FIELD" character varying(35), -- Column in the web feature service that contains the unique identifier for each feature - OBJECTID or FEATUREID.
  CONSTRAINT "PK_GEOSPATIAL_REF" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "WFS_ID"),
  CONSTRAINT "FK_GEOSPATIAL-REPORT" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID")
      REFERENCES "WADE"."REPORT" ("ORGANIZATION_ID", "REPORT_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."GEOSPATIAL_REF"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."GEOSPATIAL_REF"
  IS 'Organization responsible for the data reported.';
COMMENT ON COLUMN "WADE"."GEOSPATIAL_REF"."ORGANIZATION_ID" IS 'Unique identifier assigned to the organziation.';
COMMENT ON COLUMN "WADE"."GEOSPATIAL_REF"."REPORT_ID" IS 'Report identifier.';
COMMENT ON COLUMN "WADE"."GEOSPATIAL_REF"."WFS_ID" IS 'Unique identifier for each web feature service.';
COMMENT ON COLUMN "WADE"."GEOSPATIAL_REF"."WFS_DATACATEGORY" IS 'Datacategory of the web feature service. Use summary view table.';
COMMENT ON COLUMN "WADE"."GEOSPATIAL_REF"."WFS_DATATYPE" IS 'Datatype of the web feature service. Use summary view table.';
COMMENT ON COLUMN "WADE"."GEOSPATIAL_REF"."WFS_ADDRESS" IS 'URL address of the web feature service.';
COMMENT ON COLUMN "WADE"."GEOSPATIAL_REF"."WFS_FEATURE_ID_FIELD" IS 'Column in the web feature service that contains the unique identifier for each feature - OBJECTID or FEATUREID.';


-- Index: "WADE"."FKI_GEOSPATIAL-REPORT"

-- DROP INDEX "WADE"."FKI_GEOSPATIAL-REPORT";

CREATE INDEX "FKI_GEOSPATIAL-REPORT"
  ON "WADE"."GEOSPATIAL_REF"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default");

