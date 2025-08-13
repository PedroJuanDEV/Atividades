
SELECT '--- Testando PRC_INSERIR_NOVO_PRODUTO ---' AS Mensagem;
CALL PRC_INSERIR_NOVO_PRODUTO(113, 'Smart TV 50', 2500.00, '50 polegadas', 'Preto', 'VisionTech', 1, 1, 10);
CALL PRC_INSERIR_NOVO_PRODUTO(101, 'Produto Existente Teste', 10.00, 'P', 'Branco', 'Teste', 1, 1, 5);
SELECT * FROM mydb.Produto WHERE id_produto = 113;
SELECT * FROM mydb.estoque WHERE id_produto = 113;

SELECT '--- Testando PRC_ATUALIZAR_PRECO_PRODUTO ---' AS Mensagem;
SELECT preco FROM mydb.Produto WHERE id_produto = 101;
CALL PRC_ATUALIZAR_PRECO_PRODUTO(101, 1450.00);
SELECT preco FROM mydb.Produto WHERE id_produto = 101;
SELECT * FROM mydb.produto_log_alteracao WHERE id_produto = 101;

SELECT '--- Testando PRC_REGISTRAR_NOVA_VENDA ---' AS Mensagem;
SELECT quantidade FROM mydb.estoque WHERE id_produto IN (102, 108);
SELECT MAX(id_venda) FROM mydb.venda;
CALL PRC_REGISTRAR_NOVA_VENDA(CURDATE(), 3, 1, 2, '[{"id_produto": 102, "quantidade": 2}, {"id_produto": 108, "quantidade": 1}]');
SELECT MAX(id_venda) FROM mydb.venda;
SELECT * FROM mydb.venda ORDER BY id_venda DESC LIMIT 1;
SELECT * FROM mydb.venda_produto WHERE venda_id_venda = (SELECT MAX(id_venda) FROM mydb.venda);
SELECT quantidade FROM mydb.estoque WHERE id_produto IN (102, 108);
SELECT * FROM mydb.log_vendas_estoque WHERE id_venda = (SELECT MAX(id_venda) FROM mydb.venda);

SELECT '--- Testando PRC_LISTAR_PRODUTOS_POR_FORNECEDOR_E_CATEGORIA ---' AS Mensagem;
CALL PRC_LISTAR_PRODUTOS_POR_FORNECEDOR_E_CATEGORIA('Tech Supplies', 'Eletrônicos');
CALL PRC_LISTAR_PRODUTOS_POR_FORNECEDOR_E_CATEGORIA('Moda', 'Vestuário');

SELECT '--- Testando PRC_ATUALIZAR_DADOS_CLIENTE ---' AS Mensagem;
SELECT * FROM mydb.cliente WHERE id_cliente = 1;
SELECT * FROM mydb.endereco_cliente WHERE cliente_id_cliente = 1;
CALL PRC_ATUALIZAR_DADOS_CLIENTE(1, '31999991111', 'maria.silva.nova@email.com', 'Nova Rua Teste', 'Bairro Novo', 'Belo Horizonte', 'MG', '30000-000');
SELECT * FROM mydb.cliente WHERE id_cliente = 1;
SELECT * FROM mydb.endereco_cliente WHERE cliente_id_cliente = 1;
CALL PRC_ATUALIZAR_DADOS_CLIENTE(999, '00000000000', 'nao.existe@email.com', 'Rua Inexistente', 'Bairro', 'Cidade', 'UF', '00000-000');

SELECT '--- Testando PRC_GERAR_RELATORIO_VENDAS_POR_PERIODO ---' AS Mensagem;
CALL PRC_GERAR_RELATORIO_VENDAS_POR_PERIODO('2025-05-01', '2025-05-31');
