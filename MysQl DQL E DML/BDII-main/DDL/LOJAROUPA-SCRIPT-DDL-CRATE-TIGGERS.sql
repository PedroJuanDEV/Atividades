
DELIMITER $$

CREATE TRIGGER TRG_ATUALIZA_ESTOQUE_VENDA_AFTER_INSERT
AFTER INSERT ON mydb.venda_produto
FOR EACH ROW
BEGIN
    DECLARE v_estoque_antes INT;

    SELECT quantidade INTO v_estoque_antes
    FROM mydb.estoque
    WHERE id_produto = NEW.produto_id_produto;
    UPDATE mydb.estoque
    SET quantidade = quantidade - NEW.quantidade
    WHERE id_produto = NEW.produto_id_produto;
    INSERT INTO mydb.log_vendas_estoque (id_venda, id_produto, quantidade_vendida, quantidade_estoque_antes, quantidade_estoque_depois, observacao)
    VALUES (NEW.venda_id_venda, NEW.produto_id_produto, NEW.quantidade, v_estoque_antes, (v_estoque_antes - NEW.quantidade), 'Venda efetuada via trigger');
END$$

CREATE TRIGGER TRG_LOG_ATUALIZACAO_PRODUTO_PRECO_BEFORE_UPDATE
BEFORE UPDATE ON mydb.Produto
FOR EACH ROW
BEGIN
    IF OLD.preco <> NEW.preco THEN
        INSERT INTO mydb.produto_log_alteracao (id_produto, preco_antigo, preco_novo, tipo_alteracao)
        VALUES (OLD.id_produto, OLD.preco, NEW.preco, 'Atualizacao Preco Via Trigger');
    END IF;
END$$

CREATE TRIGGER TRG_VERIFICA_ESTOQUE_ANTES_VENDA
BEFORE INSERT ON mydb.venda_produto
FOR EACH ROW
BEGIN
    DECLARE v_quantidade_estoque INT;
    SELECT quantidade INTO v_quantidade_estoque
    FROM mydb.estoque
    WHERE id_produto = NEW.produto_id_produto;
    IF v_quantidade_estoque IS NULL OR v_quantidade_estoque < NEW.quantidade THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Quantidade solicitada maior que o estoque disponível para este produto.';
    END IF;
END$$

CREATE TRIGGER TRG_VALIDA_EMAIL_FORNECEDOR
BEFORE INSERT ON mydb.fornecedor
FOR EACH ROW
BEGIN
    IF NEW.email NOT REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Formato de e-mail inválido para o fornecedor.';
    END IF;
END$$

CREATE TRIGGER TRG_VALIDA_EMAIL_FORNECEDOR_UPDATE
BEFORE UPDATE ON mydb.fornecedor
FOR EACH ROW
BEGIN
    IF NEW.email NOT REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Formato de e-mail inválido para o fornecedor.';
    END IF;
END$$

CREATE TRIGGER TRG_INSERE_DATA_CADASTRO_CLIENTE
BEFORE INSERT ON mydb.cliente
FOR EACH ROW
BEGIN
    IF NEW.cadastro_data IS NULL THEN
        SET NEW.cadastro_data = CURDATE();
    END IF;
END$$

CREATE TRIGGER TRG_CALCULA_VALOR_TOTAL_VENDA_AFTER_VENDA_PRODUTO_INSERT
AFTER INSERT ON mydb.venda_produto
FOR EACH ROW
BEGIN
    DECLARE v_novo_valor_total DECIMAL(10,2);
    DECLARE v_desconto_aplicado DECIMAL(10,2);
    SELECT SUM(quantidade * valor)
    INTO v_novo_valor_total
    FROM mydb.venda_produto
    WHERE venda_id_venda = NEW.venda_id_venda;
    SELECT desconto INTO v_desconto_aplicado
    FROM mydb.venda
    WHERE id_venda = NEW.venda_id_venda;
    SET v_novo_valor_total = v_novo_valor_total * (1 - IFNULL(v_desconto_aplicado, 0));
    UPDATE mydb.venda
    SET valor = v_novo_valor_total
    WHERE id_venda = NEW.venda_id_venda;
END$$

DELIMITER ;
