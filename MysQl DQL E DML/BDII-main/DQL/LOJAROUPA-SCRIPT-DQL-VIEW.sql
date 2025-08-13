CREATE VIEW view_clientes_com_endereco AS
SELECT c.id_cliente, c.nome, c.email, e.cidade, e.bairro, e.rua
FROM cliente c
JOIN endereco_cliente e ON c.id_cliente = e.cliente_id_cliente;

CREATE VIEW view_estoque_com_produtos AS
SELECT e.id_estoque, e.quantidade, p.nome AS produto, p.tamanho, p.cor, p.preco
FROM estoque e
JOIN Produto p ON e.id_produto = p.id_produto;

CREATE VIEW view_vendas_detalhadas AS
SELECT v.id_venda, v.data_venda, v.status, c.nome AS cliente, f.nome AS funcionario
FROM venda v
JOIN cliente c ON v.id_cliente = c.id_cliente
JOIN funcionario f ON v.funcionario_id_funcionario = f.id_funcionario;

CREATE VIEW view_vendas_por_funcionario AS
SELECT f.id_funcionario, f.nome, COUNT(v.id_venda) AS total_vendas
FROM funcionario f
JOIN venda v ON f.id_funcionario = v.funcionario_id_funcionario
GROUP BY f.id_funcionario, f.nome;

CREATE VIEW view_pagamentos_realizados AS
SELECT fp.id_pagamento, fp.tipo_pagamento, fp.valor, fp.data_pagamento, v.id_venda
FROM formapagamento fp
JOIN venda v ON fp.venda_id_venda = v.id_venda;

CREATE VIEW view_clientes_com_vendas AS
SELECT DISTINCT c.id_cliente, c.nome, v.id_venda, v.status
FROM cliente c
JOIN venda v ON c.id_cliente = v.id_cliente;

CREATE VIEW view_produtos_mais_vendidos AS
SELECT p.id_produto, p.nome, SUM(vp.quantidade) AS total_vendido
FROM venda_produto vp
JOIN Produto p ON vp.produto_id_produto = p.id_produto
GROUP BY p.id_produto, p.nome
ORDER BY total_vendido DESC;

CREATE VIEW view_fornecedores_ativos AS
SELECT f.id_fornecedor, f.nome, f.cnpj, f.status
FROM fornecedor f
WHERE f.status = 'Ativo';

CREATE VIEW view_estoque_baixo AS
SELECT e.id_estoque, p.nome AS produto, e.quantidade
FROM estoque e
JOIN Produto p ON e.id_produto = p.id_produto
WHERE e.quantidade < 10;

CREATE VIEW view_telefones_clientes AS
SELECT c.id_cliente, c.nome, c.telefone
FROM cliente c;
