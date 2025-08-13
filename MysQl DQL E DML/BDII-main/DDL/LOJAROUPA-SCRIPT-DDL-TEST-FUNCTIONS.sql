
SELECT '--- Testando FN_CALCULA_VALOR_TOTAL_VENDA ---' AS Mensagem;
SELECT 'Valor calculado para Venda ID 1:', FN_CALCULA_VALOR_TOTAL_VENDA(1) AS ValorTotal;
SELECT 'Valor calculado para Venda ID 2 :', FN_CALCULA_VALOR_TOTAL_VENDA(999) AS ValorTotal;

SELECT '--- Testando FN_GET_QUANTIDADE_ESTOQUE ---' AS Mensagem;
SELECT 'Quantidade em estoque para Produto ID 101:', FN_GET_QvendaUANTIDADE_ESTOQUE(101) AS QuantidadeEstoque;
SELECT 'Quantidade em estoque para Produto ID 3 :', FN_GET_QUANTIDADE_ESTOQUE(999) AS QuantidadeEstoque;

SELECT '--- Testando FN_DIAS_DESDE_CADASTRO_CLIENTE ---' AS Mensagem;
SELECT 'Dias desde o cadastro do Cliente ID 1:', FN_DIAS_DESDE_CADASTRO_CLIENTE(1) AS DiasCadastro;
SELECT 'Dias desde o cadastro do Cliente ID 4:', FN_DIAS_DESDE_CADASTRO_CLIENTE(999) AS DiasCadastro;

SELECT '--- Testando FN_GET_NOME_CATEGORIA ---' AS Mensagem;
SELECT 'Nome da Categoria ID 1:', FN_GET_NOME_CATEGORIA(1) AS NomeCategoria;
SELECT 'Nome da Categoria ID 99 (não existe):', FN_GET_NOME_CATEGORIA(99) AS NomeCategoria;

SELECT '--- Testando FN_PRODUTO_TEM_ESTOQUE_SUFICIENTE ---' AS Mensagem;
SELECT 'Produto ID 101 tem estoque para 5 unidades?', FN_PRODUTO_TEM_ESTOQUE_SUFICIENTE(101, 5) AS TemEstoque;
SELECT 'Produto ID 101 tem estoque para 100 unidades?', FN_PRODUTO_TEM_ESTOQUE_SUFICIENTE(101, 100) AS TemEstoque;
SELECT 'Produto ID 999 tem estoque para 1 unidade?', FN_PRODUTO_TEM_ESTOQUE_SUFICIENTE(999, 1) AS TemEstoque;

SELECT '--- Testando FN_GET_NOME_FUNCIONARIO ---' AS Mensagem;
SELECT 'Nome do Funcionário ID 1:', FN_GET_NOME_FUNCIONARIO(1) AS NomeFuncionario;
SELECT 'Nome do Funcionário ID 99 (não existe):', FN_GET_NOME_FUNCIONARIO(99) AS NomeFuncionario;
