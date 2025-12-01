-- ========================================
-- SISTEMA DE GESTÃO CAFETERIA "PINGADO – RODA E GRÃO"
-- Script de Inserção de Dados (INSERT)
-- ========================================

USE pingado_roda_grao;

-- INSERIR FUNCIONÁRIOS
INSERT INTO FUNCIONARIO (nome, cpf, telefone, cargo, turno) VALUES
('João Silva', '12345678901', '(41)98765-4321', 'barista', 'manhã'),
('Maria Santos', '23456789012', '(41)98765-4322', 'barista', 'tarde'),
('Carlos Oliveira', '34567890123', '(41)98765-4323', 'gerente', 'manhã'),
('Ana Costa', '45678901234', '(41)98765-4324', 'barista', 'noite'),
('Pedro Souza', '56789012345', '(41)98765-4325', 'barista', 'manhã');

-- INSERIR CLIENTES FIDELIDADE
INSERT INTO CLIENTE_FIDELIDADE (nome, cpf, telefone, email, carimbos_acumulados, data_cadastro) VALUES
('José da Silva', '11122233344', '(41)99999-1111', 'jose@email.com', 8, '2024-01-15'),
('Mariana Alves', '22233344455', '(41)99999-2222', 'mariana@email.com', 12, '2024-02-20'),
('Ricardo Pereira', '33344455566', '(41)99999-3333', 'ricardo@email.com', 5, '2024-03-10'),
('Fernanda Lima', '44455566677', '(41)99999-4444', 'fernanda@email.com', 15, '2024-01-25'),
('Lucas Martins', '55566677788', '(41)99999-5555', 'lucas@email.com', 3, '2024-04-05'),
('Juliana Costa', '66677788899', '(41)99999-6666', 'juliana@email.com', 20, '2023-12-10'),
('Roberto Carlos', '77788899900', '(41)99999-7777', 'roberto@email.com', 7, '2024-02-14'),
('Patrícia Souza', '88899900011', '(41)99999-8888', 'patricia@email.com', 10, '2024-03-22');

-- INSERIR PRODUTOS
INSERT INTO PRODUTO (nome, preco, categoria, indicado_ciclistas, disponivel, descricao) VALUES
('Café Expresso', 5.00, 'bebida', FALSE, TRUE, 'Café expresso tradicional 50ml'),
('Café Americano', 6.50, 'bebida', TRUE, TRUE, 'Café expresso diluído em água quente'),
('Cappuccino', 8.00, 'bebida', FALSE, TRUE, 'Café com leite vaporizado e espuma'),
('Cold Brew', 12.00, 'bebida', TRUE, TRUE, 'Café extraído a frio por 12 horas'),
('Suco de Laranja Natural', 9.00, 'bebida', TRUE, TRUE, 'Suco de laranja natural 300ml'),
('Vitamina de Banana', 10.00, 'bebida', TRUE, TRUE, 'Vitamina com banana, aveia e mel'),
('Sanduíche Natural de Frango', 15.50, 'lanche', TRUE, TRUE, 'Pão integral com frango desfiado e salada'),
('Tapioca de Queijo', 12.00, 'lanche', TRUE, TRUE, 'Tapioca recheada com queijo coalho'),
('Wrap Vegetariano', 14.00, 'lanche', TRUE, TRUE, 'Wrap integral com legumes grelhados'),
('Croissant de Presunto e Queijo', 13.50, 'lanche', FALSE, TRUE, 'Croissant artesanal recheado'),
('Barra de Cereal de Castanhas', 6.00, 'snack', TRUE, TRUE, 'Barra energética com castanhas e mel'),
('Mix de Nuts', 8.50, 'snack', TRUE, TRUE, 'Mix de castanhas, amêndoas e nozes'),
('Banana com Pasta de Amendoim', 7.50, 'snack', TRUE, TRUE, 'Banana com pasta de amendoim integral'),
('Cookie de Aveia', 5.50, 'snack', FALSE, TRUE, 'Cookie caseiro de aveia e chocolate'),
('Brownie de Chocolate', 8.00, 'doce', FALSE, TRUE, 'Brownie artesanal de chocolate belga'),
('Brigadeiro Gourmet', 4.50, 'doce', FALSE, TRUE, 'Brigadeiro tradicional gourmet'),
('Pudim de Leite', 9.00, 'doce', FALSE, TRUE, 'Pudim de leite condensado caseiro'),
('Torta de Limão', 10.50, 'doce', FALSE, TRUE, 'Torta de limão siciliano');

-- INSERIR GRUPOS DE CICLISMO
INSERT INTO GRUPO_CICLISMO (nome_grupo, responsavel, contato, data_parceria) VALUES
('Pedal Curitibano', 'André Ferreira', '(41)98888-1111', '2023-11-01'),
('Bike & Café', 'Luciana Rocha', '(41)98888-2222', '2024-01-15'),
('Ciclistas do Parque', 'Marcos Paulo', '(41)98888-3333', '2023-12-10'),
('MTB Aventura', 'Carla Mendes', '(41)98888-4444', '2024-02-20');

-- INSERIR PEDIDOS
INSERT INTO PEDIDO (data_hora, valor_total, tipo_cliente, status, id_cliente, id_funcionario) VALUES
('2024-11-16 07:30:00', 27.50, 'fidelidade', 'entregue', 1, 1),
('2024-11-16 08:15:00', 18.00, 'fidelidade', 'entregue', 2, 1),
('2024-11-16 08:45:00', 45.50, 'fidelidade', 'entregue', 6, 1),
('2024-11-16 09:20:00', 15.50, 'comum', 'entregue', NULL, 1),
('2024-11-16 14:30:00', 32.00, 'fidelidade', 'entregue', 3, 2),
('2024-11-17 07:45:00', 35.00, 'fidelidade', 'entregue', 4, 1),
('2024-11-17 08:30:00', 22.50, 'fidelidade', 'entregue', 5, 1),
('2024-11-17 09:00:00', 28.00, 'fidelidade', 'entregue', 7, 1),
('2024-11-17 15:00:00', 19.50, 'comum', 'entregue', NULL, 2),
('2024-11-17 16:30:00', 41.00, 'fidelidade', 'entregue', 8, 2);

-- INSERIR ITENS DOS PEDIDOS
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade) VALUES
(1, 4, 1), (1, 7, 1), (1, 11, 1),
(2, 3, 1), (2, 14, 1), (2, 16, 1),
(3, 4, 2), (3, 7, 1), (3, 12, 1),
(4, 7, 1),
(5, 4, 1), (5, 9, 1), (5, 11, 1),
(6, 6, 1), (6, 8, 1), (6, 12, 1),
(7, 2, 1), (7, 10, 1), (7, 14, 1),
(8, 4, 1), (8, 7, 1), (8, 16, 1),
(9, 5, 1), (9, 10, 1), (9, 16, 1),
(10, 4, 2), (10, 7, 1), (10, 11, 1), (10, 12, 1);

-- INSERIR PAGAMENTOS
INSERT INTO PAGAMENTO (id_pedido, forma_pagamento, valor, data_hora) VALUES
(1, 'PIX', 27.50, '2024-11-16 07:31:00'),
(2, 'cartão débito', 18.00, '2024-11-16 08:16:00'),
(3, 'PIX', 45.50, '2024-11-16 08:46:00'),
(4, 'dinheiro', 15.50, '2024-11-16 09:21:00'),
(5, 'PIX', 32.00, '2024-11-16 14:31:00'),
(6, 'contactless', 35.00, '2024-11-17 07:46:00'),
(7, 'PIX', 22.50, '2024-11-17 08:31:00'),
(8, 'cartão crédito', 28.00, '2024-11-17 09:01:00'),
(9, 'dinheiro', 19.50, '2024-11-17 15:01:00'),
(10, 'PIX', 41.00, '2024-11-17 16:31:00');

-- INSERIR RESGATES
INSERT INTO RESGATE (id_cliente, data_resgate, tipo_premio, carimbos_utilizados) VALUES
(2, '2024-11-10 10:30:00', 'Café Americano Grátis', 10),
(4, '2024-11-12 14:15:00', 'Café Grande Grátis', 15),
(6, '2024-11-15 09:00:00', 'Desconto 50% em Bebida', 20),
(7, '2024-11-17 11:30:00', 'Cookie Grátis', 5);

-- VINCULAR CLIENTES A GRUPOS
INSERT INTO CLIENTE_GRUPO (id_cliente, id_grupo, data_adesao) VALUES
(1, 1, '2024-01-20'),
(1, 2, '2024-02-15'),
(2, 1, '2024-02-25'),
(3, 3, '2024-03-15'),
(4, 2, '2024-02-01'),
(5, 4, '2024-04-10'),
(6, 1, '2024-01-05'),
(6, 3, '2024-01-20'),
(7, 2, '2024-02-20'),
(8, 4, '2024-03-25');

-- CONFIRMAÇÃO
SELECT 'Dados inseridos com sucesso!' AS status;
SELECT 'FUNCIONARIO' AS tabela, COUNT(*) AS registros FROM FUNCIONARIO
UNION ALL SELECT 'CLIENTE_FIDELIDADE', COUNT(*) FROM CLIENTE_FIDELIDADE
UNION ALL SELECT 'PRODUTO', COUNT(*) FROM PRODUTO
UNION ALL SELECT 'PEDIDO', COUNT(*) FROM PEDIDO;