DELIMITER $$

DROP PROCEDURE IF EXISTS PRC_INSERIR_NOVO_PRODUTO$$
CREATE PROCEDURE PRC_INSERIR_NOVO_PRODUTO(
    IN p_id_produto INT,
    IN p_nome VARCHAR(150),
    IN p_preco DECIMAL(10,2),
    IN p_tamanho VARCHAR(100),
    IN p_cor VARCHAR(50),
    IN p_marca VARCHAR(100),
    IN p_categoria_id INT,
    IN p_fornecedor_id INT,
    IN p_quantidade_estoque INT
)
BEGIN
    DECLARE v_produto_existe INT;

    SELECT COUNT(*) INTO v_produto_existe
    FROM mydb.Produto
    WHERE id_produto = p_id_produto;

    IF v_produto_existe = 0 THEN
        INSERT INTO mydb.Produto (id_produto, nome, preco, tamanho, cor, marca, categoria_id_categoria, fornecedor_id_fornecedor)
        VALUES (p_id_produto, p_nome, p_preco, p_tamanho, p_cor, p_marca, p_categoria_id, p_fornecedor_id);

        IF p_quantidade_estoque > 0 THEN
            INSERT INTO mydb.estoque (id_estoque, cod_produto, quantidade, data_entrada, id_produto)
            VALUES (
                (SELECT IFNULL(MAX(id_estoque), 0) + 1 FROM mydb.estoque),
                p_id_produto,
                p_quantidade_estoque,
                CURDATE(),
                p_id_produto
            );
        END IF;
        SELECT 'Produto e estoque inseridos com sucesso!' AS Mensagem;
    ELSE
        SELECT 'Erro: Produto com este ID já existe.' AS Mensagem;
    END IF;
END$$

DROP PROCEDURE IF EXISTS PRC_ATUALIZAR_PRECO_PRODUTO$$
CREATE PROCEDURE PRC_ATUALIZAR_PRECO_PRODUTO(
    IN p_id_produto INT,
    IN p_novo_preco DECIMAL(10,2)
)
BEGIN
    DECLARE v_preco_antigo DECIMAL(10,2);

    SELECT preco INTO v_preco_antigo
    FROM mydb.Produto
    WHERE id_produto = p_id_produto;

    IF v_preco_antigo IS NOT NULL THEN
        UPDATE mydb.Produto
        SET preco = p_novo_preco
        WHERE id_produto = p_id_produto;

        SELECT 'Preço do produto atualizado com sucesso.' AS Mensagem;
    ELSE
        SELECT 'Erro: Produto não encontrado.' AS Mensagem;
    END IF;
END$$

DROP PROCEDURE IF EXISTS PRC_REGISTRAR_NOVA_VENDA$$
CREATE PROCEDURE PRC_REGISTRAR_NOVA_VENDA(
    IN p_data_venda DATE,
    IN p_id_cliente INT,
    IN p_id_funcionario INT,
    IN p_id_desconto INT,
    IN p_produtos_json JSON
)
BEGIN
    DECLARE v_id_venda INT;
    DECLARE v_total_venda DECIMAL(10,2) DEFAULT 0;
    DECLARE v_desconto_percentual DECIMAL(10,2);
    DECLARE i INT DEFAULT 0;
    DECLARE v_produto_id INT;
    DECLARE v_quantidade INT;
    DECLARE v_preco_unitario DECIMAL(10,2);
    DECLARE v_estoque_atual INT;
    DECLARE v_message_text VARCHAR(255);
    DECLARE v_id_venda_produto INT;

    SELECT IFNULL(MAX(id_venda), 0) + 1 INTO v_id_venda FROM mydb.venda;

    SELECT desconto INTO v_desconto_percentual FROM mydb.desconto WHERE id_desconto = p_id_desconto;
    IF v_desconto_percentual IS NULL THEN
        SET v_desconto_percentual = 0.00;
    END IF;

    WHILE i < JSON_LENGTH(p_produtos_json) DO
        SET v_produto_id = JSON_UNQUOTE(JSON_EXTRACT(p_produtos_json, CONCAT('$[', i, '].id_produto')));
        SET v_quantidade = JSON_UNQUOTE(JSON_EXTRACT(p_produtos_json, CONCAT('$[', i, '].quantidade')));

        SELECT preco INTO v_preco_unitario FROM mydb.Produto WHERE id_produto = v_produto_id;
        SELECT quantidade INTO v_estoque_atual FROM mydb.estoque WHERE id_produto = v_produto_id;

        IF v_preco_unitario IS NOT NULL AND v_estoque_atual >= v_quantidade THEN
            SET v_total_venda = v_total_venda + (v_preco_unitario * v_quantidade);

            SELECT IFNULL(MAX(id_venda), 0) + 1 INTO v_id_venda_produto FROM mydb.venda_produto;

            INSERT INTO mydb.venda_produto (id_venda, quantidade, valor, produto_id_produto, venda_id_venda)
            VALUES (
                v_id_venda_produto,
                v_quantidade,
                v_preco_unitario,
                v_produto_id,
                v_id_venda
            );

            UPDATE mydb.estoque
            SET quantidade = quantidade - v_quantidade
            WHERE id_produto = v_produto_id;

        ELSEIF v_estoque_atual < v_quantidade THEN
            SET v_message_text = CONCAT('Erro: Produto ', v_produto_id, ' sem estoque suficiente.');
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_message_text;
        ELSE
            SET v_message_text = CONCAT('Erro: Produto ', v_produto_id, ' não encontrado.');
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_message_text;
        END IF;

        SET i = i + 1;
    END WHILE;

    SET v_total_venda = v_total_venda * (1 - v_desconto_percentual);

    INSERT INTO mydb.venda (id_venda, data_venda, desconto, valor, id_cliente, funcionario_id_funcionario, desconto_id_desconto)
    VALUES (v_id_venda, p_data_venda, v_desconto_percentual, v_total_venda, p_id_cliente, p_id_funcionario, p_id_desconto);

    SELECT CONCAT('Venda ', v_id_venda, ' registrada com sucesso! Valor total: ', v_total_venda) AS Mensagem;
END$$

DROP PROCEDURE IF EXISTS PRC_LISTAR_PRODUTOS_POR_FORNECEDOR_E_CATEGORIA$$
CREATE PROCEDURE PRC_LISTAR_PRODUTOS_POR_FORNECEDOR_E_CATEGORIA(
    IN p_nome_fornecedor VARCHAR(100),
    IN p_nome_categoria VARCHAR(100)
)
BEGIN
    SELECT
        p.id_produto,
        p.nome AS NomeProduto,
        p.preco,
        p.marca,
        c.nomel AS Categoria,
        f.nome AS Fornecedor
    FROM
        mydb.Produto p
    JOIN
        mydb.fornecedor f ON p.fornecedor_id_fornecedor = f.id_fornecedor
    JOIN
        mydb.categoria c ON p.categoria_id_categoria = c.id_categoria
    WHERE
        f.nome LIKE CONCAT('%', p_nome_fornecedor, '%') AND c.nomel LIKE CONCAT('%', p_nome_categoria, '%');
END$$

DROP PROCEDURE IF EXISTS PRC_ATUALIZAR_DADOS_CLIENTE$$
CREATE PROCEDURE PRC_ATUALIZAR_DADOS_CLIENTE(
    IN p_id_cliente INT,
    IN p_telefone VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_rua VARCHAR(50),
    IN p_bairro VARCHAR(50),
    IN p_cidade VARCHAR(50),
    IN p_uf VARCHAR(2),
    IN p_cep VARCHAR(13)
)
BEGIN
    DECLARE v_cliente_existe INT;
    DECLARE v_endereco_existe INT;

    SELECT COUNT(*) INTO v_cliente_existe
    FROM mydb.cliente
    WHERE id_cliente = p_id_cliente;

    IF v_cliente_existe > 0 THEN
        UPDATE mydb.cliente
        SET
            telefone = p_telefone,
            email = p_email
        WHERE id_cliente = p_id_cliente;

        SELECT COUNT(*) INTO v_endereco_existe
        FROM mydb.endereco_cliente
        WHERE cliente_id_cliente = p_id_cliente;

        IF v_endereco_existe > 0 THEN
            UPDATE mydb.endereco_cliente
            SET
                rua = p_rua,
                bairro = p_bairro,
                cidade = p_cidade,
                uf = p_uf,
                cep = p_cep
            WHERE cliente_id_cliente = p_id_cliente;
        ELSE
            INSERT INTO mydb.endereco_cliente (id_enderecocli, bairro, rua, cidade, uf, cep, cliente_id_cliente)
            VALUES (
                (SELECT IFNULL(MAX(id_enderecocli), 0) + 1 FROM mydb.endereco_cliente),
                p_bairro, p_rua, p_cidade, p_uf, p_cep, p_id_cliente
            );
        END IF;

        SELECT 'Dados do cliente e endereço atualizados com sucesso.' AS Mensagem;
    ELSE
        SELECT 'Erro: Cliente não encontrado.' AS Mensagem;
    END IF;
END$$

DROP PROCEDURE IF EXISTS PRC_GERAR_RELATORIO_VENDAS_POR_PERIODO$$
CREATE PROCEDURE PRC_GERAR_RELATORIO_VENDAS_POR_PERIODO(
    IN p_data_inicio DATE,
    IN p_data_fim DATE
)
BEGIN
    SELECT
        f.nome AS NomeFuncionario,
        f.cargo AS CargoFuncionario,
        COUNT(v.id_venda) AS TotalVendas,
        SUM(v.valor) AS ValorTotalVendido,
        AVG(v.valor) AS ValorMedioPorVenda
    FROM
        mydb.venda v
    JOIN
        mydb.funcionario f ON v.funcionario_id_funcionario = f.id_funcionario
    WHERE
        v.data_venda BETWEEN p_data_inicio AND p_data_fim
    GROUP BY
        f.id_funcionario, f.nome, f.cargo
    ORDER BY
        ValorTotalVendido DESC;
END$$

DELIMITER ;
