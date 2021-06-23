SELECT numero, nome from banco;
SELECT bancnumero, numero, nome FROM agencia;


-- CTE
WITH tb1_tmp_banco AS (
	SELECT numero, nome
	FROM banco
)
SELECT numero, nome
FROM tb1_tmp_banco;

WITH param AS(
	SELECT 213 AS banco_numero
), tb1_tmp_banco AS(
	SELECT numero, nome
	FROM banco
	JOIN param ON param.banco_numero = banco.numero
)
	SELECT numero, nome
	FROM tb1_tmp_banco;

-- SUBSELECT

SELECT banco.numero, banco.nome
FROM banco
JOIN (
	SELECT 213 AS banco_numero
) param ON param.banco_numero = banco.numero;

WITH clientes_e_transacoes AS(
	SELECT cliente.nome AS cliente_nome,
			tipo_transacao.nome AS tipo_transacao_nome,
			cliente_transacoes.valor AS tipo_transacao_valor
	FROM cliente_transacoes
	JOIN cliente ON cliente.numero = cliente_transacoes.cliente_numero
	JOIN tipo_transacao ON tipo_transacao.id = cliente_transacoes.tipo_transacao_id
)
SELECT cliente_nome, tipo_transacao_nome, tipo_transacao_valor
FROM clientes_e_transacoes;


WITH clientes_e_transacoes AS(
	SELECT cliente.nome AS cliente_nome,
			tipo_transacao.nome AS tipo_transacao_nome,
			cliente_transacoes.valor AS tipo_transacao_valor
	FROM cliente_transacoes
	JOIN cliente ON cliente.numero = cliente_transacoes.cliente_numero
	JOIN tipo_transacao ON tipo_transacao.id = cliente_transacoes.tipo_transacao_id
	JOIN banco ON banco.numero = cliente_transacoes.banco_numero AND banco.nome ILIKE '%Itaú%'
)
SELECT cliente_nome, tipo_transacao_nome, tipo_transacao_valor
FROM clientes_e_transacoes;