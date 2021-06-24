SELECT numero, nome, ativo
FROM banco;


CREATE OR REPLACE VIEW vw_bancos AS (
	SELECT numero, nome, ativo
	FROM banco
);

SELECT numero, nome, ativo
FROM vw_bancos;


CREATE OR REPLACE VIEW vw_bancos2 (banco_numero, banco_nome, banco_ativo ) AS (
	SELECT numero, nome, ativo
	FROM banco
);

SELECT banco_numero, banco_nome, banco_ativo
FROM vw_bancos2;

INSERT INTO vw_bancos2 (banco_numero, banco_nome, banco_ativo)
VALUES (51, 'Banco Pirassununga', TRUE);

SELECT banco_numero, banco_nome, banco_ativo
FROM vw_bancos2
WHERE banco_numero = 51;

SELECT numero, nome, ativo
FROM banco
WHERE numero = 51;

UPDATE vw_bancos2 
SET banco_ativo = FALSE
Where banco_numero = 51;

DELETE FROM vw_bancos2
WHERE banco_numero = 51;

-- VIEW TEMPORARY
-- ONLY THIS SESSION CAN SEE THE CREATED VIEW

CREATE OR REPLACE TEMPORARY VIEW vw_agencia AS(
	SELECT nome FROM agencia
);

SELECT nome FROM vw_agencia;

-- WITH OPTIONS
-- THE FOLLOWING OPTION VERIFIES IF THE ativo OPTION IS TRUE

CREATE OR REPLACE VIEW vw_bancos_ativos AS (
	SELECT numero, nome, ativo
	FROM banco
	WHERE ativo IS TRUE
) WITH LOCAL CHECK OPTION;

-- THE FOLLOWING COMMAND RETURNS AN ERROR BECAUSE THE INSERT CONTAINS A FALSE ativo
INSERT INTO vw_bancos_ativos (numero, nome, ativo)
VALUES (51, 'Banco Pirassununga', FALSE);

CREATE OR REPLACE VIEW vw_bancos_com_a AS(
	SELECT numero, nome, ativo
	FROM vw_bancos_ativos
	WHERE nome ILIKE 'a%'
)WITH LOCAL CHECK OPTION;

SELECT numero, nome, ativo FROM vw_bancos_com_a;

INSERT INTO vw_bancos_com_a (numero, nome, ativo)
VALUES (659, 'ARVORE DE INVESTIMENTOS', TRUE);

-- RECURSIVE

CREATE TABLE IF NOT EXISTS funcionarios(
	id SERIAL,
	nome VARCHAR (50),
	gerente INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY (gerente) REFERENCES funcionarios (id)
);

INSERT INTO funcionarios (nome, gerente) VALUES ('Kaylean', null);
INSERT INTO funcionarios (nome, gerente) VALUES ('Leonard', 1);
INSERT INTO funcionarios (nome, gerente) VALUES ('Stephany', 1);
INSERT INTO funcionarios (nome, gerente) VALUES ('Alfred', 2);
INSERT INTO funcionarios (nome, gerente) VALUES ('Stella', 3);

SELECT id, nome, gerente FROM funcionarios;

SELECT id, nome, gerente FROM funcionarios WHERE gerente IS null;

SELECT id, nome, gerente FROM funcionarios WHERE gerente IS null
UNION ALL
SELECT id, nome, gerente FROM funcionarios WHERE id = 999; -- simple example


-- RECURSIVE

CREATE OR REPLACE RECURSIVE VIEW vw_func (id, gerente, funcionarios) AS(
	SELECT id, gerente, nome
	FROM funcionarios
	WHERE gerente IS null
	
	UNION ALL
	
	SELECT funcionarios.id, funcionarios.gerente, funcionarios.nome
	FROM funcionarios
	JOIN vw_func ON vw_func.id = funcionarios.gerente
);

SELECT id, gerente, funcionarios FROM vw_func;