-- Relatório 1 - Lista dos empregados admitidos entre 2019-01-01 e 2022-03-31
SELECT
    E.cpf AS "CPF Empregado",
    UPPER(E.nome) AS "Nome Empregado",
    DATE_FORMAT(E.dataAdm, '%d/%m/%Y') AS "Data Admissão",
    CONCAT('R$ ', FORMAT(E.salario, 2, 'de_DE')) AS "Salário",
    D.nome AS "Departamento",
    GROUP_CONCAT(T.numero SEPARATOR ', ') AS "Número de Telefone"
FROM
    Empregado AS E
JOIN
    Departamento AS D ON E.Departamento_idDepartamento = D.idDepartamento
LEFT JOIN
    Telefone AS T ON E.cpf = T.Empregado_cpf
WHERE
    E.dataAdm BETWEEN '2019-01-01' AND '2022-03-31'
GROUP BY
    E.cpf, E.nome, E.dataAdm, E.salario, D.nome
ORDER BY
    E.dataAdm DESC;
    
    -- Relatório 2 - Lista dos empregados que ganham menos que a média salarial dos funcionários do Petshop
    SELECT
    E.cpf AS "CPF Empregado",
    UPPER(E.nome) AS "Nome Empregado",
    DATE_FORMAT(E.dataAdm, '%d/%m/%Y') AS "Data Admissão",
    CONCAT('R$ ', FORMAT(E.salario, 2, 'de_DE')) AS "Salário",
    D.nome AS "Departamento",
    GROUP_CONCAT(T.numero SEPARATOR ', ') AS "Número de Telefone"
FROM
    Empregado AS E
JOIN
    Departamento AS D ON E.Departamento_idDepartamento = D.idDepartamento
LEFT JOIN
    Telefone AS T ON E.cpf = T.Empregado_cpf
WHERE
    E.salario < (SELECT AVG(salario) FROM Empregado)
GROUP BY
    E.cpf, E.nome, E.dataAdm, E.salario, D.nome
ORDER BY
    E.nome;
    
    -- Relatório 3 - Lista dos departamentos com a quantidade de empregados total por cada departamento
    SELECT
    D.nome AS "Departamento",
    COUNT(E.cpf) AS "Quantidade de Empregados",
    CONCAT('R$ ', FORMAT(AVG(E.salario), 2, 'de_DE')) AS "Média Salarial",
    CONCAT('R$ ', FORMAT(AVG(E.comissao), 2, 'de_DE')) AS "Média da Comissão"
FROM
    Departamento AS D
LEFT JOIN
    Empregado AS E ON D.idDepartamento = E.Departamento_idDepartamento
GROUP BY
    D.nome
ORDER BY
    D.nome;
    
    -- Relatório 4 - Lista dos empregados com a quantidade total de vendas já realizada por cada Empregado
    SELECT
    E.cpf AS "CPF Empregado",
    UPPER(E.nome) AS "Nome Empregado",
    REPLACE(REPLACE(E.sexo, 'F', 'Feminino'), 'M', 'Masculino') AS "Sexo",
    CONCAT('R$ ', FORMAT(E.salario, 2, 'de_DE')) AS "Salário",
    COUNT(V.idVenda) AS "Quantidade Vendas",
    CONCAT('R$ ', FORMAT(SUM(V.valor), 2, 'de_DE')) AS "Total Valor Vendido",
    CONCAT('R$ ', FORMAT(SUM(V.comissao), 2, 'de_DE')) AS "Total Comissão das Vendas"
FROM
    Empregado AS E
LEFT JOIN
    Venda AS V ON E.cpf = V.Empregado_cpf
GROUP BY
    E.cpf, E.nome, E.sexo, E.salario
ORDER BY
    "Quantidade Vendas" DESC;
    
    -- Relatório 5 - Lista dos empregados que prestaram Serviço na venda computando a quantidade total de vendas
    SELECT
    E.cpf AS "CPF Empregado",
    UPPER(E.nome) AS "Nome Empregado",
    REPLACE(REPLACE(E.sexo, 'F', 'Feminino'), 'M', 'Masculino') AS "Sexo",
    CONCAT('R$ ', FORMAT(E.salario, 2, 'de_DE')) AS "Salário",
    COUNT(DISTINCT V.idVenda) AS "Quantidade Vendas com Serviço",
    CONCAT('R$ ', FORMAT(SUM(IServ.valor * IServ.quantidade), 2, 'de_DE')) AS "Total Valor Vendido com Serviço",
    CONCAT('R$ ', FORMAT(SUM(V.comissao), 2, 'de_DE')) AS "Total Comissão das Vendas com Serviço" -- Soma da comissão total da venda
FROM
    Empregado AS E
LEFT JOIN
    Venda AS V ON E.cpf = V.Empregado_cpf
LEFT JOIN
    itensServico AS IServ ON V.idVenda = IServ.Venda_idVenda
WHERE
    IServ.Servico_idServico IS NOT NULL -- Garante que apenas vendas com serviços sejam consideradas
GROUP BY
    E.cpf, E.nome, E.sexo, E.salario
ORDER BY
    "Quantidade Vendas com Serviço" DESC;
    
    -- Relatório 6 - Lista dos serviços já realizados por um Pet, trazendo as colunas (Nome do Pet, Data do Serviço).
    SELECT
    UPPER(P.nome) AS "Nome do Pet",
    DATE_FORMAT(V.data, '%d/%m/%Y') AS "Data do Serviço",
    S.nome AS "Nome do Serviço",
    IServ.quantidade AS "Quantidade",
    CONCAT('R$ ', FORMAT(IServ.valor, 2, 'de_DE')) AS "Valor",
    UPPER(E.nome) AS "Empregado que realizou o Serviço"
FROM
    PET AS P
JOIN
    itensServico AS IServ ON P.idPET = IServ.PET_idPET
JOIN
    Venda AS V ON IServ.Venda_idVenda = V.idVenda
JOIN
    Servico AS S ON IServ.Servico_idServico = S.idServico
JOIN
    Empregado AS E ON V.Empregado_cpf = E.cpf
ORDER BY
    V.data DESC;
    
    -- Relatório 7 - Lista das vendas já realizadas para um Cliente, trazendo as colunas (Data da Venda, Valor, Desconto
    SELECT
    DATE_FORMAT(V.data, '%d/%m/%Y') AS "Data da Venda",
    CONCAT('R$ ', FORMAT(V.valor, 2, 'de_DE')) AS "Valor",
    CONCAT(FORMAT(V.desconto, 2, 'de_DE'), ' %') AS "Desconto",
    CONCAT('R$ ', FORMAT((V.valor - V.desconto), 2, 'de_DE')) AS "Valor Final",
    UPPER(E.nome) AS "Empregado que realizou a venda"
FROM
    Venda AS V
JOIN
    Empregado AS E ON V.Empregado_cpf = E.cpf
ORDER BY
    V.data DESC;
    
    -- Relatório 8 - Lista dos 10 serviços mais vendidos, trazendo a quantidade vendas cada serviço
    SELECT
    S.nome AS "Nome do Serviço",
    COUNT(IServ.Servico_idServico) AS "Quantidade Vendas",
    CONCAT('R$ ', FORMAT(SUM(IServ.valor * IServ.quantidade), 2, 'de_DE')) AS "Total Valor Vendido"
FROM
    Servico AS S
JOIN
    itensServico AS IServ ON S.idServico = IServ.Servico_idServico
GROUP BY
    S.nome
ORDER BY
    "Quantidade Vendas" DESC
LIMIT 10;

-- Relatório 11 - Lista dos Produtos, informando qual Fornecedor de cada produto).
SELECT
    FPV.tipo AS "Tipo Forma Pagamento",
    COUNT(DISTINCT FPV.Venda_idVenda) AS "Quantidade Vendas",
    CONCAT('R$ ', FORMAT(SUM(FPV.valorPago), 2, 'de_DE')) AS "Total Valor Vendido"
FROM
    FormaPgVenda AS FPV
GROUP BY
    FPV.tipo
ORDER BY
    "Quantidade Vendas" DESC;
    
    -- relatório 12 lissta dos empregados que ganham menos que a média salarial dos funcionários do Petshop.
    SELECT
    P.nome AS "Nome Produto",
    SUM(IVP.quantidade) AS "Quantidade (Total) Vendas",
    CONCAT('R$ ', FORMAT(SUM(IVP.valor * IVP.quantidade), 2, 'de_DE')) AS "Valor Total Recebido pela Venda do Produto"
FROM
    Produtos AS P
JOIN
    ItensVendaProd AS IVP ON P.idProduto = IVP.Produto_idProduto
GROUP BY
    P.nome
ORDER BY
    "Quantidade (Total) Vendas" DESC;