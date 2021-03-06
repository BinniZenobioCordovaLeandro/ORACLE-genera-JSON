
  CREATE TABLE "DYNAMICFORMS_SVI"."IMAGE_POINTS"
   (	"ID" NUMBER(10,0) NOT NULL ENABLE,
	"DESCRIPTION" VARCHAR2(200),
	"CODE" VARCHAR2(128),
	"POSITION_X" NUMBER(10,0),
	"POSITION_Y" NUMBER(10,0),
	"TOOLTIP" VARCHAR2(200),
	"COLOR" VARCHAR2(128),
	"REF_TMPLANSWER" NUMBER(10,0),
	"ROW_VERSION" NUMBER DEFAULT 0,
	"DELETED" NUMBER(1,0) DEFAULT 0,
	"INSERT_DATETIME" DATE,
	"INSERT_USER" VARCHAR2(128),
	"LASTUPDATE_DATETIME" DATE,
	"LASTUPDATE_USER" VARCHAR2(128),
	"CANCEL_DATETIME" DATE,
	"CANCEL_USER" VARCHAR2(128),
	"JAVASCRIPT_FUNCION_NAME" VARCHAR2(128),
	"JAVASCRIPT_FUNCTION_NAME" VARCHAR2(128),
	 CHECK (
  DELETED IN (0, 1)
) ENABLE,
	 CONSTRAINT "PK_IMAGE_POINTS" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI"  ENABLE,
	 CONSTRAINT "FK_IMAGE_POINT_TMPLANSWER_1" FOREIGN KEY ("REF_TMPLANSWER")
	  REFERENCES "DYNAMICFORMS_SVI"."TMPLANSWERS" ("ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI"

   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."IMAGE_POINTS"."DESCRIPTION" IS 'Descrizione punto.'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."IMAGE_POINTS"."CODE" IS 'Codice punto, utilizzato per l''associazione con le risposte.'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."IMAGE_POINTS"."POSITION_X" IS 'Coordinata x del punto.'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."IMAGE_POINTS"."POSITION_Y" IS 'Coordinata y del punto.'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."IMAGE_POINTS"."TOOLTIP" IS 'Tooltip punto.'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."IMAGE_POINTS"."COLOR" IS 'Colore punto.'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."IMAGE_POINTS"."REF_TMPLANSWER" IS 'Riferimento al componente risposta.'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."IMAGE_POINTS"."JAVASCRIPT_FUNCTION_NAME" IS 'Nome funzione javascript da chiamare su evento click.'
