
  CREATE TABLE "DYNAMICFORMS_SVI"."ANSWERS"
   (	"ID" NUMBER(10,0) NOT NULL ENABLE,
	"REF_TMPLITEM" NUMBER(10,0) NOT NULL ENABLE,
	"REF_ACTIVITY" NUMBER(10,0) NOT NULL ENABLE,
	"REF_TMPLANSWER" NUMBER(10,0) NOT NULL ENABLE,
	"REPEATABLE_SECTION_INDEX" NUMBER(10,0), 
	"REF_TMPLTBL_HDR" NUMBER(10,0),
	"ROW_VERSION" NUMBER DEFAULT 0,
	"DELETED" NUMBER(1,0) DEFAULT 0,
	"INSERT_DATETIME" DATE,
	"INSERT_USER" VARCHAR2(128),
	"LASTUPDATE_DATETIME" DATE,
	"LASTUPDATE_USER" VARCHAR2(128),
	"CANCEL_DATETIME" DATE,
	"CANCEL_USER" VARCHAR2(128),
	"EXTERNAL_ID" NUMBER(18,0),
	"EXTERNAL_TAB" VARCHAR2(128),
	"REPEATABLE_SECTION_CODE" VARCHAR2(128),
	"ANSWER" CLOB,
	 CHECK (
  DELETED IN (0, 1)
) ENABLE,
	 CONSTRAINT "PK_ANSWERS" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI"  ENABLE,
	 CONSTRAINT "FK_ANSWER_ACTIVITY_1" FOREIGN KEY ("REF_ACTIVITY")
	  REFERENCES "DYNAMICFORMS_SVI"."ACTIVITIES" ("ID") ENABLE,
	 CONSTRAINT "FK_ANSWER_TMPLANSWER_1" FOREIGN KEY ("REF_TMPLANSWER")
	  REFERENCES "DYNAMICFORMS_SVI"."TMPLANSWERS" ("ID") ENABLE,
	 CONSTRAINT "FK_ANSWER_TMPLITEM_1" FOREIGN KEY ("REF_TMPLITEM")
	  REFERENCES "DYNAMICFORMS_SVI"."TMPLITEMS" ("ID") ENABLE,
	 CONSTRAINT "FK_ANSWER_TMPLTABL_H_1" FOREIGN KEY ("REF_TMPLTBL_HDR")
	  REFERENCES "DYNAMICFORMS_SVI"."TMPLTABLE_HEADERS" ("ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI"
 LOB ("ANSWER") STORE AS BASICFILE (
  TABLESPACE "DYNAMIC_FORMS_SVI" ENABLE STORAGE IN ROW CHUNK 8192 RETENTION
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT))

   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."ANSWERS"."ID" IS 'Identificativo numerico assegnato dal sistema'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."ANSWERS"."REF_TMPLITEM" IS 'Riferimento a TMPLITEM (la specifica domanda prevista dalla struttura della scheda)'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."ANSWERS"."REPEATABLE_SECTION_INDEX" IS 'Indica l''indice della sezione ripetibile a cui corrisponde la risposta'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."ANSWERS"."REF_TMPLTBL_HDR" IS 'Riferimento alla colonna della sezione di tipo tabella'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."ANSWERS"."EXTERNAL_ID" IS 'Riferimento id sistema esterno di origine'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."ANSWERS"."EXTERNAL_TAB" IS 'Riferimento tabella sistema esterno di origine'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."ANSWERS"."REPEATABLE_SECTION_CODE" IS 'Indica il codice della sezione ripetibile codificata a cui corrisponde la risposta'
