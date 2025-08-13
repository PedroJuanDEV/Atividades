

UPDATE cliente SET nome = 'Carlos Silva' WHERE id_cliente = 1;

UPDATE endereco_cliente SET cidade = 'São Paulo' WHERE cliente_id_cliente = 1;

UPDATE Produto SET cor = 'Preto' WHERE id_produto = 101;

UPDATE estoque SET quantidade = 50 WHERE id_estoque = 1;

UPDATE desconto SET desconto = 0.10 WHERE id_desconto = 1;

UPDATE funcionario SET nome = 'Mariana Rocha' WHERE id_funcionario = 3;

UPDATE cliente SET telefone = '11999998888' WHERE id_cliente = 1;



DELETE FROM cliente WHERE id_cliente = 4;

DELETE FROM endereco_cliente WHERE cliente_id_cliente = 22;

DELETE FROM Produto WHERE id_produto = 105;

DELETE FROM estoque WHERE id_estoque = 2 AND id_produto = 101;

DELETE FROM fornecedor WHERE id_fornecedor = 6;

DELETE FROM funcionario WHERE id_funcionario = 7;

DELETE FROM venda WHERE id_venda = 3 AND id_cliente = 1 AND funcionario_id_funcionario = 2;

DELETE FROM venda_produto WHERE id_venda = 1 AND produto_id_produto = 101 AND venda_id_venda = 3;
