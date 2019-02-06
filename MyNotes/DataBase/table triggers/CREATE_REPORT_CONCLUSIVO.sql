TRIGGER CREATE_REPORT_CONCLUSIVO AFTER UPDATE ON ACTIVITIES
FOR EACH ROW
DECLARE
  rec ACTIVITIES.SUBJECT_ID%TYPE;
  numberAssessment NUMBER := -1;
BEGIN

  -- verifico se la scheda per la quale e' scattato il TRIGGER e' di tipo DONNA/UOMO TIPO 'X' FASE 3
  SELECT COUNT(DISTINCT (a.ID))
  INTO   numberAssessment
  FROM   ACTIVITYTYPES a, TMPLCOMPONENTS c
  WHERE  a.ID = :NEW.REF_ACTYPE
  AND    c.ID = a.ID
  AND    c.DELETED = '0'
  AND    a.NAME LIKE '%FASE 3';

  IF (numberAssessment <> '1')
        THEN RETURN; -- non e' una scheda di tipo 3
  END IF;

  -- controllo che la scheda sia confermata. Condizione old.state = 0 perchè evito di far scattare il trigger per ogni update ad activities per schede di tipo 3
  IF (:NEW.STATE = '1' and :OLD.STATE = '0') THEN
       DBMS_OUTPUT.put_line('Chiamata alla Store Procedure');
       SP_CREATE_REPORT_CONCLUSIVO (:NEW.SUBJECT_ID, :NEW.ID, :NEW.REF_ACTYPE);
	     DBMS_OUTPUT.put_line('Report Conclusivo Generato '||:NEW.id);
  END IF;


END;
