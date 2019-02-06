CREATE OR REPLACE FUNCTION DYNAMICFORMS_SVI.FN_GET_PS_SCHEDA_SCA_DOL_BAMB(v_category IN VARCHAR2, v_code IN VARCHAR2)
   RETURN VARCHAR2
   IS v_score VARCHAR2(255);
   BEGIN
      SELECT ''||v.SCORE
      INTO v_score
      FROM PS_SCHEDA_SCALA_DOLORE_BAMBINO v
      WHERE V.CODE=v_code
	  AND v.TYPE='V'
	  AND v.REF_PARENT=(SELECT c.ID FROM PS_SCHEDA_SCALA_DOLORE_BAMBINO c WHERE c.CODE=v_category AND c.TYPE='C');
      RETURN(v_score);
END;