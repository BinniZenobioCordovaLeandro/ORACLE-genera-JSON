
  CREATE TABLE "DYNAMICFORMS_SVI"."PS_GENEVA_SCORE_CONFIG"
   (	"ID" NUMBER(10,0) NOT NULL ENABLE,
	"CODE" VARCHAR2(255) NOT NULL ENABLE,
	"DESCRIPTION" VARCHAR2(300),
	"TYPE" VARCHAR2(255) NOT NULL ENABLE,
	"REF_PARENT" NUMBER(10,0),
	"SCORE" NUMBER(10,0),
	"SCORE_MIN" NUMBER(10,0),
	"SCORE_MAX" NUMBER(10,0),
	"COLOR" VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI" 
