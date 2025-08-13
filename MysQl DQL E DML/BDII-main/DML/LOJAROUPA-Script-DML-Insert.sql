

USE `mydb`;

INSERT INTO `categoria` (id_categoria, nomel, descrição) VALUES
(1, 'Camisetas', 'Diversos tipos de camisetas'),
(2, 'Calças', 'Calças masculinas e femininas'),
(3, 'Jaquetas', 'Jaquetas e casacos'),
(4, 'Shorts', 'Shorts e bermudas'),
(5, 'Camisas', 'Camisas sociais e casuais'),
(6, 'Moletom', 'Moletons confortáveis'),
(7, 'Saias', 'Saias de todos os estilos'),
(8, 'Blusas', 'Blusas de frio e verão'),
(9, 'Bermudas', 'Bermudas masculinas e femininas'),
(10, 'Regatas', 'Regatas esportivas e casuais');


INSERT INTO `fornecedor` (id_fornecedor, nome, endereco, telefone, email, cnpj) VALUES
(1, 'Fornecedor A', 'Rua A, 100', '1199999-9999', 'contato@fornecedora.com', '12.345.678/0001-90'),
(2, 'Fornecedor B', 'Av. B, 200', '1198888-8888', 'contato@fornecedorb.com', '98.765.432/0001-12'),
(3, 'Fornecedor C', 'Rua C, 300', '1197777-7777', 'contato@fornecedorc.com', '11.223.344/0001-55'),
(4, 'Fornecedor D', 'Rua D, 400', '1196666-6666', 'contato@fornecedord.com', '44.556.677/0001-33'),
(5, 'Fornecedor E', 'Av. E, 500', '1195555-5555', 'contato@fornecedore.com', '22.334.455/0001-78'),
(6, 'Fornecedor F', 'Rua F, 600', '1194444-4444', 'contato@fornecedorf.com', '33.445.566/0001-44'),
(7, 'Fornecedor G', 'Rua G, 700', '1193333-3333', 'contato@fornecedorg.com', '55.667.788/0001-22'),
(8, 'Fornecedor H', 'Av. H, 800', '1192222-2222', 'contato@fornecedorth.com', '66.778.899/0001-11'),
(9, 'Fornecedor I', 'Rua I, 900', '1191111-1111', 'contato@fornecedorI.com', '77.889.900/0001-55'),
(10, 'Fornecedor J', 'Av. J, 1000', '1190000-0000', 'contato@fornecedorj.com', '88.990.011/0001-44');


INSERT INTO `desconto` (id_desconto, desconto, descricao) VALUES
(1, 0.05, 'Desconto de Verão'),
(2, 0.10, 'Desconto Fidelidade'),
(3, 0.00, 'Sem Desconto'),
(4, 0.15, 'Desconto Especial'),
(5, 0.00, 'Sem Desconto'),
(6, 0.08, 'Desconto de Campanha'),
(7, 0.03, 'Desconto Rápido'),
(8, 0.12, 'Desconto VIP'),
(9, 0.00, 'Sem Desconto'),
(10, 0.07, 'Desconto Progressivo');


INSERT INTO `funcionario` (id_funcionario, cpf, nome, cargo, telefone, email) VALUES
(1, '111.111.111-11', 'Vendedor Alfa', 'Vendedor', '9999-1111', 'vendedor1@empresa.com'),
(2, '222.222.222-22', 'Vendedor Beta', 'Vendedor', '9999-2222', 'vendedor2@empresa.com'),
(3, '333.333.333-33', 'Mariana Rocha', 'Gerente', '9999-3333', 'mariana@empresa.com'),
(4, '444.444.444-44', 'Vendedor Delta', 'Vendedor', '9999-4444', 'vendedor4@empresa.com'),
(5, '555.555.555-55', 'Vendedor Epsilon', 'Vendedor', '9999-5555', 'vendedor5@empresa.com'),
(6, '666.666.666-66', 'Vendedor Zeta', 'Vendedor', '9999-6666', 'vendedor6@empresa.com'),
(7, '777.777.777-77', 'Vendedor Eta', 'Vendedor', '9999-7777', 'vendedor7@empresa.com'),
(8, '888.888.888-88', 'Vendedor Teta', 'Vendedor', '9999-8888', 'vendedor8@empresa.com'),
(9, '999.999.999-99', 'Vendedor Iota', 'Vendedor', '9999-9999', 'vendedor9@empresa.com'),
(10, '101.010.101-01', 'Vendedor Kappa', 'Vendedor', '9999-0000', 'vendedor10@empresa.com');


INSERT INTO `cliente` (id_cliente, nome, email, telefone, endereco, cadastro_data) VALUES
(1, 'João Silva', 'joao@email.com', '9999-9999', 'Rua A, 123', '2025-01-01'),
(2, 'Maria Souza', 'maria@email.com', '8888-8888', 'Rua B, 456', '2025-01-02'),
(3, 'Pedro Santos', 'pedro@email.com', '7777-7777', 'Rua C, 789', '2025-01-03'),
(4, 'Ana Lima', 'ana@email.com', '6666-6666', 'Rua D, 101', '2025-01-04'),
(5, 'Lucas Melo', 'lucas@email.com', '5555-5555', 'Rua E, 202', '2025-01-05'),
(6, 'Paula Costa', 'paula@email.com', '4444-4444', 'Rua F, 303', '2025-01-06'),
(7, 'Rafael Dias', 'rafael@email.com', '3333-3333', 'Rua G, 404', '2025-01-07'),
(8, 'Juliana Reis', 'juliana@email.com', '2222-2222', 'Rua H, 505', '2025-01-08'),
(9, 'Felipe Rocha', 'felipe@email.com', '1111-1111', 'Rua I, 606', '2025-01-09'),
(10, 'Carla Martins', 'carla@email.com', '0000-0000', 'Rua J, 707', '2025-01-10');


INSERT INTO `Produto` (id_produto, nome, tamanho, cor, preco, categoria_id_categoria, fornecedor_id_fornecedor, marca) VALUES
(1, 'Camiseta Básica', 'G', 'Preto', 39.90, 1, 1, 'Marca A'),
(2, 'Calça Jeans', '42', 'Azul', 120.00, 2, 2, 'Marca B'),
(3, 'Jaqueta', 'GG', 'Vermelho', 199.90, 3, 3, 'Marca C'),
(4, 'Shorts', 'M', 'Bege', 49.90, 4, 4, 'Marca D'),
(5, 'Camisa Social', 'G', 'Branco', 89.90, 5, 5, 'Marca E'),
(6, 'Moletom', 'GG', 'Cinza', 149.90, 6, 6, 'Marca F'),
(7, 'Saia', 'P', 'Rosa', 59.90, 7, 7, 'Marca G'),
(8, 'Blusa de Frio', 'M', 'Verde', 99.90, 8, 8, 'Marca H'),
(9, 'Bermuda', 'G', 'Azul', 59.90, 9, 9, 'Marca I'),
(10, 'Regata', 'P', 'Preto', 29.90, 10, 10, 'Marca J');


INSERT INTO `venda` (id_venda, data_venda, id_cliente, funcionario_id_funcionario, desconto_id_desconto, valor, desconto) VALUES
(1, '2025-05-01', 1, 1, 1, 150.00, 0.05),
(2, '2025-05-02', 2, 2, 2, 200.00, 0.10),
(3, '2025-05-03', 3, 3, 3, 75.00, 0.00),
(4, '2025-05-04', 4, 4, 4, 300.00, 0.15),
(5, '2025-05-05', 5, 5, 5, 50.00, 0.00),
(6, '2025-05-06', 6, 6, 6, 120.00, 0.08),
(7, '2025-05-07', 7, 7, 7, 90.00, 0.03),
(8, '2025-05-08', 8, 8, 8, 250.00, 0.12),
(9, '2025-05-09', 9, 9, 9, 60.00, 0.00),
(10, '2025-05-10', 10, 10, 10, 180.00, 0.07);


INSERT INTO `estoque` (id_estoque, quantidade, id_produto, cod_produto, data_entrada, data_saida) VALUES
(1, 50, 1, 1001, '2025-01-01', NULL),
(2, 30, 2, 1002, '2025-01-05', NULL),
(3, 20, 3, 1003, '2025-01-10', NULL),
(4, 40, 4, 1004, '2025-01-15', NULL),
(5, 60, 5, 1005, '2025-01-20', NULL),
(6, 70, 6, 1006, '2025-01-25', NULL),
(7, 15, 7, 1007, '2025-01-30', NULL),
(8, 25, 8, 1008, '2025-02-05', NULL),
(9, 10, 9, 1009, '2025-02-10', NULL),
(10, 5, 10, 1010, '2025-02-15', NULL);


ALTER TABLE fornecedor
CHANGE COLUMN `resonsavel` `responsavel` VARCHAR(150);

ALTER TABLE Produto
CHANGE COLUMN `preço` `preco` DECIMAL(10,2);

SELECT * FROM estoque;

SELECT * FROM cliente;

SELECT * FROM Produto;

SELECT * FROM estoque;

SELECT * FROM fornecedor;