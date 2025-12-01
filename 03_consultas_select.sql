-- ========================================
-- SISTEMA DE GESTÃO CAFETERIA "PINGADO – RODA E GRÃO"
-- Script de Consultas (SELECT)
-- ========================================

USE pingado_roda_grao;

-- ========================================
-- CONSULTA 1: Produtos mais vendidos para ciclistas
-- ========================================
SELECT 
    p.nome AS produto,
    p.categoria,
    p.preco,
    SUM(ip.quantidade) AS quantidade_vendida,
    SUM(ip.quantidade * p.preco) AS faturamento_total
FROM PRODUTO p
INNER JOIN ITEM_PEDIDO ip ON p.id_produto = ip.id_produto
WHERE p.indicado_ciclistas = TRUE
GROUP BY p.id_produto, p.nome, p.categoria, p.preco
ORDER BY quantidade_vendida DESC
LIMIT 5;

-- ========================================
-- CONSULTA 2: Relatório de vendas por funcionário
-- ========================================
SELECT 
    f.nome AS funcionario,
    f.cargo,
    f.turno,
    COUNT(ped.id_pedido) AS total_pedidos,
    SUM(ped.valor_total) AS faturamento_total,
    AVG(ped.valor_total) AS ticket_medio,
    DATE_FORMAT(MIN(ped.data_hora), '%d/%m/%Y') AS primeira_venda,
    DATE_FORMAT(MAX(ped.data_hora), '%d/%m/%Y') AS ultima_venda
FROM FUNCIONARIO f
INNER JOIN PEDIDO ped ON f.id_funcionario = ped.id_funcionario
GROUP BY f.id_funcionario, f.nome, f.cargo, f.turno
ORDER BY faturamento_total DESC;

-- ========================================
-- CONSULTA 3: Clientes do programa fidelidade mais ativos
-- ========================================
SELECT 
    cf.nome AS cliente,
    cf.carimbos_acumulados,
    COUNT(DISTINCT ped.id_pedido) AS total_pedidos,
    SUM(ped.valor_total) AS valor_total_gasto,
    GROUP_CONCAT(DISTINCT gc.nome_grupo SEPARATOR ', ') AS grupos_ciclismo,
    DATEDIFF(CURDATE(), cf.data_cadastro) AS dias_desde_cadastro
FROM CLIENTE_FIDELIDADE cf
LEFT JOIN PEDIDO ped ON cf.id_cliente = ped.id_cliente
LEFT JOIN CLIENTE_GRUPO cg ON cf.id_cliente = cg.id_cliente
LEFT JOIN GRUPO_CICLISMO gc ON cg.id_grupo = gc.id_grupo
GROUP BY cf.id_cliente, cf.nome, cf.carimbos_acumulados, cf.data_cadastro
HAVING total_pedidos > 0
ORDER BY total_pedidos DESC, valor_total_gasto DESC
LIMIT 10;

-- ========================================
-- CONSULTA 4: Análise de formas de pagamento
-- ========================================
SELECT 
    pag.forma_pagamento,
    COUNT(*) AS quantidade_transacoes,
    SUM(pag.valor) AS valor_total,
    AVG(pag.valor) AS ticket_medio,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM PAGAMENTO)), 2) AS percentual_uso
FROM PAGAMENTO pag
GROUP BY pag.forma_pagamento
ORDER BY quantidade_transacoes DESC;

-- ========================================
-- CONSULTA 5: Detalhamento completo de pedidos com itens
-- ========================================
SELECT 
    ped.id_pedido,
    DATE_FORMAT(ped.data_hora, '%d/%m/%Y %H:%i') AS data_hora,
    COALESCE(cf.nome, 'Cliente Não Cadastrado') AS cliente,
    f.nome AS atendente,
    prod.nome AS produto,
    ip.quantidade,
    prod.preco AS preco_unitario,
    (ip.quantidade * prod.preco) AS subtotal,
    ped.valor_total AS total_pedido,
    pag.forma_pagamento,
    ped.status
FROM PEDIDO ped
INNER JOIN FUNCIONARIO f ON ped.id_funcionario = f.id_funcionario
INNER JOIN ITEM_PEDIDO ip ON ped.id_pedido = ip.id_pedido
INNER JOIN PRODUTO prod ON ip.id_produto = prod.id_produto
INNER JOIN PAGAMENTO pag ON ped.id_pedido = pag.id_pedido
LEFT JOIN CLIENTE_FIDELIDADE cf ON ped.id_cliente = cf.id_cliente
WHERE ped.data_hora >= '2024-11-16'
ORDER BY ped.data_hora DESC, ped.id_pedido, ip.id_item
LIMIT 50;