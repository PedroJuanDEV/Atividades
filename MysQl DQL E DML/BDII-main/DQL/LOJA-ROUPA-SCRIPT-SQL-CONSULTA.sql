SELECT c.id_cliente, c.nome, e.cidade, e.bairro, e.rua
FROM cliente c
JOIN endereco_cliente e ON c.id_cliente = e.cliente_id_cliente;

SELECT p.nome, e.quantidade
FROM Produto p
JOIN estoque e ON p.id_produto = e.id_produto
WHERE e.quantidade < 10;

SELECT c.id_cliente, c.nome, COUNT(v.id_venda) AS total_vendas
FROM cliente c
JOIN venda v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome;

SELECT f.id_funcionario, f.nome, COUNT(v.id_venda) AS total_vendas
FROM funcionario f
JOIN venda v ON f.id_funcionario = v.funcionario_id_funcionario
GROUP BY f.id_funcionario, f.nome
HAVING total_vendas > 5;

SELECT p.id_produto, p.nome, SUM(vp.quantidade) AS total_vendido
FROM venda_produto vp
JOIN Produto p ON vp.produto_id_produto = p.id_produto
GROUP BY p.id_produto, p.nome
ORDER BY total_vendido DESC;

SELECT f.id_funcionario, f.nome, SUM(vp.valor) AS total_vendas_valor
FROM funcionario f
JOIN venda v ON f.id_funcionario = v.funcionario_id_funcionario
JOIN venda_produto vp ON v.id_venda = vp.venda_id_venda
GROUP BY f.id_funcionario, f.nome;

SELECT v.id_venda, v.data_venda
FROM venda v;

SELECT f.id_fornecedor, f.nome, p.nome AS produto
FROM fornecedor f
JOIN Produto p ON f.id_fornecedor = p.fornecedor_id_fornecedor;

SELECT c.id_cliente, c.nome, SUM(vp.valor) AS total_gasto
FROM cliente c
JOIN venda v ON c.id_cliente = v.id_cliente
JOIN venda_produto vp ON v.id_venda = vp.venda_id_venda
GROUP BY c.id_cliente, c.nome;

SELECT c.id_cliente, c.nome
FROM cliente c
WHERE c.id_cliente NOT IN (
    SELECT DISTINCT id_cliente FROM venda
);

SELECT v.id_venda, v.data_venda
FROM venda v
WHERE v.data_venda = '2025-05-01';

SELECT p.nome AS produto, f.nome AS fornecedor
FROM Produto p
JOIN fornecedor f ON p.fornecedor_id_fornecedor = f.id_fornecedor;

SELECT f.id_funcionario, f.nome
FROM funcionario f
WHERE f.id_funcionario NOT IN (
    SELECT DISTINCT funcionario_id_funcionario FROM venda
);

SELECT vp.id_venda, vp.quantidade, vp.valor
FROM venda_produto vp;

SELECT c.id_cliente, c.nome
FROM cliente c
WHERE c.telefone IS NOT NULL AND c.telefone != '';

-- SELECT f.id_pagamento, f.tipo, f.valor, p.id_venda
-- FROM formapagamento f
-- JOIN venda v ON f.venda_id_venda = v.id_venda;

SELECT c.id_cliente, c.nome, AVG(vp.valor) AS media_venda
FROM cliente c
JOIN venda v ON c.id_cliente = v.id_cliente
JOIN venda_produto vp ON v.id_venda = vp.venda_id_venda
GROUP BY c.id_cliente, c.nome;

SELECT v.id_venda, COUNT(vp.id_venda) AS total_itens
FROM venda v
JOIN venda_produto vp ON v.id_venda = vp.venda_id_venda
GROUP BY v.id_venda
HAVING total_itens > 3;

SELECT p.nome, e.quantidade, p.preco, (p.preco * e.quantidade) AS total_valor_em_estoque
FROM Produto p
JOIN estoque e ON p.id_produto = e.id_produto;

SELECT f.nome, f.endereco
FROM funcionario f;
