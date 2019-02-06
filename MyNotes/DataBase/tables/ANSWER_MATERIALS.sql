
  CREATE TABLE "DYNAMICFORMS_SVI"."ANSWER_MATERIALS"
   (	"ID" NUMBER(10,0) NOT NULL ENABLE,
	"REF_ANSWER" NUMBER(10,0),
	"MATERIAL_ID" VARCHAR2(128),
	"MATERIAL_NAME" VARCHAR2(200),
	"MATERIAL_SIZE_VALUE" NUMBER(10,2),
	"MATERIAL_SIZE_UNIT" VARCHAR2(200),
	"MATERIAL_SIZE_TYPE" VARCHAR2(200),
	"MATERIAL_BARCODE" VARCHAR2(4000),
	"MATERIAL_TYPE" VARCHAR2(200),
	"MATERIAL_PRESSURE" VARCHAR2(200),
	"MATERIAL_PRESSURE_TYPE" VARCHAR2(200),
	"MATERIAL_ENERGY" VARCHAR2(200),
	"NOTES" VARCHAR2(4000),
	"ROW_VERSION" NUMBER DEFAULT 0,
	"DELETED" NUMBER(1,0) DEFAULT 0,
	"INSERT_DATETIME" DATE,
	"INSERT_USER" VARCHAR2(128),
	"LASTUPDATE_DATETIME" DATE,
	"LASTUPDATE_USER" VARCHAR2(128),
	"CANCEL_DATETIME" DATE,
	"CANCEL_USER" VARCHAR2(128),
	 CHECK (  DELETED IN (0, 1)) ENABLE,
	 CONSTRAINT "PK_ANSWER_MATERIALS" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI"  ENABLE,
	 CHECK (  DELETED IN (0, 1)) ENABLE,
	 CHECK (  DELETED IN (0, 1)) ENABLE,
	 CONSTRAINT "FK_ANSWER_MATERIALS_ANSWER" FOREIGN KEY ("REF_ANSWER")
	  REFERENCES "DYNAMICFORMS_SVI"."ANSWERS" ("ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI"

   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."ANSWER_MATERIALS"."ID" IS 'Identificativo numerico assegnato dal sistema'