create or replace function DYNAMICFORMS_SVI.generaJSON(input varchar2)
  return varchar
PARALLEL_ENABLE AGGREGATE USING TYPE_GENERARE_JSON;

/* START TESTO => TYPE TYPE_GENERARE_JSON */
CREATE TYPE "TYPE_GENERARE_JSON" AS OBJECT
(
	total CLOB,
	STATIC FUNCTION	ODCIAggregateInitialize(sctx IN OUT type_generare_json)
	RETURN NUMBER,

	MEMBER FUNCTION ODCIAggregateIterate(self IN OUT type_generare_json, value IN CLOB)
	RETURN NUMBER,

	MEMBER FUNCTION ODCIAggregateTerminate(SELF IN type_generare_json, returnValue OUT CLOB, flags IN NUMBER)
	RETURN NUMBER,

	MEMBER FUNCTION ODCIAggregateMerge(SELF IN OUT type_generare_json, ctx2 IN type_generare_json)
	RETURN NUMBER
)
CREATE TYPE body type_generare_json
IS
	STATIC FUNCTION ODCIAggregateInitialize(sctx IN OUT type_generare_json)
	RETURN NUMBER
	IS BEGIN
		sctx:=type_generare_json(null); --> inizializa contesto di agregacion !.
		RETURN ODCIConst.Success;
	END;

	MEMBER FUNCTION ODCIAggregateIterate(self IN OUT type_generare_json, value IN CLOB)
	RETURN NUMBER
	IS BEGIN
		self.total := self.total || ', ' || value; --> attualiza el contexto de evaluazion de entrada !
		RETURN ODCIConst.Success;
	END;

	MEMBER FUNCTION ODCIAggregateTerminate(self IN type_generare_json, returnValue OUT CLOB, flags IN number)
	RETURN number
	IS BEGIN
		returnValue := ltrim(self.total,', '); --> finaliza la iteracion, libera memoria y ltrim(), elimina  caracteresa la izquierda.
		RETURN ODCIConst.Success;
	END;

	MEMBER FUNCTION ODCIAggregateMerge(self IN OUT type_generare_json, ctx2 IN type_generare_json)
	RETURN number
	IS
	BEGIN
		self.total := self.total ||  ctx2.total;
		RETURN ODCIConst.Success;
	END;
END;
