
  CREATE TABLE "DYNAMICFORMS_SVI"."CHART_DATA"
   (	"ID" NUMBER(10,0) NOT NULL ENABLE,
	"REF_TMPLANSWER" NUMBER(10,0),
	"REF_TMPLSECTION" NUMBER(10,0),
	"X_AXIS_LABEL" VARCHAR2(200),
	"Y_AXIS_LABEL" VARCHAR2(200),
	"MIN_X" NUMBER(10,2),
	"MAX_X" NUMBER(10,2),
	"MIN_Y" NUMBER(10,2),
	"MAX_Y" NUMBER(10,2),
	"NUMBER_OF_TICKS_X" NUMBER(4,0),
	"NUMBER_OF_TICKS_Y" NUMBER(4,0),
	"LEGEND_ROWS" NUMBER(2,0) DEFAULT 1,
	"LEGEND_POSITION" CHAR(2) DEFAULT 's',
	"DELETED" NUMBER(1,0) DEFAULT 0,
	"INSERT_DATETIME" DATE,
	"INSERT_USER" VARCHAR2(128),
	"LASTUPDATE_DATETIME" DATE,
	"LASTUPDATE_USER" VARCHAR2(128),
	"CANCEL_DATETIME" DATE,
	"CANCEL_USER" VARCHAR2(128),
	"FL_MAIN_SERIES" NUMBER(1,0) DEFAULT 0,
	"ROW_VERSION" NUMBER DEFAULT 0,
	"SERIES_NAME" VARCHAR2(128) NOT NULL ENABLE,
	"POSITION_INDEX" NUMBER(10,0),
	"MARKER_STYLE" VARCHAR2(128),
	"SERIES_COLOR" VARCHAR2(128),
	"LEGEND_ICON" VARCHAR2(200),
	"REF_SERIES_TMPLITEM" NUMBER(10,0),
	"FL_HIDE_LINES" NUMBER DEFAULT 0,
	"CHART_EXTENDER_FN" VARCHAR2(200),
	 CHECK (
  DELETED IN (0, 1)
) ENABLE,
	 CONSTRAINT "PK_CHART_DATA" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI"  ENABLE,
	 CHECK (  FL_HIDE_LINES IN (0, 1)) ENABLE,
	 CHECK (  FL_HIDE_LINES IN (0, 1)) ENABLE,
	 CHECK (  FL_HIDE_LINES IN (0, 1)) ENABLE,
	 CHECK (  FL_HIDE_LINES IN (0, 1)) ENABLE,
	 CHECK (  FL_HIDE_LINES IN (0, 1)) ENABLE,
	 CONSTRAINT "FK_CHART_DATA_TMPLANSWER" FOREIGN KEY ("REF_TMPLANSWER")
	  REFERENCES "DYNAMICFORMS_SVI"."TMPLANSWERS" ("ID") ENABLE,
	 CONSTRAINT "FK_CHART_DATA_TMPLSECTION" FOREIGN KEY ("REF_TMPLSECTION")
	  REFERENCES "DYNAMICFORMS_SVI"."TMPLSECTIONS" ("ID") ENABLE,
	 CONSTRAINT "FK_CHART_DATA_TMPLITEM" FOREIGN KEY ("REF_SERIES_TMPLITEM")
	  REFERENCES "DYNAMICFORMS_SVI"."TMPLITEMS" ("ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI"

   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."CHART_DATA"."SERIES_NAME" IS 'series name'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."CHART_DATA"."POSITION_INDEX" IS 'Indica posizione della serie nella legenda'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."CHART_DATA"."MARKER_STYLE" IS 'Indica marker per i punti sul grafico: diamond, circle, square, x etc'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."CHART_DATA"."SERIES_COLOR" IS 'Indica colore della serie'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."CHART_DATA"."LEGEND_ICON" IS 'Indica icona per la legenda necessarie per compatibilità con IE compatibility mode IE<9'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."CHART_DATA"."FL_HIDE_LINES" IS 'Indica se tracciare le line delle serie o meno'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."CHART_DATA"."CHART_EXTENDER_FN" IS 'Indica la funzione che viene invocato lato client per rendering del chart di primefaces'