

create or replace function PRODUCE_JSON_FM3_DA_MODELLO(codice_scheda varchar2)
  return CLOB
  AS
      -- PRODUCE_JSON_FM3_DA_MODELLO:
      -- 1 - SITUAZIONE:
      -- configurazione per una risposta (n):
      -- ng-model	: scheda.sezioneUno.domandaUno
      -- ng-value	: 2.0
      -- codice_elemento : cod_01
      --
      -- 2.- APPROCCIO:
      -- scheda.sezioneUno
      -- scheda.sezioneUno.domandaUno
      -- scheda.sezioneUno.domandaUno : (radio)(rispostaUno).ng-value | valore
      -- scheda.sezioneUno.domandaUno : (radio)(rispostaDue).ng-value | valore
      -- scheda.sezioneUno.domandaDue
      -- scheda.sezioneUno.domandaDue.rispostaUno : (checkBox)(rispostaUno).ng-value | valore
      -- scheda.sezioneUno.domandaDue.rispostaDue : (checkBox)(rispostaUno).ng-value | valore
      -- scheda.sezioneUno.domandaDue.rispostaTre : (select)(option0)(rispostaUno).ng-value
      -- scheda.sezioneUno.domandaDue.rispostaTre : (select)(option1)(rispostaUno).ng-value
      -- scheda.sezioneUno.domandaDue.rispostaTre : (select)(option2)(rispostaUno).ng-value
      -- scheda.sezioneDue
      -- scheda.sezioneDue.domandaUno : (input)(rispostaUno).ng-value
      -- scheda.sezioneDue.domandaDue : (textArea)(rispostaUno).ng-value
      --
      --
      -- scheda : {
      --   sezioneUno : {
      --     domandaUno : (radio)(rispostaUno).ng-value,
      --     domandaDue : {
      --         rispostaUno : (checkBox)(rispostaUno).ng-value,
      --         rispostaDue : (checkBox)(rispostaUno).ng-value,
      --         rispostaTre : (select)(rispostaUno).ng-value
      --       }
      --   },
      --   sezioneDue : {
      --     domandaUno : (input)(rispostaUno).ng-value
      --     domandaDue : (textArea)(rispostaUno).ng-value
      --   }
      -- }
    DBMS_OUTPUT.put_line('----**PRODUCENDO JSON DA MODELLO**----@gneraJSON');

    DBMS_OUTPUT.put_line('----**JSON FINITO !!!**----');
  BEGIN
END;


/* END TESTO => TYPE TYPE_GENERARE_JSON */
