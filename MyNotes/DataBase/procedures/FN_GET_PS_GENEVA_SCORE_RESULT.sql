CREATE OR REPLACE FUNCTION DYNAMICFORMS_SVI.FN_GET_PS_GENEVA_SCORE_RESULT(v_score IN VARCHAR2)
	RETURN VARCHAR2
	IS risposta VARCHAR2(255);

	BEGIN

		SELECT  v.DESCRIPTION ||';'||v.COLOR
		INTO risposta
		FROM PS_GENEVA_SCORE_CONFIG v
		WHERE v.REF_PARENT=(SELECT P.ID FROM PS_GENEVA_SCORE_CONFIG P WHERE P.CODE='PS_GENEVA_DEC_PROB_CLINICA' AND P.TYPE='C')
		AND v_score >= v.SCORE_MIN -- controllo sempre min
		AND ( (v_score <= v.score_max and v.SCORE_MAX is not null ) -- controllo max
		OR (v.SCORE_MAX is null) );
		RETURN (risposta);

END;
