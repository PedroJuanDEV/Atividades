
-- 1. View: v_produtos_detalhados - Product details with category and supplier.
CREATE VIEW v_produtos_detalhados AS
SELECT
    p.id_produto,
    p.nome AS NomeProduto,
    p.preco,
    p.tamanho,
    p.cor,
    p.marca,
    c.nomel AS Categoria,
    f.nome AS Fornecedor
FROM
    Produto p
JOIN
    categoria c ON p.categoria_id_categoria = c.id_categoria
JOIN
    fornecedor f ON p.fornecedor_id_fornecedor = f.id_fornecedor;

-- 2. View: v_vendas_por_cliente - Total sales per customer.
CREATE VIEW v_vendas_por_cliente AS
SELECT
    cli.id_cliente,
    cli.nome AS NomeCliente,
    SUM(v.valor) AS ValorTotalVendas
FROM
    venda v
JOIN
    cliente cli ON v.id_cliente = cli.id_cliente
GROUP BY
    cli.id_cliente, cli.nome;

-- 3. View: v_estoque_atual - Products and their current stock.
CREATE VIEW v_estoque_atual AS
SELECT
    p.id_produto,
    p.nome AS NomeProduto,
    p.marca AS MarcaProduto,
    COALESCE(e.quantidade, 0) AS QuantidadeEmEstoque
FROM
    Produto p
LEFT JOIN
    estoque e ON p.id_produto = e.id_produto;

-- 4. View: v_vendas_por_funcionario - Total sales per employee.
CREATE VIEW v_vendas_por_funcionario AS
SELECT
    func.id_funcionario,
    func.nome AS NomeFuncionario,
    func.cargo AS CargoFuncionario,
    SUM(v.valor) AS ValorTotalVendas
FROM
    venda v
JOIN
    funcionario func ON v.funcionario_id_funcionario = func.id_funcionario
GROUP BY
    func.id_funcionario, func.nome, func.cargo;

-- 5. View: v_historico_vendas - Detailed sales transactions (date, customer, employee, total value, discount).
CREATE VIEW v_historico_vendas AS
SELECT
    v.id_venda,
    v.data_venda,
    cli.nome AS NomeCliente,
    func.nome AS NomeFuncionario,
    v.valor AS ValorVendaBruta,
    d.desconto AS PercentualDescontoAplicado,
    (v.valor - v.desconto) AS ValorFinalVenda
FROM
    venda v
JOIN
    cliente cli ON v.id_cliente = cli.id_cliente
JOIN
    funcionario func ON v.funcionario_id_funcionario = func.id_funcionario
JOIN
    desconto d ON v.desconto_id_desconto = d.id_desconto;

-- 6. View: v_produtos_por_categoria - Products grouped by category.
CREATE VIEW v_produtos_por_categoria AS
SELECT
    c.nomel AS Categoria,
    p.nome AS NomeProduto,
    p.preco AS PrecoProduto
FROM
    categoria c
JOIN
    Produto p ON c.id_categoria = p.categoria_id_categoria;

-- 7. View: v_clientes_com_endereco - Customers with their full addresses.
CREATE VIEW v_clientes_com_endereco AS
SELECT
    cli.id_cliente,
    cli.nome AS NomeCliente,
    cli.email AS EmailCliente,
    ec.rua AS Rua,
    ec.bairro AS Bairro,
    ec.cidade AS Cidade,
    ec.uf AS UF,
    ec.cep AS CEP
FROM
    cliente cli
JOIN
    endereco_cliente ec ON cli.id_cliente = ec.cliente_id_cliente;

-- 8. View: v_top_vendas_produto - Top-selling products by quantity.
-- This view will need to be refreshed if you want the "top" to be dynamic.
-- For a static view of current top 5, you'd add LIMIT 5 here. For general use, it lists all with quantities.
CREATE VIEW v_total_vendido_por_produto AS
SELECT
    p.id_produto,
    p.nome AS NomeProduto,
    SUM(vp.quantidade) AS QuantidadeTotalVendida,
    SUM(vp.quantidade * vp.valor) AS ValorTotalVendido
FROM
    venda_produto vp
JOIN
    Produto p ON vp.produto_id_produto = p.id_produto
GROUP BY
    p.id_produto, p.nome;

-- 9. View: v_fornecedores_com_produtos - Suppliers and the number of distinct products they provide.
CREATE VIEW v_fornecedores_com_produtos AS
SELECT
    f.id_fornecedor,
    f.nome AS NomeFornecedor,
    COUNT(DISTINCT p.id_produto) AS NumeroDeProdutosFornecidos
FROM
    fornecedor f
JOIN
    Produto p ON f.id_fornecedor = p.fornecedor_id_fornecedor
GROUP BY
    f.id_fornecedor, f.nome;

-- 10. View: v_vendas_com_desconto_aplicado - Sales transactions where a discount was explicitly applied.
CREATE VIEW v_vendas_com_desconto_aplicado AS
SELECT
    v.id_venda,
    v.data_venda,
    v.valor AS ValorOriginalVenda,
    v.desconto AS ValorDescontoAplicado,
    (v.valor - v.desconto) AS ValorFinalVenda,
    d.descricao AS DescricaoDesconto
FROM
    venda v
JOIN
    desconto d ON v.desconto_id_desconto = d.id_desconto
WHERE
    v.desconto > 0;

-- 11. View: v_produtos_sem_venda - Products that have never been sold.
CREATE VIEW v_produtos_sem_venda AS
SELECT
    p.id_produto,
    p.nome AS NomeProduto,
    c.nomel AS Categoria,
    f.nome AS Fornecedor
FROM
    Produto p
LEFT JOIN
    venda_produto vp ON p.id_produto = vp.produto_id_produto
JOIN
    categoria c ON p.categoria_id_categoria = c.id_categoria
JOIN
    fornecedor f ON p.fornecedor_id_fornecedor = f.id_fornecedor
WHERE
    vp.id_venda IS NULL;
