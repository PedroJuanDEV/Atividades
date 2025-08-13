
DELIMITER $$

CREATE FUNCTION FN_CALCULA_VALOR_TOTAL_VENDA(p_id_venda INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE v_valor_bruto_itens DECIMAL(10,2);
    DECLARE v_desconto_percentual DECIMAL(10,2);
    DECLARE v_valor_final DECIMAL(10,2);
    SELECT SUM(vp.quantidade * vp.valor)
    INTO v_valor_bruto_itens
    FROM mydb.venda_produto vp
    WHERE vp.venda_id_venda = p_id_venda;
    SELECT v.desconto
    INTO v_desconto_percentual
    FROM mydb.venda v
    WHERE v.id_venda = p_id_venda;
    IF v_valor_bruto_itens IS NULL THEN
        SET v_valor_final = 0;
    ELSE
        SET v_valor_final = v_valor_bruto_itens * (1 - IFNULL(v_desconto_percentual, 0));
    END IF;

    RETURN v_valor_final;
END$$

CREATE FUNCTION FN_GET_QUANTIDADE_ESTOQUE(p_id_produto INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_quantidade INT;
    SELECT quantidade INTO v_quantidade
    FROM mydb.estoque
    WHERE id_produto = p_id_produto;
    IF v_quantidade IS NULL THEN
        SET v_quantidade = 0;
    END IF;
    RETURN v_quantidade;
END$$

CREATE FUNCTION FN_DIAS_DESDE_CADASTRO_CLIENTE(p_id_cliente INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_data_cadastro DATE;
    DECLARE v_dias INT;
    SELECT cadastro_data INTO v_data_cadastro
    FROM mydb.cliente
    WHERE id_cliente = p_id_cliente;
    IF v_data_cadastro IS NULL THEN
        SET v_dias = -1;
    ELSE
        SET v_dias = DATEDIFF(CURDATE(), v_data_cadastro);
    END IF;
    RETURN v_dias;
END$$

CREATE FUNCTION FN_GET_NOME_CATEGORIA(p_id_categoria INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE v_nome_categoria VARCHAR(100);
    SELECT nomel INTO v_nome_categoria
    FROM mydb.categoria
    WHERE id_categoria = p_id_categoria;
    IF v_nome_categoria IS NULL THEN
        SET v_nome_categoria = 'Categoria Não Encontrada';
    END IF;
    RETURN v_nome_categoria;
END$$

CREATE FUNCTION FN_PRODUTO_TEM_ESTOQUE_SUFICIENTE(p_id_produto INT, p_quantidade_requerida INT)
RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE v_quantidade_disponivel INT;
    SELECT quantidade INTO v_quantidade_disponivel
    FROM mydb.estoque
    WHERE id_produto = p_id_produto;
    IF v_quantidade_disponivel IS NULL OR v_quantidade_disponivel < p_quantidade_requerida THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END$$

CREATE FUNCTION FN_GET_NOME_FUNCIONARIO(p_id_funcionario INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE v_nome_funcionario VARCHAR(100);

    SELECT nome INTO v_nome_funcionario
    FROM mydb.funcionario
    WHERE id_funcionario = p_id_funcionario;

    IF v_nome_funcionario IS NULL THEN
        SET v_nome_funcionario = 'Funcionário Não Encontrado';
    END IF;

    RETURN v_nome_funcionario;
END$$

DELIMITER ;
