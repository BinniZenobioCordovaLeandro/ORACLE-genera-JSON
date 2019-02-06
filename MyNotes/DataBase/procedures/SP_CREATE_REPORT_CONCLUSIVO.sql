CREATE OR REPLACE PROCEDURE DYNAMICFORMS_SVI.SP_CREATE_REPORT_CONCLUSIVO (SUBJECT VARCHAR2, ID_ACTIVITY NUMBER, ID_ASSESSMENT VARCHAR2) IS

noteDonna1 VARCHAR(4000) := ' ';
noteDonna2 VARCHAR(4000) := ' ';
noteDonna3 VARCHAR(4000) := ' ';
noteFinal VARCHAR(12000) := ' ';
numberAssessment  VARCHAR(4000) := '0';
dt_report  VARCHAR(4000) := ' ';
cod_assessment_1 VARCHAR(4000) := ' ';
cod_assessment_2 VARCHAR(4000) := ' ';
cod_assessment_3 VARCHAR(4000) := ' ';
cod_final_assessment VARCHAR(4000) := ' ';
cod_tmplitem_final_assessment VARCHAR(4000) := ' ';
cod_tmplansw_final_assessment VARCHAR(4000) := ' ';
idSource NUMBER := -1;

PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN

     DBMS_OUTPUT.put_line('PARAM SP_CREATE_REPORT_CONCLUSIVO :(SUBJECT='||SUBJECT||',ID_ACTIVITY='||ID_ACTIVITY||',ID_ASSESSMENT='||ID_ASSESSMENT||')');

    /* In base alla scheda in ingresso (una scheda FASE 3), prendo il VALUE, per vedere a che Report Conclusivo si riferisce. Viene usato successivamente */
    BEGIN
      SELECT DISTINCT(value)
      INTO   dt_report
      FROM   METADATA
      WHERE  REF_TMPLCOMPONENT = ID_ASSESSMENT --'1011254'
      AND    KEY = 'activityType.parentId';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            return;
    END;


    /* In base al dt_report, prelevo dinamicamente i codici delle schede 1,2. La 3 e' in ingresso */
    /* Prelevo l'istanza della scheda 1 */
    BEGIN
        SELECT DISTINCT(M1.REF_TMPLCOMPONENT)
        INTO   cod_assessment_1
        FROM   METADATA M1, METADATA M2
        WHERE  M1.VALUE = '1'
        AND    M1.KEY = 'activityType.parentId.fase'
        AND    M2.VALUE = dt_report
        AND    M2.KEY = 'activityType.parentId'
        AND    M1.REF_TMPLCOMPONENT = M2.REF_TMPLCOMPONENT
        AND    M1.DELETED = '0'
        AND    M1.DELETED = M2.DELETED;
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN -- prendo il max
                  SELECT MAX(M1.REF_TMPLCOMPONENT)
                  INTO   cod_assessment_1
                  FROM   METADATA M1, METADATA M2
                  WHERE  M1.VALUE = '1'
                  AND    M1.KEY = 'activityType.parentId.fase'
                  AND    M2.VALUE = dt_report
                  AND    M2.KEY = 'activityType.parentId'
                  AND    M1.REF_TMPLCOMPONENT = M2.REF_TMPLCOMPONENT
                  AND    M1.DELETED = '0'
                  AND    M1.DELETED = M2.DELETED;
        WHEN NO_DATA_FOUND THEN
            return;
    END;


    /* Prelevo l'istanza della scheda 2 */
    BEGIN
        SELECT DISTINCT(M1.REF_TMPLCOMPONENT)
        INTO   cod_assessment_2
        FROM   METADATA M1, METADATA M2
        WHERE  M1.VALUE = '2'
        AND    M1.KEY = 'activityType.parentId.fase'
        AND    M2.VALUE = dt_report
        AND    M2.KEY = 'activityType.parentId'
        AND    M1.REF_TMPLCOMPONENT = M2.REF_TMPLCOMPONENT
        AND    M1.DELETED = '0'
        AND    M1.DELETED = M2.DELETED;
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN -- prendo il max
                  SELECT MAX(M1.REF_TMPLCOMPONENT)
                  INTO   cod_assessment_2
                  FROM   METADATA M1, METADATA M2
                  WHERE  M1.VALUE = '2'
                  AND    M1.KEY = 'activityType.parentId.fase'
                  AND    M2.VALUE = dt_report
                  AND    M2.KEY = 'activityType.parentId'
                  AND    M1.REF_TMPLCOMPONENT = M2.REF_TMPLCOMPONENT
                  AND    M1.DELETED = '0'
                  AND    M1.DELETED = M2.DELETED;
        WHEN NO_DATA_FOUND THEN
            return;
    END;


  /* Controllo che esista almeno una versione delle schede DONNA1, DONNA2 e DONNA3 in stato published
     Se count = 3, procedo, altrimenti esco */
     SELECT to_char(COUNT(*))
     INTO  numberAssessment
     FROM (
            SELECT max(ID) ID FROM ACTIVITIES WHERE  REF_ACTYPE = cod_assessment_1 AND SUBJECT_ID = SUBJECT AND STATE = '1'
            UNION
            SELECT max(ID) ID FROM ACTIVITIES WHERE  REF_ACTYPE = cod_assessment_2 AND SUBJECT_ID = SUBJECT AND STATE = '1'
            --UNION
            --SELECT ID ID FROM ACTIVITIES WHERE  REF_ACTYPE='1011254' AND SUBJECT_ID = SUBJECT AND STATE = '1'
             -- prendo quella in ingresso, senza stato perchè ancora non 1. Sono sicuro che sarà 1, perhcè nell'if del trigger
            --SELECT ID FROM ACTIVITIES WHERE  SUBJECT_ID = SUBJECT  AND ID = ID_ACTIVITY
            ) A
    WHERE A.ID IS NOT NULL;

    DBMS_OUTPUT.put_line('numberAssessment '||numberAssessment);

    IF (numberAssessment <> '2')
        THEN RETURN; -- non esistono almeno 3 istanze delle schede salvate
    END IF;

    -- Cursore sulla scheda DONNA_1, per prendere le note
    FOR CURS_ANSWERS_DONNA_1 IN (
        SELECT ANSWER
        FROM ANSWERS
        WHERE REF_ACTIVITY IN (SELECT max(ID) FROM ACTIVITIES
                               WHERE  REF_ACTYPE = cod_assessment_1 AND SUBJECT_ID = SUBJECT AND STATE = '1'
                               )
        AND REF_TMPLANSWER IN (SELECT a.ID FROM TMPLANSWERS a, TMPLCOMPONENTS c
                               WHERE a.REF_TMPLITEM IN (
                                                        SELECT ID FROM TMPLITEMS
                                                        WHERE REF_TMPLSECTION IN (
                                                                                  SELECT ID FROM TMPLSECTIONS
                                                                                  WHERE REF_ACTYPE = cod_assessment_1
                                                                                  )
                                                        )
                               AND a.TYPE_OF_ANSWER = 'INPUTT'
                               AND a.id = c.REF_GENERIC_COMP AND c.CODE like '%NOTA%'
                               )
         )
    LOOP

      SELECT CONCAT(noteDonna1,CURS_ANSWERS_DONNA_1.ANSWER || ' ')
      INTO noteDonna1
      FROM dual;

    END LOOP;

  DBMS_OUTPUT.put_line('SP_CREATE_REPORT_CONCLUSIVO noteDonna1 = ' || noteDonna1);

  -- Cursore sulla scheda DONNA_2, per prendere le note
    FOR CURS_ANSWERS_DONNA_2 IN (
        SELECT ANSWER
        FROM ANSWERS
        WHERE REF_ACTIVITY IN (SELECT max(ID) FROM ACTIVITIES
                               WHERE  REF_ACTYPE = cod_assessment_2 AND SUBJECT_ID = SUBJECT AND STATE = '1'
                               )
        AND REF_TMPLANSWER IN (SELECT a.ID FROM TMPLANSWERS a, TMPLCOMPONENTS c
                               WHERE a.REF_TMPLITEM IN (
                                                        SELECT ID FROM TMPLITEMS
                                                        WHERE REF_TMPLSECTION IN (
                                                                                  SELECT ID FROM TMPLSECTIONS
                                                                                  WHERE REF_ACTYPE = cod_assessment_2
                                                                                  )
                                                        )
                               AND a.TYPE_OF_ANSWER = 'INPUTT'
                               AND a.id = c.REF_GENERIC_COMP AND c.CODE  like '%NOTA%'
                               )
         )
    LOOP

      SELECT CONCAT(noteDonna2,CURS_ANSWERS_DONNA_2.answer || ' ')
      INTO noteDonna2
      FROM dual;

    END LOOP;

  DBMS_OUTPUT.put_line('SP_CREATE_REPORT_CONCLUSIVO noteDonna2 = ' || noteDonna2);

    -- Cursore sulla scheda DONNA_3, per prendere le note
    FOR CURS_ANSWERS_DONNA_3 IN (
        SELECT ANSWER
        FROM ANSWERS
        WHERE REF_ACTIVITY = ID_ACTIVITY
                            --IN (SELECT max(ID) FROM ACTIVITIES
                            --   WHERE  REF_ACTYPE='1011254' AND SUBJECT_ID = SUBJECT AND STATE = '1'
                            --   )
        AND REF_TMPLANSWER IN (SELECT a.ID FROM TMPLANSWERS a, TMPLCOMPONENTS c
                               WHERE a.REF_TMPLITEM IN (
                                                        SELECT ID FROM TMPLITEMS
                                                        WHERE REF_TMPLSECTION IN (
                                                                                  SELECT ID FROM TMPLSECTIONS
                                                                                  WHERE REF_ACTYPE = ID_ASSESSMENT
                                                                                  )
                                                        )
                               AND a.TYPE_OF_ANSWER = 'INPUTT'
                               AND a.id = c.REF_GENERIC_COMP AND c.CODE like '%NOTA%'
                               )
         )
    LOOP

      SELECT CONCAT(noteDonna3,CURS_ANSWERS_DONNA_3.answer || ' ')
      INTO noteDonna3
      FROM dual;

    END LOOP;

  DBMS_OUTPUT.put_line('SP_CREATE_REPORT_CONCLUSIVO noteDonna3 = ' || noteDonna3);

  SELECT rtrim(ltrim(CONCAT(noteFinal, rtrim(ltrim(noteDonna1)) || chr(13) || rtrim(ltrim(noteDonna2)) || chr(13) || rtrim(ltrim(noteDonna3)) )))
  INTO noteFinal
  FROM dual;

  DBMS_OUTPUT.put_line('SP_CREATE_REPORT_CONCLUSIVO noteFinal = ' || noteFinal);

  /* Prelevo l'id della scheda del report conclusivo */
  BEGIN
    SELECT DISTINCT(M1.REF_TMPLCOMPONENT)
    INTO   cod_final_assessment
    FROM   METADATA M1, METADATA M2
    WHERE  M1.VALUE = 'C'
    AND    M1.KEY = 'activityType.parentId.fase'
    AND    M2.VALUE = dt_report
    AND    M2.KEY = 'activityType.parentId'
    AND    M1.REF_TMPLCOMPONENT = M2.REF_TMPLCOMPONENT
    AND    M1.DELETED = '0'
    AND    M1.DELETED = M2.DELETED;

  EXCEPTION
        WHEN TOO_MANY_ROWS THEN -- prendo il max
                    SELECT MAX(M1.REF_TMPLCOMPONENT)
                    INTO   cod_final_assessment
                    FROM   METADATA M1, METADATA M2
                    WHERE  M1.VALUE = 'C'
                    AND    M1.KEY = 'activityType.parentId.fase'
                    AND    M2.VALUE = dt_report
                    AND    M2.KEY = 'activityType.parentId'
                    AND    M1.REF_TMPLCOMPONENT = M2.REF_TMPLCOMPONENT
                    AND    M1.DELETED = '0'
                    AND    M1.DELETED = M2.DELETED;
        WHEN NO_DATA_FOUND THEN
            return;
    END;


  /* Prelevo l'id della domanda del report conclusivo */
  BEGIN
    SELECT DISTINCT(M1.REF_TMPLCOMPONENT)
    INTO   cod_tmplitem_final_assessment
    FROM   METADATA M1, METADATA M2
    WHERE  M1.VALUE = 'ITEM'
    AND    M1.KEY = 'activityType.parentId.fase'
    AND    M2.VALUE = dt_report
    AND    M2.KEY = 'activityType.parentId'
    AND    M1.REF_TMPLCOMPONENT = M2.REF_TMPLCOMPONENT
    AND    M1.DELETED = '0'
    AND    M1.DELETED = M2.DELETED;

  EXCEPTION
        WHEN TOO_MANY_ROWS THEN -- prendo il max
                    SELECT MAX(M1.REF_TMPLCOMPONENT)
                    INTO   cod_tmplitem_final_assessment
                    FROM   METADATA M1, METADATA M2
                    WHERE  M1.VALUE = 'ITEM'
                    AND    M1.KEY = 'activityType.parentId.fase'
                    AND    M2.VALUE = dt_report
                    AND    M2.KEY = 'activityType.parentId'
                    AND    M1.REF_TMPLCOMPONENT = M2.REF_TMPLCOMPONENT
                    AND    M1.DELETED = '0'
                    AND    M1.DELETED = M2.DELETED;
        WHEN NO_DATA_FOUND THEN
            return;
    END;

  /* Prelevo l'id della risposta del report conclusivo */
  BEGIN
    SELECT DISTINCT(M1.REF_TMPLCOMPONENT)
    INTO   cod_tmplansw_final_assessment
    FROM   METADATA M1, METADATA M2
    WHERE  M1.VALUE = 'ANSWER'
    AND    M1.KEY = 'activityType.parentId.fase'
    AND    M2.VALUE = dt_report
    AND    M2.KEY = 'activityType.parentId'
    AND    M1.REF_TMPLCOMPONENT = M2.REF_TMPLCOMPONENT
    AND    M1.DELETED = '0'
    AND    M1.DELETED = M2.DELETED;

  EXCEPTION
        WHEN TOO_MANY_ROWS THEN -- prendo il max
                    SELECT MAX(M1.REF_TMPLCOMPONENT)
                    INTO   cod_tmplansw_final_assessment
                    FROM   METADATA M1, METADATA M2
                    WHERE  M1.VALUE = 'ANSWER'
                    AND    M1.KEY = 'activityType.parentId.fase'
                    AND    M2.VALUE = dt_report
                    AND    M2.KEY = 'activityType.parentId'
                    AND    M1.REF_TMPLCOMPONENT = M2.REF_TMPLCOMPONENT
                    AND    M1.DELETED = '0'
                    AND    M1.DELETED = M2.DELETED;
        WHEN NO_DATA_FOUND THEN
            return;
    END;

  /* Prelievo l'id del Source. Se non esiste con MDB, ne prendo uno di default */
    BEGIN
        SELECT DISTINCT(S.ID)
        INTO   idSource
        FROM   SOURCES S
        WHERE  S.CODE='MDB'
        AND    S.DELETED = '0';
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN -- prendo il max per MDB
                  SELECT MAX(S.ID)
                  INTO   idSource
                  FROM   SOURCES S
                  WHERE  S.CODE='MDB'
                  AND    S.DELETED = '0';
        WHEN NO_DATA_FOUND THEN -- prendo il max in assoluto. Se non esiste, faccio return
                   BEGIN
                      SELECT MAX(S.ID)
                      INTO   idSource
                      FROM   SOURCES S
                      WHERE  S.DELETED = '0';
                   EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                          return;
                   END;
    END;

  -- insert activities conclusivo e answers

  INSERT INTO ACTIVITIES (ID, SUBJECT_ID, ENTRY_DATETIME, STATE, REF_ACTYPE, REF_SOURCE, XMLDATA, ROW_VERSION, INSERT_USER,VERSION)
  VALUES (SEQ_ACTIVITIES.nextval, SUBJECT, to_date(sysdate,'DD-MON-RR') , '0', cod_final_assessment, idSource, null, '1', 'ZaG@Repository', '1');

  DBMS_OUTPUT.put_line('SP_CREATE_REPORT_CONCLUSIVO Activity creata  = ' || SEQ_ACTIVITIES.currval);

  -- inserisco le ANSWERS
  INSERT INTO ANSWERS (ID, REF_TMPLITEM, ANSWER, REF_ACTIVITY, REF_TMPLANSWER,ROW_VERSION, DELETED )
  VALUES (SEQ_ANSWERS.nextval, cod_tmplitem_final_assessment, noteFinal, SEQ_ACTIVITIES.currval , cod_tmplansw_final_assessment, '0', '0');

  DBMS_OUTPUT.put_line('SP_CREATE_REPORT_CONCLUSIVO Answer creata  = ' || SEQ_ANSWERS.currval);

  COMMIT;

END SP_CREATE_REPORT_CONCLUSIVO;
