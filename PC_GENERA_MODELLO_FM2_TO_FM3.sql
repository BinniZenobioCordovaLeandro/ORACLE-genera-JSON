ANCORA NON FINITO!

select * from (
  select
          null as ng_model,
          null as ng_value,
          s.name as testo_section,
          null as testo_domanda,
          null as testo_risposta,
          met.value as value_score,
          'sezione' as TYPE,
          s.id as codice_elemento,
          c.code as ref_code_scheda
        from TMPLSECTIONS s
        left join metadata met on met.REF_TMPLCOMPONENT = s.ID
        join TMPLCOMPONENTS c on s.REF_ACTYPE = c.id
        where
            met.id not in (select
              am.id
              from ACTIVITY_METADATA am
              join ACTIVITIES at on at.ID = am.REF_ACTIVITY
              where
              at.REF_ACTYPE in (select ID from TMPLCOMPONENTS where CODE = 'schedaComorbilitaCIRS'))
            and c.CODE = 'schedaComorbilitaCIRS'
)
UNION ALL
select * from (
  select
        null as ng_model,
        null as ng_value,
        s.name as testo_section,
        i.value as testo_domanda,
        a.value as testo_risposta,
        met.value as value_score,
        a.TYPE_OF_ANSWER as TYPE,
        a.id as codice_elemento,
        c.code as ref_code_scheda
      from TMPLANSWERS a
        join metadata met on met.REF_TMPLCOMPONENT = a.ID
        join TMPLITEMS i on a.REF_TMPLITEM = i.id
        join TMPLSECTIONS s on i.REF_TMPLSECTION = s.id
        join TMPLCOMPONENTS c on s.REF_ACTYPE = c.id
      where
          met.id not in(
            select
            am.id
            from ACTIVITY_METADATA am
            join ACTIVITIES at on at.ID = am.REF_ACTIVITY
            where
            at.REF_ACTYPE in (select ID from TMPLCOMPONENTS where CODE = 'schedaComorbilitaCIRS')
          )
          and c.CODE = 'schedaComorbilitaCIRS'
)





create or replace function PRODUCE_MODELLO_FM2_TO_FM3(codice_scheda varchar2)
  return varchar2
  AS
    risposta varchar2(200);
  BEGIN
  -- PRODUCE_MODELLO_FM2_TO_FM3:
  -- 1.- Struttura l'informazione di una scheda per piantare un modello.
  DBMS_OUTPUT.put_line('----**PRODUCENDO MODELLO**----');
  insert into TMP_MODELO_FM2_FM3 (ng_model,ng_value,testo_section,testo_domanda,testo_risposta,value_score,tipo_riposta_N,codice_elemento,ref_code_scheda)
  select * FROM(
      select * from (
        select
                null as ng_model,
                null as ng_value,
                s.name as testo_section,
                null as testo_domanda,
                null as testo_risposta,
                met.value as value_score,
                'sezione' as TYPE,
                s.id as codice_elemento,
                c.code as ref_code_scheda
              from TMPLSECTIONS s
              left join metadata met on met.REF_TMPLCOMPONENT = s.ID
              join TMPLCOMPONENTS c on s.REF_ACTYPE = c.id
              where
                  met.id not in (select
                    am.id
                    from ACTIVITY_METADATA am
                    join ACTIVITIES at on at.ID = am.REF_ACTIVITY
                    where
                    at.REF_ACTYPE in (select ID from TMPLCOMPONENTS where CODE = codice_scheda))
                  and c.CODE = codice_scheda
      )
      UNION ALL
      select * from (
        select
              null as ng_model,
              null as ng_value,
              s.name as testo_section,
              i.value as testo_domanda,
              a.value as testo_risposta,
              met.value as value_score,
              a.TYPE_OF_ANSWER as TYPE,
              a.id as codice_elemento,
              c.code as ref_code_scheda
            from TMPLANSWERS a
              join metadata met on met.REF_TMPLCOMPONENT = a.ID
              join TMPLITEMS i on a.REF_TMPLITEM = i.id
              join TMPLSECTIONS s on i.REF_TMPLSECTION = s.id
              join TMPLCOMPONENTS c on s.REF_ACTYPE = c.id
            where
                met.id not in(
                  select
                  am.id
                  from ACTIVITY_METADATA am
                  join ACTIVITIES at on at.ID = am.REF_ACTIVITY
                  where
                  at.REF_ACTYPE in (select ID from TMPLCOMPONENTS where CODE = codice_scheda)
                )
                and c.CODE = codice_scheda
      )
  );
  DBMS_OUTPUT.put_line('----**CONFIGURA IL MODELLO, PER FAVORE ;)**----');
  risposta := 'Compilato !!!, Query per editare la Procedura - select * from TMP_MODELO_FM2_FM3 where ref_code_scheda = '''||codice_scheda||'''';
  return risposta;
END;
