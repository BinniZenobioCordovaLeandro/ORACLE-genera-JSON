CREATE OR REPLACE FUNCTION DYNAMICFORMS_SVI.FN_GET_MEW_SCORE_CONFIG(v_category IN VARCHAR2, v_code IN VARCHAR2)
   RETURN VARCHAR2
   IS v_score VARCHAR2(255);
   BEGIN
      SELECT ''||v.SCORE
      INTO v_score
      FROM MEW_SCORE_CONFIG v
      WHERE V.CODE=v_code
	  AND v.TYPE='V'
	  AND v.REF_PARENT=(SELECT c.ID FROM MEW_SCORE_CONFIG c WHERE c.CODE=v_category AND c.TYPE='C');
      RETURN(v_score);
    END;
