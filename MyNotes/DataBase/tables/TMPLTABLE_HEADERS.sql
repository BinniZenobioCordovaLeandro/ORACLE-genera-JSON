
  CREATE TABLE "DYNAMICFORMS_SVI"."TMPLTABLE_HEADERS"
   (	"ID" NUMBER(10,0) NOT NULL ENABLE,
	"REF_TMPLSECTION" NUMBER(10,0) NOT NULL ENABLE,
	"NAME" VARCHAR2(300),
	"POSITION_INDEX" NUMBER DEFAULT 0,
	"COLUMN_WIDTH" NUMBER(10,0),
	"TYPE_WIDTH" VARCHAR2(10),
	"ROW_VERSION" NUMBER DEFAULT 0,
	"DELETED" NUMBER(1,0) DEFAULT 0,
	"INSERT_DATETIME" DATE,
	"INSERT_USER" VARCHAR2(128),
	"LASTUPDATE_DATETIME" DATE,
	"LASTUPDATE_USER" VARCHAR2(128),
	"CANCEL_DATETIME" DATE,
	"CANCEL_USER" VARCHAR2(128),
	"EXTERNAL_ID" NUMBER(18,0),
	"REF_ENTRY" NUMBER(10,0),
	 CHECK (
  TYPE_WIDTH IN ('%', 'PX')
) ENABLE,
	 CHECK (
  DELETED IN (0, 1)
) ENABLE,
	 CONSTRAINT "PK_TMPLTABLE_HEADERS" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI"  ENABLE,
	 CONSTRAINT "FK_TMPLTBL_HEAD_TMPLSECT_1" FOREIGN KEY ("REF_TMPLSECTION")
	  REFERENCES "DYNAMICFORMS_SVI"."TMPLSECTIONS" ("ID") ENABLE,
	 CONSTRAINT "FK_TMPLHEADER_ENTRY" FOREIGN KEY ("REF_ENTRY")
	  REFERENCES "DYNAMICFORMS_SVI"."ENTRIES" ("ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI"

   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLTABLE_HEADERS"."ID" IS 'Identificativo numerico assegnato dal sistema'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLTABLE_HEADERS"."REF_TMPLSECTION" IS 'Indica l''''insieme di header per lo stesso code (tabella)'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLTABLE_HEADERS"."NAME" IS 'Titolo colonna'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLTABLE_HEADERS"."POSITION_INDEX" IS 'Numero colonna a cui si riferisce l''header'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLTABLE_HEADERS"."COLUMN_WIDTH" IS 'Larghezza della colonna'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLTABLE_HEADERS"."TYPE_WIDTH" IS 'Tipologia della grandezza (PX o %)'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLTABLE_HEADERS"."EXTERNAL_ID" IS 'Riferimento id sistema esterno di origine'
