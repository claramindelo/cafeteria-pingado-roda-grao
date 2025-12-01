-- ========================================
-- SISTEMA DE GESTÃO CAFETERIA "PINGADO – RODA E GRÃO"
-- Script de Atualização e Exclusão (UPDATE e DELETE)
-- ========================================

USE pingado_roda_grao;

-- ========================================
-- COMANDOS UPDATE
-- ========================================

-- UPDATE 1: Atualizar preços dos produtos da categoria bebida
SELECT 'ANTES DO UPDATE - Preços das Bebidas:' AS info;
SELECT id_produto, nome, preco, categoria 
FROM PRODUTO 
WHERE categoria = 'bebida';

UPDATE PRODUTO
SET preco = preco * 1.10
WHERE categoria = 'bebida';

SELECT 'APÓS UPDATE - Preços das Bebidas Reajustados:' AS info;
SELECT id_produto, nome, preco, categoria 
FROM PRODUTO 
WHERE categoria = 'bebida';

-- UPDATE 2: Atualizar status dos pedidos antigos para 'entregue'
SELECT 'ANTES DO UPDATE - Status dos Pedidos:' AS info;
SELECT id_pedido, DATE_FORMAT(data_hora, '%d/%m/%Y %H:%i') AS data_hora, status 
FROM PEDIDO 
WHERE status IN ('em preparo', 'pronto')
ORDER BY data_hora;

UPDATE PEDIDO
SET status = 'entregue'
WHERE status IN ('em preparo', 'pronto')
  AND data_hora < DATE_SUB(NOW(), INTERVAL 1 DAY);

SELECT 'APÓS UPDATE - Pedidos Atualizados:' AS info;
SELECT id_pedido, DATE_FORMAT(data_hora, '%d/%m/%Y %H:%i') AS data_hora, status 
FROM PEDIDO 
WHERE data_hora < DATE_SUB(NOW(), INTERVAL 1 DAY)
ORDER BY data_hora;

-- UPDATE 3: Atualizar carimbos acumulados dos clientes após novos pedidos
SELECT 'ANTES DO UPDATE - Carimbos do Cliente José:' AS info;
SELECT id_cliente, nome, carimbos_acumulados 
FROM CLIENTE_FIDELIDADE 
WHERE id_cliente = 1;

UPDATE CLIENTE_FIDELIDADE
SET carimbos_acumulados = carimbos_acumulados + 2
WHERE id_cliente = 1;

SELECT 'APÓS UPDATE - Carimbos Atualizados:' AS info;
SELECT id_cliente, nome, carimbos_acumulados 
FROM CLIENTE_FIDELIDADE 
WHERE id_cliente = 1;

-- ========================================
-- COMANDOS DELETE
-- ========================================

-- DELETE 1: Remover pedidos de teste/cancelados
SELECT 'ANTES DO DELETE - Total de pedidos:' AS info;
SELECT COUNT(*) AS total_pedidos FROM PEDIDO;

-- Inserir um pedido de teste para demonstrar a exclusão
INSERT INTO PEDIDO (data_hora, valor_total, tipo_cliente, status, id_cliente, id_funcionario) 
VALUES ('2024-11-20 10:00:00', 0.00, 'comum', 'em preparo', NULL, 1);

SELECT 'Pedido de teste criado com valor zero' AS info;

-- Deletar o pedido de teste
DELETE FROM PEDIDO
WHERE valor_total = 0.00 
  AND status = 'em preparo';

SELECT 'APÓS DELETE - Pedidos de valor zero removidos:' AS info;
SELECT COUNT(*) AS total_pedidos FROM PEDIDO;

-- DELETE 2: Remover cliente que solicitou exclusão de cadastro
-- Criar um cliente de teste para demonstrar
INSERT INTO CLIENTE_FIDELIDADE (nome, cpf, telefone, email, carimbos_acumulados, data_cadastro)
VALUES ('Cliente Teste Exclusão', '99999999999', '(41)99999-9999', 'teste@exclusao.com', 0, '2024-11-20');

SELECT 'ANTES DO DELETE - Cliente de teste criado:' AS info;
SELECT id_cliente, nome FROM CLIENTE_FIDELIDADE WHERE cpf = '99999999999';

-- Deletar o cliente de teste (sem pedidos associados)
DELETE FROM CLIENTE_FIDELIDADE
WHERE cpf = '99999999999'
  AND id_cliente NOT IN (SELECT DISTINCT id_cliente FROM PEDIDO WHERE id_cliente IS NOT NULL);

SELECT 'APÓS DELETE - Cliente sem pedidos removido:' AS info;
SELECT COUNT(*) AS total_clientes FROM CLIENTE_FIDELIDADE;

-- DELETE 3: Remover resgates muito antigos (mais de 1 ano)
SELECT 'ANTES DO DELETE - Total de resgates:' AS info;
SELECT COUNT(*) AS total_resgates FROM RESGATE;

-- Inserir um resgate antigo para demonstração
INSERT INTO RESGATE (id_cliente, data_resgate, tipo_premio, carimbos_utilizados)
VALUES (1, '2022-10-15 14:00:00', 'Café Grátis (Histórico)', 10);

SELECT 'Resgate antigo inserido para teste' AS info;

DELETE FROM RESGATE
WHERE data_resgate < DATE_SUB(NOW(), INTERVAL 1 YEAR);

SELECT 'APÓS DELETE - Resgates antigos removidos:' AS info;
SELECT COUNT(*) AS total_resgates FROM RESGATE;

-- ========================================
-- RELATÓRIO FINAL
-- ========================================
SELECT '========== RESUMO FINAL DO BANCO DE DADOS ==========' AS titulo;
SELECT 'FUNCIONARIO' AS tabela, COUNT(*) AS total_registros FROM FUNCIONARIO
UNION ALL SELECT 'CLIENTE_FIDELIDADE', COUNT(*) FROM CLIENTE_FIDELIDADE
UNION ALL SELECT 'PRODUTO', COUNT(*) FROM PRODUTO
UNION ALL SELECT 'GRUPO_CICLISMO', COUNT(*) FROM GRUPO_CICLISMO
UNION ALL SELECT 'PEDIDO', COUNT(*) FROM PEDIDO
UNION ALL SELECT 'ITEM_PEDIDO', COUNT(*) FROM ITEM_PEDIDO
UNION ALL SELECT 'PAGAMENTO', COUNT(*) FROM PAGAMENTO
UNION ALL SELECT 'RESGATE', COUNT(*) FROM RESGATE
UNION ALL SELECT 'CLIENTE_GRUPO', COUNT(*) FROM CLIENTE_GRUPO;