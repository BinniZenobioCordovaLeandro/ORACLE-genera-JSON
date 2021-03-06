
  CREATE TABLE "DYNAMICFORMS_SVI"."PARAM_VIEW_FILTER_DATA"
   (	"ID" NUMBER(10,0) NOT NULL ENABLE,
	"REF_PARAM_VIEW" NUMBER(10,0) NOT NULL ENABLE,
	"CODE_VALUE" VARCHAR2(200) NOT NULL ENABLE,
	"DELETED" NUMBER(1,0) DEFAULT 0,
	"INSERT_DATETIME" DATE,
	"INSERT_USER" VARCHAR2(128),
	"LASTUPDATE_DATETIME" DATE,
	"LASTUPDATE_USER" VARCHAR2(128),
	"CANCEL_DATETIME" DATE,
	"CANCEL_USER" VARCHAR2(128),
	"ROW_VERSION" NUMBER DEFAULT 0,
	 CONSTRAINT "PK_PARAM_VIEW_FILTER_DATA" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI"  ENABLE,
	 CONSTRAINT "FK_PV_FILTER_PARAM_VIEW" FOREIGN KEY ("REF_PARAM_VIEW")
	  REFERENCES "DYNAMICFORMS_SVI"."PARAM_VIEWS" ("ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI" 
