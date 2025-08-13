

CREATE VIEW VIEW_PRODUTOS_POR_CATEGORIA AS
SELECT
    p.nome AS NomeProduto,
    c.nomel AS NomeCategoria,
    c.descrição AS DescricaoCategoria,
    p.preco AS PrecoProduto,
    p.marca AS MarcaProduto
FROM
    mydb.Produto p
JOIN
    mydb.categoria c ON p.categoria_id_categoria = c.id_categoria;

CREATE VIEW VIEW_VENDAS_POR_CLIENTE AS
SELECT
    v.id_venda,
    v.data_venda,
    v.valor AS ValorTotalVenda,
    v.desconto AS DescontoAplicado,
    cli.nome AS NomeCliente,
    cli.email AS EmailCliente,
    func.nome AS NomeFuncionario,
    func.cargo AS CargoFuncionario
FROM
    mydb.venda v
JOIN
    mydb.cliente cli ON v.id_cliente = cli.id_cliente
JOIN
    mydb.funcionario func ON v.funcionario_id_funcionario = func.id_funcionario;

CREATE VIEW VIEW_ESTOQUE_ATUAL AS
SELECT
    p.id_produto,
    p.nome AS NomeProduto,
    p.marca AS MarcaProduto,
    e.quantidade AS QuantidadeEmEstoque,
    e.data_entrada AS UltimaEntradaEstoque
FROM
    mydb.estoque e
JOIN
    mydb.Produto p ON e.id_produto = p.id_produto
WHERE
    e.quantidade > 0;

CREATE VIEW VIEW_VALOR_TOTAL_VENDAS_POR_DIA AS
SELECT
    data_venda,
    SUM(valor) AS ValorTotalVendidoNoDia,
    COUNT(id_venda) AS TotalDeVendasNoDia
FROM
    mydb.venda
GROUP BY
    data_venda
ORDER BY
    data_venda DESC;

CREATE VIEW VIEW_CLIENTES_MAIS_ANTIGOS AS
SELECT
    id_cliente,
    nome AS NomeCliente,
    email AS EmailCliente,
    cadastro_data AS DataCadastro
FROM
    mydb.cliente
ORDER BY
    cadastro_data ASC;

CREATE VIEW VIEW_FUNCIONARIOS_E_CARGOS AS
SELECT
    id_funcionario,
    nome AS NomeFuncionario,
    cpf,
    cargo,
    email AS EmailFuncionario
FROM
    mydb.funcionario
ORDER BY
    cargo, nome;

CREATE VIEW VIEW_PRODUTOS_MAIS_VENDIDOS AS
SELECT
    p.id_produto,
    p.nome AS NomeProduto,
    p.marca AS MarcaProduto,
    SUM(vp.quantidade) AS QuantidadeTotalVendida
FROM
    mydb.venda_produto vp
JOIN
    mydb.Produto p ON vp.produto_id_produto = p.id_produto
GROUP BY
    p.id_produto, p.nome, p.marca
ORDER BY
    QuantidadeTotalVendida DESC;

CREATE VIEW VIEW_FORNECEDORES_E_PRODUTOS AS
SELECT
    f.nome AS NomeFornecedor,
    f.email AS EmailFornecedor,
    p.nome AS NomeProduto,
    p.preco AS PrecoProduto,
    c.nomel AS CategoriaProduto
FROM
    mydb.fornecedor f
JOIN
    mydb.Produto p ON f.id_fornecedor = p.fornecedor_id_fornecedor
JOIN
    mydb.categoria c ON p.categoria_id_categoria = c.id_categoria
ORDER BY
    f.nome, p.nome;

CREATE VIEW VIEW_DESCONTOS_APLICADOS AS
SELECT
    v.id_venda,
    v.data_venda,
    d.descricao AS DescricaoDesconto,
    d.desconto AS PercentualDesconto,
    v.valor AS ValorFinalVenda
FROM
    mydb.venda v
JOIN
    mydb.desconto d ON v.desconto_id_desconto = d.id_desconto
WHERE
    d.desconto > 0;

CREATE VIEW VIEW_ENDERECOS_COMPLETOS_CLIENTES AS
SELECT
    c.id_cliente,
    c.nome AS NomeCliente,
    ec.rua AS Rua,
    ec.bairro AS Bairro,
    ec.cidade AS Cidade,
    ec.uf AS UF,
    ec.cep AS CEP
FROM
    mydb.cliente c
JOIN
    mydb.endereco_cliente ec ON c.id_cliente = ec.cliente_id_cliente;

CREATE VIEW VIEW_DETALHE_ITENS_VENDA AS
SELECT
    v.id_venda,
    v.data_venda,
    p.nome AS NomeProduto,
    vp.quantidade AS QuantidadeVendida,
    vp.valor AS ValorUnitarioNaVenda,
    (vp.quantidade * vp.valor) AS SubtotalItem
FROM
    mydb.venda_produto vp
JOIN
    mydb.venda v ON vp.venda_id_venda = v.id_venda
JOIN
    mydb.Produto p ON vp.produto_id_produto = p.id_produto
ORDER BY
    v.id_venda, p.nome;

CREATE VIEW VIEW_PRODUTOS_SEM_ESTOQUE AS
SELECT
    p.id_produto,
    p.nome AS NomeProduto,
    p.marca AS MarcaProduto,
    e.quantidade AS QuantidadeEmEstoque
FROM
    mydb.estoque e
JOIN
    mydb.Produto p ON e.id_produto = p.id_produto
WHERE
    e.quantidade = 0;
