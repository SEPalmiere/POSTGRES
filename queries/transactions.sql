SELECT numero, nome FROM banco ORDER BY numero;


-- TRANSACTIONS

BEGIN;
UPDATE banco SET ativo = FALSE WHERE numero = 0;
SELECT numero, nome, ativo FROM banco WHERE numero = 0;
ROLLBACK;
SELECT numero, nome, ativo FROM banco WHERE numero = 0;


UPDATE banco SET ativo = FALSE WHERE numero = 0;

BEGIN;
UPDATE banco SET ativo = TRUE WHERE numero = 0;
COMMIT;

SELECT numero, nome, ativo FROM banco WHERE numero = 0;

SELECT nome, gerente FROM funcionarios;

BEGIN;
UPDATE funcionarios SET gerente = 2 WHERE id = 5;
SAVEPOINT sf_func;
UPDATE funcionarios SET gerente = null;
ROLLBACK TO sf_func;
UPDATE funcionarios SET gerente = 2 WHERE id = 4;
COMMIT;
SELECT nome, gerente FROM funcionarios;