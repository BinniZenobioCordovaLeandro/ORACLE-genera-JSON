CREATE OR REPLACE PROCEDURE DYNAMICFORMS_SVI.P_TRACK_VERBAL_NUMBER (V_ORDER_NUMBER_LIST VARCHAR2, V_SITE_ID IN VARCHAR2, V_VERBAL_NUMBER IN NUMBER) AS PRAGMA AUTONOMOUS_TRANSACTION;
 TMP_ID NUMBER;
   BEGIN

     dbms_output.put_line('Updating verbale number');
      INSERT INTO WK_VERBAL_NUMBER_TRACKINGS (ORDER_NUMBER_LIST, SITE_ID, VERBAL_NUMBER) VALUES (V_ORDER_NUMBER_LIST, V_SITE_ID, V_VERBAL_NUMBER);
     COMMIT;
	 dbms_output.put_line('Inserted numeroVerbale: '|| V_VERBAL_NUMBER ||' already exists for ORDER_NUMBER_LIST/SITE_ID pair:'|| V_ORDER_NUMBER_LIST || '-'||V_SITE_ID);
END P_TRACK_VERBAL_NUMBER;