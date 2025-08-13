-- 1. Listar todos os produtos com suas categorias e fornecedores.
SELECT
    p.nome AS NomeProduto,
    p.preco AS Preco,
    c.nomel AS Categoria,
    f.nome AS Fornecedor
FROM
    Produto p
JOIN
    categoria c ON p.categoria_id_categoria = c.id_categoria
JOIN
    fornecedor f ON p.fornecedor_id_fornecedor = f.id_fornecedor;

-- 2. Valor total de vendas por cliente.
SELECT
    cli.nome AS NomeCliente,
    SUM(v.valor) AS ValorTotalVendas
FROM
    venda v
JOIN
    cliente cli ON v.id_cliente = cli.id_cliente
GROUP BY
    cli.nome
ORDER BY
    ValorTotalVendas DESC;

-- 3. Produtos atualmente em estoque com suas quantidades.
SELECT
    p.nome AS NomeProduto,
    e.quantidade AS QuantidadeEmEstoque
FROM
    estoque e
JOIN
    Produto p ON e.id_produto = p.id_produto
WHERE
    e.quantidade > 0;

-- 4. Funcionários e suas respectivas vendas totais.
SELECT
    func.nome AS NomeFuncionario,
    func.cargo AS CargoFuncionario,
    SUM(v.valor) AS ValorTotalVendas
FROM
    venda v
JOIN
    funcionario func ON v.funcionario_id_funcionario = func.id_funcionario
GROUP BY
    func.nome, func.cargo
ORDER BY
    ValorTotalVendas DESC;

-- 5. Vendas realizadas em uma data específica (ex: '2025-05-15'), incluindo nomes de clientes e funcionários.
SELECT
    v.id_venda AS IDVenda,
    v.data_venda AS DataVenda,
    cli.nome AS NomeCliente,
    func.nome AS NomeFuncionario,
    v.valor AS ValorVenda
FROM
    venda v
JOIN
    cliente cli ON v.id_cliente = cli.id_cliente
JOIN
    funcionario func ON v.funcionario_id_funcionario = func.id_funcionario
WHERE
    v.data_venda = '2025-05-15';

-- 6. Produtos de uma categoria específica (ex: 'Eletronicos').
SELECT
    p.nome AS NomeProduto,
    p.preco AS PrecoProduto,
    c.nomel AS Categoria
FROM
    Produto p
JOIN
    categoria c ON p.categoria_id_categoria = c.id_categoria
WHERE
    c.nomel = 'calças';

-- 7. Clientes que fizeram compras acima de um determinado valor total (ex: 500.00).
SELECT
    cli.nome AS NomeCliente,
    SUM(v.valor) AS ValorTotalVendas
FROM
    venda v
JOIN
    cliente cli ON v.id_cliente = cli.id_cliente
GROUP BY
    cli.nome
HAVING
    SUM(v.valor) > 500.00
ORDER BY
    ValorTotalVendas DESC;

-- 8. Fornecedores que fornecem produtos para uma categoria específica (ex: 'Roupas').
SELECT DISTINCT
    f.nome AS NomeFornecedor,
    f.email AS EmailFornecedor
FROM
    fornecedor f
JOIN
    Produto p ON f.id_fornecedor = p.fornecedor_id_fornecedor
JOIN
    categoria c ON p.categoria_id_categoria = c.id_categoria
WHERE
    c.nomel = 'Roupas'; -- Substituir pelo nome da categoria desejada

-- 9. Detalhes do produto juntamente com seus níveis de estoque atuais.
SELECT
    p.nome AS NomeProduto,
    p.marca AS MarcaProduto,
    p.preco AS PrecoUnitario,
    COALESCE(e.quantidade, 0) AS QuantidadeEmEstoque
FROM
    Produto p
LEFT JOIN
    estoque e ON p.id_produto = e.id_produto;

-- 10. Vendas onde um desconto foi aplicado, mostrando detalhes do desconto.
SELECT
    v.id_venda AS IDVenda,
    v.data_venda AS DataVenda,
    d.desconto AS PercentualDesconto,
    d.descricao AS DescricaoDesconto,
    v.valor AS ValorVendaAntesDesconto,
    (v.valor - v.desconto) AS ValorFinalVenda
FROM
    venda v
JOIN
    desconto d ON v.desconto_id_desconto = d.id_desconto
WHERE
    v.desconto > 0;

-- 11. Quantidade total de cada produto vendido.
SELECT
    p.nome AS NomeProduto,
    SUM(vp.quantidade) AS QuantidadeTotalVendida
FROM
    venda_produto vp
JOIN
    Produto p ON vp.produto_id_produto = p.id_produto
GROUP BY
    p.nome
ORDER BY
    QuantidadeTotalVendida DESC;

-- 12. Funcionários que não fizeram nenhuma venda.
SELECT
    f.nome AS NomeFuncionarioSemVendas,
    f.email AS EmailFuncionarioSemVendas
FROM
    funcionario f
LEFT JOIN
    venda v ON f.id_funcionario = v.funcionario_id_funcionario
WHERE
    v.id_venda IS NULL;

-- 13. Categorias sem produtos associados.
SELECT
    c.nomel AS NomeCategoriaVazia
FROM
    categoria c
LEFT JOIN
    Produto p ON c.id_categoria = p.categoria_id_categoria
WHERE
    p.id_produto IS NULL;

-- 14. Clientes com seus endereços completos.
SELECT
    cli.nome AS NomeCliente,
    ec.rua AS Rua,
    ec.bairro AS Bairro,
    ec.cidade AS Cidade,
    ec.uf AS UF,
    ec.cep AS CEP
FROM
    cliente cli
JOIN
    endereco_cliente ec ON cli.id_cliente = ec.cliente_id_cliente;

-- 15. Produtos com preços superiores ao preço médio de TODOS os produtos.
SELECT
    p.nome AS NomeProduto,
    p.preco AS PrecoProduto,
    c.nomel AS Categoria
FROM
    Produto p
JOIN
    categoria c ON p.categoria_id_categoria = c.id_categoria
WHERE
    p.preco > (SELECT AVG(preco) FROM Produto);

-- 16. Vendas com detalhes dos produtos vendidos em cada venda.
SELECT
    v.id_venda AS IDVenda,
    v.data_venda AS DataVenda,
    p.nome AS NomeProdutoVendido,
    vp.quantidade AS QuantidadeVendida,
    vp.valor AS ValorUnitarioNaVenda
FROM
    venda v
JOIN
    venda_produto vp ON v.id_venda = vp.venda_id_venda
JOIN
    Produto p ON vp.produto_id_produto = p.id_produto
ORDER BY
    v.id_venda, p.nome;

-- 17. Valor total dos produtos fornecidos por cada fornecedor.
SELECT
    f.nome AS NomeFornecedor,
    SUM(p.preco * COALESCE(e.quantidade, 0)) AS ValorTotalProdutosFornecidos -- Assumindo valor de estoque atual
FROM
    fornecedor f
JOIN
    Produto p ON f.id_fornecedor = p.fornecedor_id_fornecedor
LEFT JOIN
    estoque e ON p.id_produto = e.id_produto
GROUP BY
    f.nome
ORDER BY
    ValorTotalProdutosFornecidos DESC;

-- 18. Número de produtos por categoria.
SELECT
    c.nomel AS Categoria,
    COUNT(p.id_produto) AS NumeroDeProdutos
FROM
    categoria c
LEFT JOIN
    Produto p ON c.id_categoria = p.categoria_id_categoria
GROUP BY
    c.nomel
ORDER BY
    NumeroDeProdutos DESC;

-- 19. Clientes que compraram um produto específico (ex: 'Camiseta Básica').
SELECT DISTINCT
    cli.nome AS NomeCliente,
    cli.email AS EmailCliente
FROM
    cliente cli
JOIN
    venda v ON cli.id_cliente = v.id_cliente
JOIN
    venda_produto vp ON v.id_venda = vp.venda_id_venda
JOIN
    Produto p ON vp.produto_id_produto = p.id_produto
WHERE
    p.nome = 'Camiseta Básica';

-- 20. Os 5 produtos mais vendidos por quantidade.
SELECT
    p.nome AS NomeProduto,
    SUM(vp.quantidade) AS QuantidadeTotalVendida
FROM
    venda_produto vp
JOIN
    Produto p ON vp.produto_id_produto = p.id_produto
GROUP BY
    p.nome
ORDER BY
    QuantidadeTotalVendida DESC
LIMIT 5;

-- 21. Transações de vendas que incluíram mais de um produto distinto.
SELECT
    v.id_venda AS IDVenda,
    v.data_venda AS DataVenda,
    cli.nome AS NomeCliente,
    COUNT(DISTINCT vp.produto_id_produto) AS NumeroProdutosDistintos
FROM
    venda v
JOIN
    venda_produto vp ON v.id_venda = vp.venda_id_venda
JOIN
    cliente cli ON v.id_cliente = cli.id_cliente
GROUP BY
    v.id_venda, v.data_venda, cli.nome
HAVING
    COUNT(DISTINCT vp.produto_id_produto) > 1
ORDER BY
    NumeroProdutosDistintos DESC;

-- 22. Funcionários cujo total de vendas está acima da média do total de vendas de todos os funcionários.
SELECT
    f.nome AS NomeFuncionario,
    SUM(v.valor) AS TotalVendasFuncionario
FROM
    funcionario f
JOIN
    venda v ON f.id_funcionario = v.funcionario_id_funcionario
GROUP BY
    f.nome
HAVING
    SUM(v.valor) > (SELECT AVG(ValorTotal) FROM (SELECT SUM(valor) AS ValorTotal FROM venda GROUP BY funcionario_id_funcionario) AS SubqueryAvgSales)
ORDER BY
    TotalVendasFuncionario DESC;

-- 23. Produtos que nunca foram vendidos.
SELECT
    p.nome AS NomeProdutoNuncaVendido,
    c.nomel AS CategoriaProduto,
    f.nome AS FornecedorProduto
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

-- 24. Clientes que se registraram em um ano específico (ex: 2022).
SELECT
    c.nome AS NomeCliente,
    c.email AS EmailCliente,
    c.cadastro_data AS DataCadastro
FROM
    cliente c
WHERE
    YEAR(c.cadastro_data) = 2024;

-- 25. Desconto médio aplicado por venda.
SELECT
    AVG(v.desconto) AS MediaDescontoAplicado
FROM
    venda v
WHERE
    v.desconto > 0;
