CREATE OR REPLACE FUNCTION func_somar (INTEGER, INTEGER)
RETURNS INTEGER
SECURITY DEFINER
RETURNS null ON null INPUT
LANGUAGE SQL
AS $$ -- o simbolo dollar marca o inicio e o fim da inserção da função
	SELECT $1 + $2; -- $1 e $2 fazem referencia com os INTEGERS do corpo da função
	$$;
	
SELECT func_somar (3,4);

-- teste do security define retornando null como resposta
SELECT func_somar (3, null);

CREATE OR REPLACE FUNCTION func_soma (INTEGER, INTEGER)
RETURNS INTEGER
SECURITY DEFINER
CALLED ON null INPUT
LANGUAGE SQL
AS $$ -- o simbolo dollar marca o inicio e o fim da inserção da função
	SELECT $1 + $2; -- $1 e $2 fazem referencia com os INTEGERS do corpo da função
	$$;
	
SELECT func_soma (3, null);	

-- COALESCE serve para retornar primeiro valor não nulo, funciona como um tratamento de erros.

SELECT COALESCE (null, null, 'eu', null);

-- FUNÇAO TRATADA COM COALESCE

CREATE OR REPLACE FUNCTION func_soma (INTEGER, INTEGER)
RETURNS INTEGER
SECURITY DEFINER
--RETURNS null ON null INPUT
CALLED ON null INPUT
LANGUAGE SQL
AS $$ 
	SELECT COALESCE ($1,0) + COALESCE ($2,0); 
	$$;
	
SELECT func_soma (3, null);	

-- FUNÇÂO PARA INSERIR NOVOS BANCOS

CREATE OR REPLACE FUNCTION bancos_add (p_numero INTEGER, p_nome VARCHAR, p_ativo BOOLEAN)
RETURNS INTEGER
SECURITY INVOKER 
LANGUAGE PLPGSQL
CALLED ON null INPUT
AS $$
DECLARE variavel_id INTEGER;
BEGIN
	IF p_numero IS null OR p_nome IS null OR p_ativo IS null THEN
		RETURN 0;
	END IF;
	
	SELECT INTO variavel_id numero
	FROM banco
	WHERE numero = p_numero;
	
	IF variavel_id IS null THEN
		INSERT INTO banco(numero, nome, ativo)
		VALUES (p_numero, p_nome, p_ativo);
	ELSE
		RETURN variavel_id;
	END IF;
	
	SELECT INTO variavel_id numero
	FROM banco
	WHERE numero = p_numero;	
	
	RETURN variavel_id;
	
END; -- END determina o final de uma transação dentro de uma função (na função usa-se COMMIT).
$$;

SELECT bancos_add (5433, 'banco_ativo', TRUE);

SELECT numero, nome, ativo FROM banco WHERE numero = 5433;