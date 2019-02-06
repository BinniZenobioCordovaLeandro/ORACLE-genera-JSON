create or replace procedure PC_GENERA_JSON_DA_ISTANZE(inputCodiceScheda IN varchar2)
IS
  type istanzeList is table of number;
  istanze istanzeList;
  json_istanza CLOB;

  codiceScheda varchar2(200);
BEGIN
  codiceScheda := inputCodiceScheda;
  json_istanza := '';
  DBMS_OUTPUT.put_line('=> query : select * from ACTIVITIES where REF_ACTYPE in (select id from TMPLCOMPONENTS WHERE CODE = '||codiceScheda||')');
  select ID
  bulk collect into istanze
  from ACTIVITIES where REF_ACTYPE  in (select id from TMPLCOMPONENTS WHERE CODE = codiceScheda);

  FOR indx in 1 .. istanze.COUNT
  LOOP
    DBMS_OUTPUT.put_line('=> query : insert into CACHE_ISTANZA_SCHEDA(variabile, valore) select * from ANSWERS a join TMP_MODELO_FM2_FM3 m on a.REF_TMPLANSWER = m.CODICE_ELEMENTO where a.ID '||istanze(indx)||')');

    insert into CACHE_ISTANZA_SCHEDA(VARIABILE, VALORE)
      select m.NG_MODEL as VARIABILE, COALESCE (TO_CHAR(m.NG_VALUE),TO_CHAR(a.ANSWER), null) VALORE
      from ANSWERS a
      join TMP_MODELO_FM2_FM3 m on a.REF_TMPLANSWER = m.CODICE_ELEMENTO
      where a.REF_ACTIVITY = istanze(indx);

    insert into TMP_ISTANZA_SCHEDA(codice_scheda_FM2,paziente, ENTRY_DATETIME, codice_istanza, json_istanza) values(codiceScheda,0001,sysdate,istanze(indx),FN_GENERA_JSON_DA_CACHE());

    DBMS_OUTPUT.put_line('JSON ISTANZA '||istanze(indx)||' => '||json_istanza);
    execute immediate 'TRUNCATE TABLE CACHE_ISTANZA_SCHEDA';
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
  raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
