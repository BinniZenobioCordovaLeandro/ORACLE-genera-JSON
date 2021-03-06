
  CREATE TABLE "DYNAMICFORMS_SVI"."TMPLANSWERS"
   (	"ID" NUMBER(10,0) NOT NULL ENABLE,
	"VALUE" VARCHAR2(4000),
	"REF_TMPLITEM" NUMBER(10,0) NOT NULL ENABLE,
	"MANDATORY" NUMBER(1,0) DEFAULT 0,
	"TYPE_OF_ANSWER" VARCHAR2(200),
	"NOTE" VARCHAR2(4000),
	"UNIQUE_ANSWER" NUMBER(1,0) DEFAULT 0,
	"TAG_XML_ANSWER" VARCHAR2(200),
	"TAG_XML_ANSWER_DESC" VARCHAR2(200),
	"TAG_XML_ANSWER_CODE" VARCHAR2(200),
	"STYLE_CSS" VARCHAR2(300),
	"REF_PARAM_VIEW" NUMBER(10,0),
	"DEFAULT_XPATH" VARCHAR2(300),
	"POSITION_INDEX" NUMBER DEFAULT 0 NOT NULL ENABLE,
	"READ_ONLY" NUMBER(1,0) DEFAULT 0,
	"FL_TRANSIENT" NUMBER(1,0) DEFAULT 0,
	"PARENT_TMPLANSWER_CODE" VARCHAR2(128),
	"PATTERN" VARCHAR2(200),
	"REF_ENTRY" NUMBER(10,0),
	"MIN_QUERY_LENGTH" NUMBER(10,0),
	 CHECK (
  MANDATORY IN (0, 1)
) ENABLE,
	 CHECK (
  UNIQUE_ANSWER IN (0, 1)
) ENABLE,
	 CHECK (
  READ_ONLY IN (0, 1)
) ENABLE,
	 CHECK (
  FL_TRANSIENT IN (0, 1)
) ENABLE,
	 CONSTRAINT "PK_TMPLANSWERS" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI"  ENABLE,
	 CONSTRAINT "FK_ASS_13" FOREIGN KEY ("ID")
	  REFERENCES "DYNAMICFORMS_SVI"."TMPLCOMPONENTS" ("ID") ENABLE,
	 CONSTRAINT "FK_TMPLANSWER_PARAMVIEW_1" FOREIGN KEY ("REF_PARAM_VIEW")
	  REFERENCES "DYNAMICFORMS_SVI"."PARAM_VIEWS" ("ID") ENABLE,
	 CONSTRAINT "FK_TMPLANSWER_TMPLITEM_1" FOREIGN KEY ("REF_TMPLITEM")
	  REFERENCES "DYNAMICFORMS_SVI"."TMPLITEMS" ("ID") ENABLE,
	 CONSTRAINT "FK_TMPLANSWER_ENTRY" FOREIGN KEY ("REF_ENTRY")
	  REFERENCES "DYNAMICFORMS_SVI"."ENTRIES" ("ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DYNAMIC_FORMS_SVI"

   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."ID" IS 'Identificativo numerico assegnato dal sistema'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."VALUE" IS 'Valore (testo) della risposta'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."REF_TMPLITEM" IS 'Riferimento che identifica la domanda alla quale la risposta si riferisce'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."MANDATORY" IS 'Obbligo di risposta'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."TYPE_OF_ANSWER" IS 'Tipo di risposta (RADIO_BUTTON/CHECK_BOX)'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."NOTE" IS 'Eventuali note della risposta'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."UNIQUE_ANSWER" IS 'Indica che questa risposta, se selezionata, deve essere l''unica'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."TAG_XML_ANSWER" IS 'Indica il tag da utilizzare in XML per le risposte'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."TAG_XML_ANSWER_DESC" IS 'Indica il tag da utilizzare in XML per la descrizione testuale delle risposte'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."TAG_XML_ANSWER_CODE" IS 'Indica il tag da utilizzare in XML per il codice delle risposte'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."STYLE_CSS" IS 'Indica lo style del componente'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."REF_PARAM_VIEW" IS 'Valorizzato solo per i componenti combo. Indica l''ID sulla tabella PARAM_VIEW che corrisponde ad una vista o datasource o query.'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."DEFAULT_XPATH" IS 'Stringa usata in caso di componente inizializzato tramite XML INIT'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."POSITION_INDEX" IS 'Indica l''ordine del componente (posizione)'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."READ_ONLY" IS 'Indica se la risposa è in sola lettura'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."FL_TRANSIENT" IS 'Indica, per i tipi Combo, se il valore selezionato va salvato alla compilazione oppuere no. Se non va salvato è semplicemente una combo di suggestion.'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."PARENT_TMPLANSWER_CODE" IS 'Indica il codice della risposta padre (TMPLANSWERS) per il filtro dei valori delle combo'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."PATTERN" IS 'Pattern di input/view per: DateTime, Date, Ora'
   COMMENT ON COLUMN "DYNAMICFORMS_SVI"."TMPLANSWERS"."MIN_QUERY_LENGTH" IS 'Min query length per componente autocomplete'
