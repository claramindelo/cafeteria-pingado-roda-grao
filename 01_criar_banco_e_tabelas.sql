-- ========================================
-- SISTEMA DE GESTÃO CAFETERIA "PINGADO – RODA E GRÃO"
-- Script de Criação do Banco de Dados e Tabelas (DDL)
-- ========================================

CREATE DATABASE IF NOT EXISTS pingado_roda_grao;
USE pingado_roda_grao;

-- TABELA: FUNCIONARIO
CREATE TABLE FUNCIONARIO (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(15),
    cargo ENUM('barista', 'gerente') NOT NULL,
    turno ENUM('manhã', 'tarde', 'noite') NOT NULL
);

-- TABELA: CLIENTE_FIDELIDADE
CREATE TABLE CLIENTE_FIDELIDADE (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(15),
    email VARCHAR(100),
    carimbos_acumulados INT DEFAULT 0,
    data_cadastro DATE NOT NULL
);

-- TABELA: PRODUTO
CREATE TABLE PRODUTO (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    categoria ENUM('bebida', 'lanche', 'snack', 'doce') NOT NULL,
    indicado_ciclistas BOOLEAN DEFAULT FALSE,
    disponivel BOOLEAN DEFAULT TRUE,
    descricao TEXT
);

-- TABELA: GRUPO_CICLISMO
CREATE TABLE GRUPO_CICLISMO (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
    nome_grupo VARCHAR(100) NOT NULL,
    responsavel VARCHAR(100),
    contato VARCHAR(100),
    data_parceria DATE NOT NULL
);

-- TABELA: PEDIDO
CREATE TABLE PEDIDO (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    tipo_cliente ENUM('comum', 'fidelidade', 'ciclista') NOT NULL,
    status ENUM('em preparo', 'pronto', 'entregue') DEFAULT 'em preparo',
    id_cliente INT,
    id_funcionario INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE_FIDELIDADE(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO(id_funcionario)
);

-- TABELA: ITEM_PEDIDO
CREATE TABLE ITEM_PEDIDO (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES PRODUTO(id_produto)
);

-- TABELA: PAGAMENTO
CREATE TABLE PAGAMENTO (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL UNIQUE,
    forma_pagamento ENUM('dinheiro', 'cartão débito', 'cartão crédito', 'PIX', 'contactless') NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data_hora DATETIME NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido) ON DELETE CASCADE
);

-- TABELA: RESGATE
CREATE TABLE RESGATE (
    id_resgate INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_resgate DATETIME NOT NULL,
    tipo_premio VARCHAR(100) NOT NULL,
    carimbos_utilizados INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE_FIDELIDADE(id_cliente)
);

-- TABELA: CLIENTE_GRUPO
CREATE TABLE CLIENTE_GRUPO (
    id_cliente INT NOT NULL,
    id_grupo INT NOT NULL,
    data_adesao DATE NOT NULL,
    PRIMARY KEY (id_cliente, id_grupo),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE_FIDELIDADE(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_grupo) REFERENCES GRUPO_CICLISMO(id_grupo) ON DELETE CASCADE
);

SELECT 'Banco de dados e tabelas criados com sucesso!' AS status;