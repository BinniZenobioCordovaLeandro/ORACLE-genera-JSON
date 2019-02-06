-- FM2 => JSON => FM3
--scheda pressa come ezempio-> 1036170 , CODIFICHE PATOLOGIE ICPC
SELECT * FROM TMPLCOMPONENTS WHERE id = 1036170;

-- Elementi principali della scheda tipo FM2
SELECT * FROM ACTIVITYTYPES WHERE id = 1036170;
SELECT * FROM TMPLSECTIONS WHERE REF_ACTYPE = 1036170;
SELECT * FROM TMPLITEMS WHERE REF_TMPLSECTION IN (SELECT ID FROM TMPLSECTIONS WHERE REF_ACTYPE = 1036170);
SELECT * FROM TMPLANSWERS WHERE REF_TMPLITEM IN (SELECT ID FROM TMPLITEMS WHERE REF_TMPLSECTION IN (SELECT ID FROM TMPLSECTIONS WHERE REF_ACTYPE = 1036170));

-- le attività portano il gruppo di risposta messa in una scheda.
SELECT * FROM ACTIVITIES WHERE REF_ACTYPE = 1036170;
-- prendiamo a la "istanza" 1029 per vedere le risposte che porta.
-- tutte le risposte fornite dagli utenti secondo 'istanza' 1029.
SELECT * FROM ANSWERS WHERE REF_TMPLANSWER IN (SELECT ID FROM TMPLANSWERS WHERE REF_TMPLITEM IN (SELECT ID FROM TMPLITEMS WHERE REF_TMPLSECTION IN (SELECT ID FROM TMPLSECTIONS WHERE REF_ACTYPE = 1036170))) AND REF_ACTIVITY = 1029;

select
s.id,s.name
from TMPLSECTIONS s
where s.REF_ACTYPE in (SELECT ID FROM TMPLCOMPONENTS WHERE CODE = 'PATOLOGIE_ICPC');

select
  s.id,s.name,m.VALUE
from TMPLSECTIONS s
join METADATA m on s.id = m.REF_TMPLCOMPONENT
where s.REF_ACTYPE in (SELECT ID FROM TMPLCOMPONENTS WHERE CODE = 'PATOLOGIE_ICPC');

select * from TMPLSECTIONS where REF_ACTYPE in (SELECT ID FROM TMPLCOMPONENTS WHERE CODE = 'PATOLOGIE_ICPC');

select * from metadata;

select
    s.id,s.name, m.id, m.KEY, m.value, m.REF_TMPLCOMPONENT
from TMPLSECTIONS s
join METADATA m on m.REF_TMPLCOMPONENT = s.id
where REF_ACTYPE
in (SELECT ID FROM TMPLCOMPONENTS WHERE CODE = 'PATOLOGIE_ICPC');


NOTE: 04 .09. 18


select
      null as ng_model,
      null as ng_value,
      s.name as testo_section,
      null as testo_domanda,
      null as testo_risposta,
      --met.value as value_score,
      'sezione' as TYPE,
      s.id as codice_elemento,
      c.code as ref_code_scheda,
      met.*
    from TMPLSECTIONS s
    left join metadata met on met.REF_TMPLCOMPONENT = s.ID
    join TMPLCOMPONENTS c on s.REF_ACTYPE = c.id
    where
        met.id not in()
        c.CODE = 'PATOLOGIE_ICPC';



--select ID, NAME, REF_PARENT
--from TMPLSECTIONS s
--left join METADATA m on m.EXTERNAL_ID
--where
--REF_ACTYPE in (select ID from TMPLCOMPONENTS where CODE = 'PATOLOGIE_ICPC');


select
    a.id, a.SUBJECT_ID,
    am.ID,
    met.key,met.value
from ACTIVITIES a
join ACTIVITY_METADATA am on a.id = am.REF_ACTIVITY
join METADATA met on met.id = am.id
where
a.REF_ACTYPE in (select ID from TMPLCOMPONENTS where CODE = 'PATOLOGIE_ICPC');

select
    am.id
from ACTIVITY_METADATA am
join ACTIVITIES at on at.ID = am.REF_ACTIVITY
where
at.REF_ACTYPE in (select ID from TMPLCOMPONENTS where CODE = 'PATOLOGIE_ICPC')



  select
        null as ng_model,
        null as ng_value,
        s.name as testo_section,
        null as testo_domanda,
        null as testo_risposta,
        --met.value as value_score,
        'sezione' as TYPE,
        s.id as codice_elemento,
        c.code as ref_code_scheda,
        met.*
      from TMPLSECTIONS s
      left join metadata met on met.REF_TMPLCOMPONENT = s.ID
      join TMPLCOMPONENTS c on s.REF_ACTYPE = c.id
      where
          met.id not in()
          c.CODE = 'PATOLOGIE_ICPC';

select
    *
from METADATA met
where met.id in
(select
    am.id
    from ACTIVITY_METADATA am
    join ACTIVITIES at on at.ID = am.REF_ACTIVITY
    where
    at.REF_ACTYPE in (select ID from TMPLCOMPONENTS where CODE = 'PATOLOGIE_ICPC'));




-- I METADATA non stanno nelle sezione:
-- le sezione portano una cosa come (TOTALSCORE) il quale è valorizado dopo del salvataggio della scheda.
select
    *
from METADATA met
where met.id not in
(select
    am.id
    from ACTIVITY_METADATA am
    join ACTIVITIES at on at.ID = am.REF_ACTIVITY
    where
    at.REF_ACTYPE in (select ID from TMPLCOMPONENTS where CODE = 'PATOLOGIE_ICPC'));

select
    s.id,
    met.key, met.value
from TMPLSECTIONS s
    join METADATA met on met.REF_TMPLCOMPONENT = s.id
where
    s.REF_ACTYPE in (select ID from TMPLCOMPONENTS where CODE = 'PATOLOGIE_ICPC')
    and met.id not in (select
    am.id
    from ACTIVITY_METADATA am
    join ACTIVITIES at on at.ID = am.REF_ACTIVITY
    where
    at.REF_ACTYPE in (select ID from TMPLCOMPONENTS where CODE = 'PATOLOGIE_ICPC'));



NOTE: 04.09.18 16:37



update TMP_MODELO_FM2_FM3
set NG_VALUE = 5
where TESTO_RISPOSTA LIKE '%Molto grave.%';


SELECT
  REGEXP_SUBSTR('500 Oracle Parkway, Redwood Shores, CA',
                '[^,]+') "REGEXPR_SUBSTR"
  FROM DUAL;


select * from TMP_MODELO_FM2_FM3;

select REGEXP_SUBSTR('formData.cirs.patologie.trattoInferiore','.c([^.])+.') as testo from dual;



--select * from ACTIVITIES where REF_ACTYPE in ();

select * from TMP_MODELO_FM2_FM3 where REF_CODE_SCHEDA = 'schedaComorbilitaCIRS' and CODICE_ELEMENTO = 1054061;


select
    a.id
FROM ACTIVITIES a
WHERE
    REF_ACTYPE in (SELECT ID FROM TMPLCOMPONENTS WHERE CODE = 'schedaComorbilitaCIRS');


select
    a.ANSWER , a.REF_TMPLITEM, a.REF_TMPLANSWER,
    m.NG_MODEL, m.NG_VALUE
from ANSWERS a
    join TMP_MODELO_FM2_FM3 m on m.CODICE_ELEMENTO = a.REF_TMPLANSWER
where REF_ACTIVITY in (
                        select
                        a.id
                    FROM ACTIVITIES a
                    WHERE
                        REF_ACTYPE in (SELECT ID FROM TMPLCOMPONENTS WHERE CODE = 'schedaComorbilitaCIRS')
                        )
order by m.id;







NOTE RILEVANTE:

update TMP_MODELO_FM2_FM3 set NG_VALUE = '{ key : "Assente.", value: 1}'
  where TESTO_RISPOSTA = 'Assente.';

select REGEXP_SUBSTR('formData.cirs.patologie.trattoInferiore','.c([^.])+.') as testo from dual;

select * FROM (select
    a.ANSWER, a.REF_TMPLITEM, a.REF_TMPLANSWER,
    m.NG_MODEL, m.NG_VALUE, m.TIPO_RIPOSTA_N
from ANSWERS a
    join TMP_MODELO_FM2_FM3 m on m.CODICE_ELEMENTO = a.REF_TMPLANSWER
where REF_ACTIVITY in (
                        select
                        a.id
                    FROM ACTIVITIES a
                    WHERE
                        REF_ACTYPE in (SELECT ID FROM TMPLCOMPONENTS WHERE CODE = 'schedaComorbilitaCIRS')
                        )
order by m.id);





select
    distinct(a.id),
    regexp_substr(a.testo,'[^.]+', 1, level) as valores,
    level
from (select * from (select 1 as id, 'formData.cirs.patologie.trattoInferiore' as testo from dual UNION ALL select 2 as id, 'formData.cirs.patologie.trattoInferiore' as testo from dual)) a
    connect by regexp_substr(testo,'[^.]+', 1, level) is not null
    order by id, level;








    select
        tabella.NG_MODEL as variabile, tabella.NG_VALUE as valore
    FROM (select
        a.ANSWER, a.REF_TMPLITEM, a.REF_TMPLANSWER,
        m.NG_MODEL, m.NG_VALUE, m.TIPO_RIPOSTA_N
    from ANSWERS a
        join TMP_MODELO_FM2_FM3 m on m.CODICE_ELEMENTO = a.REF_TMPLANSWER
    where REF_ACTIVITY in (
                            select
                            a.id
                        FROM ACTIVITIES a
                        WHERE
                            REF_ACTYPE in (SELECT ID FROM TMPLCOMPONENTS WHERE CODE = 'schedaComorbilitaCIRS')
                            )
    order by m.id) tabella;



NOTE: 05/09/18 16:55


declare
    type sitoList is table of varchar2(500);
    type subSittiList is table of varchar2(500);
    type pathSiteList is table of varchar2(500);
    type datiList is table of varchar2(500);

    text_Json CLOB;
    chiavi numeric;
    pathSite pathSiteList;
    sito sitoList; -- sito attuale nel percorso.
    subSiti subSittiList; -- lita di sitti.
    dati datiList;

begin
    DBMS_OUTPUT.put_line('*START GENEATE JSON*');
    chiavi := 0;
    LOOP
        DBMS_OUTPUT.put_line('Chiavi aperti' || chiavi);
            chiavi := chiavi+1;
        EXIT WHEN chiavi = 10;
    END LOOP;
end;





create table dato_e_padre(
    id numeric primary key,
    dato varchar2(500),
    padre varchar2(500)
)

create sequence SEQ_dato_e_padre start with 21 increment by 1 maxvalue 2018;

create or replace trigger dato_e_padre
  BEFORE INSERT on dato_e_padre
  FOR EACH ROW
BEGIN
  select SEQ_dato_e_padre.nextval
  into :new.id
  from dual;
END;



select distinct(REGEXP_SUBSTR(variabile,'formData.cirs.indice.([^.])+.')) from TMP_DELETE_VAR_VAL;





NOTE 05.09.18

declare
    type sitoList is table of varchar2(500);
    type subSittiList is table of varchar2(500);
    type pathSiteList is table of varchar2(500);
    type datiList is table of varchar2(500);

    text_Json CLOB;
    chiavi numeric;
    pathSite pathSiteList;
    sito varchar2(200); -- sito attuale nel percorso.
    subSiti subSittiList; -- lita di sitti.
    dati varchar2(200);

    percorso varchar2(200);
    testoGenerico varchar2(200);
    carattereSeparatore varchar2(2);

    carratereAttuale varchar2(200);
    carratereVechio varchar2(200);

    nnumero numeric;
begin
    DBMS_OUTPUT.put_line('*START GENEATE JSON*');
    testoGenerico := '';
    carattereSeparatore := '.';
    carratereAttuale := '';
    text_Json := '';
    nnumero := 0;
    LOOP
        carratereVechio := carratereAttuale;
        DBMS_OUTPUT.put_line('}');
        select REGEXP_SUBSTR('formData.cirs.patologie.trattoInferiore',carratereAttuale||'([^.])+.') into carratereAttuale from dual;
        DBMS_OUTPUT.put_line(carratereVechio||' VECCHIO | ATTUALE '||carratereAttuale);
        testoGenerico := SUBSTR(carratereAttuale,-1,1);
        IF testoGenerico = carattereSeparatore THEN
            DBMS_OUTPUT.put_line('Apre chiave');
            nnumero := LENGTH(carratereVechio)-LENGTH(carratereAttuale);
            DBMS_OUTPUT.put_line(carratereVechio||'-'||carratereAttuale ||' => rastreo di text_Json = ' ||LENGTH(carratereVechio)||'-'||LENGTH(carratereAttuale)||' ='|| nnumero);
            text_Json := SUBSTR(carratereAttuale, LENGTH(carratereVechio)-LENGTH(carratereAttuale));
            DBMS_OUTPUT.put_line('text_Json_ '||text_Json);
        ELSE
            DBMS_OUTPUT.put_line('Dato' ||':'||'valore');
        END IF;
    EXIT WHEN testoGenerico != carattereSeparatore;
    END LOOP;
end;




select distinct(REGEXP_SUBSTR(ng_model,'formData.cirs.([^.])+.')) from TMP_MODELO_FM2_FM3;
