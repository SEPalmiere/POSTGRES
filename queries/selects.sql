SELECT numero, nome, ativo FROM banco;
SELECT banco_numero, numero, nome FROM agencia;
SELECT numero, nome, email FROM cliente;
SELECT id, nome FROM tipo_transacao;
SELECT banco_numero, agencia_numero, numero, cliente_numero FROM conta_corrente;
SELECT banco_numero, agencia_numero, cliente_numero FROM cliente_transacoes;

-- Visualizar nomes das colunas das tabelas--
SELECT * FROM information_schema.columns WHERE table_name = 'cliente_transacoes';
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'cliente_transacoes'

-- LIKE é case sensitive e ILIKE não é case sensitive.
SELECT AVG (valor) FROM cliente_transacoes;
SELECT COUNT (numero) FROM cliente;
SELECT COUNT (numero) 
FROM cliente
WHERE email ILIKE '%gmail.com'
GROUP BY email;

SELECT MAX (valor)
FROM cliente_transacoes;

SELECT MIN (valor)
FROM cliente_transacoes;

SELECT MIN (valor), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id;

SELECT COUNT (id), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id;

SELECT COUNT (id), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id
HAVING COUNT (id) > 150;

SELECT SUM (valor)
FROM cliente_transacoes
GROUP BY tipo_transacao_id;

SELECT SUM (valor), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id
ORDER BY tipo_transacao_id;

SELECT SUM (valor), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id
ORDER BY tipo_transacao_id DESC;
