create table TMP_MODELO_FM2_FM3(
  id integer PRIMARY KEY,
  ng_model varchar2(200), -- determinato per il utente (guidato da testo_section.testo_domanda.testo_risposta).
  ng_value varchar2(200), -- determinato per il utente (guidato da value_score e tipo_riposta_N).
  testo_section varchar2(200),
  testo_domanda varchar2(200),
  testo_risposta varchar2(200),
  value_score VARCHAR2(200),
  tipo_riposta_N varchar2(200),
  codice_elemento varchar(200),
  ref_code_scheda varchar2(200)
);

create sequence SEQ_TMP_MODELO_FM2_FM3 start with 21 increment by 1 maxvalue 2018;

create or replace trigger TMP_MODELO_FM2_FM3
  BEFORE INSERT on TMP_MODELO_FM2_FM3
  FOR EACH ROW
BEGIN
  select SEQ_TMP_MODELO_FM2_FM3.nextval
  into :new.id
  from dual;
END;


create or replace table TMP_ISTANZA_SCHEDA(
  id integer PRIMARY KEY,
  codice_scheda_FM2 varchar2(200),
  paziente number,
  ENTRY_DATETIME Date,
  codice_istanza number,
  json_istanza CLOB
);

create sequence SEQ_TMP_ISTANZA_SCHEDA start with 21 increment by 1 maxvalue 2018;

create or replace trigger TMP_ISTANZA_SCHEDA
  BEFORE INSERT on TMP_ISTANZA_SCHEDA
  FOR EACH ROW
BEGIN
  select SEQ_TMP_ISTANZA_SCHEDA.nextval
  into :new.id
  from dual;
END;


create table CACHE_ISTANZA_SCHEDA(
    id numeric primary key,
    variabile varchar2(500),
    valore varchar2(500)
);

create sequence SEQ_CACHE_ISTANZA_SCHEDA start with 21 increment by 1 maxvalue 2018;

create or replace trigger CACHE_ISTANZA_SCHEDA
  BEFORE INSERT on CACHE_ISTANZA_SCHEDA
  FOR EACH ROW
BEGIN
  select SEQ_CACHE_ISTANZA_SCHEDA.nextval
  into :new.id
  from dual;
END;
