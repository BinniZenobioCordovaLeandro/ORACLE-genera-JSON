create or replace function FN_GENERA_JSON_DA_CACHE
  return CLOB
AS
  type corridoioList is table of varchar2(200);
  corridoio corridoioList; -- corridoio deve essere una lista per supportare a tanti possibilita di varianti [formData.cirs.a,formData.cirs.b];
  corridoio2 corridoioList;
  corridoio3 corridoioList;
  corridoio4 corridoioList;

  JSON CLOB;

  cache_substr varchar(2); -- serve per il controllo dell'esistenza;
  cache_json varchar(200); -- serve per caricare contenuto al JSON CLOB.
  cache_path varchar(200); -- serve per fare la richiesta alla tabella.
  cache_val varchar2(200);

  carattereSeparatore varchar2(1);
BEGIN
  DBMS_OUTPUT.put_line('La funzione supporta una profondità di [4] nel percorso delle variabile : a1.b2.c3.d4 = 1.1.1.1 = [1].[2].[3].[4]');
  JSON := ''; -- a Baby json...

  -- configurazione
  carattereSeparatore := '.';

    select distinct(REGEXP_SUBSTR(variabile,'([^'||carattereSeparatore||'])+'||carattereSeparatore))
    bulk collect into corridoio
    from CACHE_ISTANZA_SCHEDA where variabile is not null;

    FOR indx in 1 .. corridoio.COUNT
    LOOP
      DBMS_OUTPUT.put_line(indx||'- corridoio ['||corridoio(indx) || '] :');

      cache_substr := substr(corridoio(indx),-1,1);
      IF cache_substr !=  carattereSeparatore THEN
        cache_path := corridoio(indx);
        DBMS_OUTPUT.put_line(' => query -> select valore from CACHE_ISTANZA_SCHEDA where variabile = '||cache_path);
        select valore into cache_val from CACHE_ISTANZA_SCHEDA where variabile = cache_path;
        cache_json:= '"'||corridoio(indx)||'":'||cache_val;
        DBMS_OUTPUT.put_line(' => JSON ADD : '||cache_json);
        JSON := JSON || cache_json;
      ELSIF cache_substr IS NOT NULL THEN
        DBMS_OUTPUT.put_line(' => query -> Guardando sotto ['||corridoio(indx)||'>]');
        cache_json := '"'||REPLACE(corridoio(indx),carattereSeparatore,'":{');
        DBMS_OUTPUT.put_line(' => JSON ADD : '||cache_json);
        JSON := JSON || cache_json;

        select distinct(REGEXP_SUBSTR(variabile,corridoio(indx)||'([^'||carattereSeparatore||'])+'||carattereSeparatore))
        bulk collect into corridoio2
        from CACHE_ISTANZA_SCHEDA where variabile is not null;

          FOR indx2 in 1 .. corridoio2.COUNT
          LOOP
            DBMS_OUTPUT.put_line('   '||indx||'.'||indx2||'- corridoio2 ['||corridoio2(indx2) || '] :');

            cache_substr := substr(corridoio2(indx2),-1,1);
            IF cache_substr !=  carattereSeparatore THEN
              cache_path := corridoio2(indx2);
              DBMS_OUTPUT.put_line('    => query -> select valore from CACHE_ISTANZA_SCHEDA where variabile = '||cache_path);
              select valore into cache_val from CACHE_ISTANZA_SCHEDA where variabile = cache_path;
              cache_json:= '"'||substr(corridoio2(indx2), LENGTH(corridoio(indx))-LENGTH(corridoio2(indx2)))||'":'||cache_val;
              DBMS_OUTPUT.put_line('    => JSON ADD : '||cache_json);
              JSON := JSON || cache_json;
            ELSIF cache_substr IS NOT NULL THEN
              DBMS_OUTPUT.put_line('    => query -> Guardando sotto ['||corridoio2(indx2)||'>]');
              cache_json := '"'||REPLACE(substr(corridoio2(indx2), LENGTH(corridoio(indx))-LENGTH(corridoio2(indx2))),carattereSeparatore,'":{');
              DBMS_OUTPUT.put_line('    => JSON ADD : '||cache_json);
              JSON := JSON || cache_json;

              select distinct(REGEXP_SUBSTR(variabile,corridoio2(indx2)||'([^'||carattereSeparatore||'])+'||carattereSeparatore))
              bulk collect into corridoio3
              from CACHE_ISTANZA_SCHEDA where variabile is not null;

              FOR indx3 in 1 .. corridoio3.COUNT
              LOOP
                DBMS_OUTPUT.put_line('      '||indx||'.'||indx2||'.'||indx3||'- corridoio3 ['||corridoio3(indx3) || '] :');

                cache_substr := substr(corridoio3(indx3),-1,1);
                IF cache_substr != carattereSeparatore THEN
                  cache_path := corridoio3(indx3);
                  DBMS_OUTPUT.put_line('       => query -> select valore from CACHE_ISTANZA_SCHEDA where variabile = '||cache_path);
                  select valore into cache_val from CACHE_ISTANZA_SCHEDA where variabile = cache_path;
                  cache_json:= '"'||substr(corridoio3(indx3), LENGTH(corridoio2(indx2))-LENGTH(corridoio3(indx3)))||'":'||cache_val;
                  DBMS_OUTPUT.put_line('       => JSON ADD : '||cache_json);
                  JSON := JSON || cache_json;
                ELSIF cache_substr IS NOT NULL THEN
                  DBMS_OUTPUT.put_line('       => query -> Guardando sotto ['||corridoio3(indx3)||'>]');
                  cache_json := '"'||REPLACE(substr(corridoio3(indx3), LENGTH(corridoio2(indx2))-LENGTH(corridoio3(indx3))),carattereSeparatore,'":{');
                  DBMS_OUTPUT.put_line('       => JSON ADD : '||cache_json);
                  JSON := JSON || cache_json;

                  select distinct(REGEXP_SUBSTR(variabile,corridoio3(indx3)||'([^'||carattereSeparatore||'])+'||carattereSeparatore))
                  bulk collect into corridoio4
                  from CACHE_ISTANZA_SCHEDA where variabile is not null;

                  FOR indx4 in 1 .. corridoio4.COUNT
                  LOOP
                    DBMS_OUTPUT.put_line('         '||indx||'.'||indx2||'.'||indx3||'.'||indx4||'- corridoio4 ['||corridoio4(indx4) || '] :');

                    cache_substr := substr(corridoio4(indx4),-1,1);
                    IF cache_substr !=  carattereSeparatore THEN
                      cache_path := corridoio4(indx4);
                      DBMS_OUTPUT.put_line('          => query -> select valore from CACHE_ISTANZA_SCHEDA where variabile = '||cache_path);
                      select valore into cache_val from CACHE_ISTANZA_SCHEDA where variabile = cache_path;
                      cache_json:= '"'||substr(corridoio4(indx4), LENGTH(corridoio3(indx3))-LENGTH(corridoio4(indx4))) || '":'||cache_val;
                      DBMS_OUTPUT.put_line('          => JSON ADD : '||cache_json);
                      JSON := JSON || cache_json;
                    ELSIF cache_substr IS NOT NULL THEN
                      DBMS_OUTPUT.put_line('          => query -> Guardando sotto ['||corridoio4(indx4)||'>]');
                    END IF;

                    --DBMS_OUTPUT.put_line(indx4||' di '||corridoio4.COUNT);
                    IF indx4 != corridoio4.COUNT THEN
                      IF corridoio4(indx4) is not null THEN
                        -- JSON := JSON || ', da ['||cache_json||']';
                        JSON := JSON || ',';
                        DBMS_OUTPUT.put_line('          => JSON ADD : '||',');
                      ELSE
                        --JSON := JSON || '[ERROR := Posibile Null Preso nella query.]';
                        DBMS_OUTPUT.put_line('          => [ERROR! := Posibile Null preso nella query. (error sotto controllo, stai calmo)]');
                      END IF;
                    ELSE
                      JSON := JSON || '}';
                    END IF;
                  END LOOP;
                END IF;
                IF indx3 != corridoio3.COUNT THEN
                  IF corridoio3(indx3) is not null THEN
                    -- JSON := JSON || ', da ['||cache_json||']';
                    JSON := JSON || ',';
                    DBMS_OUTPUT.put_line('       => JSON ADD : '||',');
                  ELSE
                    --JSON := JSON || '[ERROR := Posibile Null Preso nella query.]';
                    DBMS_OUTPUT.put_line('       => [ERROR! := Posibile Null preso nella query. (error sotto controllo, stai calmo)]');
                  END IF;
                ELSE
                  JSON := JSON || '}';
                END IF;
              END LOOP;
            END IF;
            IF indx2 != corridoio2.COUNT THEN
              IF corridoio2(indx2) is not null THEN
                -- JSON := JSON || ', da ['||cache_json||']';
                JSON := JSON || ',';
              ELSE
                --JSON := JSON || '[ERROR := Posibile Null Preso nella query.]';
                DBMS_OUTPUT.put_line('    => [ERROR! := Posibile Null preso nella query. (error sotto controllo, stai calmo)]');
              END IF;
            ELSE
              JSON := JSON || '}';
            END IF;
          END LOOP;
      END IF;
      IF indx != corridoio.COUNT THEN
        IF corridoio(indx) is not null THEN
          -- JSON := JSON || ', da ['||cache_json||']';
          JSON := JSON || ',';
        ELSE
          --JSON := JSON || '[ERROR := Posibile Null Preso nella query.]';
          DBMS_OUTPUT.put_line(' => [ERROR! := Posibile Null preso nella query. (error sotto controllo, stai calmo)]');
        END IF;
      END IF;
    END LOOP;


    DBMS_OUTPUT.put_line('Istanza : {'||JSON||'}'); -- a json magiore.
    JSON := '{'||JSON||'}';
    RETURN JSON;
END;
