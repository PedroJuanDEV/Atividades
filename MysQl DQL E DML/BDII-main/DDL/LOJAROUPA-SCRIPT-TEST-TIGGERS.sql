
SELECT '--- Testando TRG_ATUALIZA_ESTOQUE_VENDA_AFTER_INSERT e TRG_VERIFICA_ESTOQUE_ANTES_VENDA ---' AS Mensagem;

SELECT quantidade FROM mydb.estoque WHERE id_produto = 111;

INSERT INTO `mydb`.`venda` (`id_venda`, `data_venda`, `desconto`, `valor`, `id_cliente`, `funcionario_id_funcionario`, `desconto_id_desconto`)
VALUES (20, CURDATE(), 0.00, 0.00, 1, 1, 4);

-- INSERT INTO mydb.venda_produto (`id_venda`, `id_produto`, `quantidade`, `valor`, `produto_id_produto`, `venda_id_venda`)
-- VALUES (2000, 111, 1000, 350.00, 111, 20);

INSERT INTO `mydb`.`venda` (`id_venda`, `data_venda`, `desconto`, `valor`, `id_cliente`, `funcionario_id_funcionario`, `desconto_id_desconto`)
VALUES (21, CURDATE(), 0.00, 0.00, 2, 2, 4);

INSERT INTO mydb.venda_produto (`id_venda`, `id_produto`, `quantidade`, `valor`, `produto_id_produto`, `venda_id_venda`)
VALUES (2001, 111, 5, 350.00, 111, 21);
SELECT quantidade FROM mydb.estoque WHERE id_produto = 111;
SELECT * FROM mydb.log_vendas_estoque WHERE id_venda = 21;
SELECT id_venda, valor FROM mydb.venda WHERE id_venda = 21;

SELECT '--- Testando TRG_LOG_ATUALIZACAO_PRODUTO_PRECO_BEFORE_UPDATE ---' AS Mensagem;
SELECT preco FROM mydb.Produto WHERE id_produto = 112;
UPDATE mydb.Produto SET preco = 90.00 WHERE id_produto = 112;
SELECT * FROM mydb.produto_log_alteracao WHERE id_produto = 112 ORDER BY data_alteracao DESC;

SELECT '--- Testando TRG_VALIDA_EMAIL_FORNECEDOR e TRG_VALIDA_EMAIL_FORNECEDOR_UPDATE ---' AS Mensagem;

-- INSERT INTO mydb.fornecedor (`id_fornecedor`, `nome`, `endereco`, `telefone`, `email`, `cnpj`)
-- VALUES (7, 'Fornecedor Invalido', 'Rua Teste, 1', '99999999999', 'emailinvalido', '06.777.888/0001-99');

INSERT INTO mydb.fornecedor (`id_fornecedor`, `nome`, `endereco`, `telefone`, `email`, `cnpj`)
VALUES (7, 'Fornecedor Valido', 'Rua Teste, 2', '99999999998', 'valido@email.com', '07.777.888/0001-00');
SELECT * FROM mydb.fornecedor WHERE id_fornecedor = 7;

-- UPDATE mydb.fornecedor SET email = 'emailerrado' WHERE id_fornecedor = 7;

SELECT '--- Testando TRG_INSERE_DATA_CADASTRO_CLIENTE ---' AS Mensagem;
INSERT INTO mydb.cliente (`id_cliente`, `nome`, `endereco`, `telefone`, `email`, `cadastro_data`)
VALUES (6, 'Novo Cliente Teste', 'Av. Teste, 10', '88888888888', 'novo.cliente@email.com', NULL);
SELECT id_cliente, nome, cadastro_data FROM mydb.cliente WHERE id_cliente = 6;
