# 🚴☕ Sistema de Gestão - Cafeteria "Pingado – Roda e Grão"

## 📋 Descrição do Projeto

Sistema de banco de dados relacional desenvolvido para gerenciar as operações da cafeteria "Pingado – Roda e Grão", um quiosque especializado em atender ciclistas e entusiastas de café, localizado próximo a ciclovias e áreas de lazer urbanas.

### 🎯 Objetivos do Sistema

- Gerenciar cadastro de produtos e controlar estoque
- Registrar e processar pedidos "to-go"
- Administrar programa de fidelidade com sistema de carimbos
- Controlar transações e formas de pagamento
- Gerenciar funcionários e escalas de trabalho
- Estabelecer parcerias com grupos de ciclismo
- Gerar relatórios gerenciais para tomada de decisão

---

## 🗂️ Estrutura do Banco de Dados

### Entidades Principais

1. **CLIENTE_FIDELIDADE** - Clientes cadastrados no programa de fidelidade
2. **PEDIDO** - Registro de vendas realizadas
3. **PRODUTO** - Catálogo de bebidas, lanches, snacks e doces
4. **ITEM_PEDIDO** - Itens individuais de cada pedido
5. **PAGAMENTO** - Transações financeiras
6. **FUNCIONARIO** - Baristas e gerentes
7. **GRUPO_CICLISMO** - Grupos parceiros de ciclismo
8. **CLIENTE_GRUPO** - Relacionamento entre clientes e grupos
9. **RESGATE** - Histórico de resgates do programa fidelidade

### 🔗 Relacionamentos

- Cliente **realiza** múltiplos Pedidos (1:N)
- Pedido **contém** múltiplos Itens (1:N)
- Produto **aparece em** múltiplos Itens de Pedido (1:N)
- Pedido **possui** um Pagamento (1:1)
- Funcionário **atende** múltiplos Pedidos (1:N)
- Cliente **resgata** múltiplos prêmios (1:N)
- Cliente **pertence a** múltiplos Grupos (N:N)

---

## 📦 Arquivos do Projeto

### 1️⃣ `01_criar_banco_e_tabelas.sql`
**Descrição:** Script DDL completo para criação do banco de dados e todas as tabelas.

**Conteúdo:**
- Criação do banco de dados `pingado_roda_grao`
- Definição de 9 tabelas normalizadas (1FN, 2FN, 3FN)
- Chaves primárias e estrangeiras
- Restrições de integridade referencial

---

### 2️⃣ `02_inserir_dados.sql`
**Descrição:** Script DML para popular o banco com dados de exemplo.

**Dados inseridos:**
- 5 funcionários
- 8 clientes fidelidade
- 18 produtos
- 4 grupos de ciclismo
- 10 pedidos completos
- 10 pagamentos
- 4 resgates

---

### 3️⃣ `03_consultas_select.sql`
**Descrição:** Consultas analíticas para extrair informações estratégicas.

**Consultas implementadas:**

1. **Produtos mais vendidos para ciclistas**
   - Usa: JOIN, WHERE, GROUP BY, ORDER BY, LIMIT
   
2. **Relatório de vendas por funcionário**
   - Usa: JOIN, agregações (COUNT, SUM, AVG)
   
3. **Clientes mais ativos do programa fidelidade**
   - Usa: múltiplos LEFT JOIN, GROUP_CONCAT, HAVING
   
4. **Análise de formas de pagamento**
   - Usa: GROUP BY, cálculos percentuais
   
5. **Detalhamento completo de pedidos**
   - Usa: múltiplos INNER JOIN, COALESCE, DATE_FORMAT

---

### 4️⃣ `04_update_e_delete.sql`
**Descrição:** Script com operações de atualização e exclusão de dados.

**Operações UPDATE:**
1. Reajuste de preços das bebidas (10%)
2. Atualização de status de pedidos antigos
3. Atualização de carimbos acumulados

**Operações DELETE:**
1. Remover pedidos de teste/cancelados
2. Remover cliente inativo (LGPD)
3. Limpeza de resgates antigos

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
- MySQL 8.0 ou superior instalado
- MySQL Workbench ou MySQL Command Line Client

### Passo a Passo

1. **Abra o MySQL** e conecte ao servidor

2. **Execute os scripts na ordem:**
```bash
# Passo 1: Criar estrutura
mysql> source caminho/01_criar_banco_e_tabelas.sql;

# Passo 2: Inserir dados
mysql> source caminho/02_inserir_dados.sql;

# Passo 3: Executar consultas
mysql> source caminho/03_consultas_select.sql;

# Passo 4: Testar UPDATE e DELETE
mysql> source caminho/04_update_e_delete.sql;
```

**Ou copie e cole** o conteúdo de cada arquivo diretamente no MySQL.

---

## 🎓 Conceitos Aplicados

### ✅ Normalização
- **1FN:** Todos os atributos são atômicos
- **2FN:** Atributos dependem completamente da chave primária
- **3FN:** Sem dependências transitivas

### ✅ Integridade Referencial
- Chaves primárias em todas as tabelas
- Chaves estrangeiras com relacionamentos corretos
- ON DELETE CASCADE onde apropriado
- Constraints UNIQUE para CPF

### ✅ Tipos de Dados
- `INT AUTO_INCREMENT` para chaves primárias
- `DECIMAL(10,2)` para valores monetários
- `DATETIME` para timestamps
- `ENUM` para valores pré-definidos
- `VARCHAR` para textos variáveis

### ✅ Comandos SQL Utilizados
- **DDL:** CREATE DATABASE, CREATE TABLE, PRIMARY KEY, FOREIGN KEY
- **DML:** INSERT, SELECT, UPDATE, DELETE
- **Funções:** COUNT(), SUM(), AVG(), GROUP_CONCAT(), DATE_FORMAT()
- **Cláusulas:** WHERE, GROUP BY, HAVING, ORDER BY, LIMIT, JOIN

---

## 📊 Exemplos de Uso

### Consultar produtos mais vendidos
```sql
SELECT nome, SUM(quantidade) AS total_vendido
FROM PRODUTO p
JOIN ITEM_PEDIDO ip ON p.id_produto = ip.id_produto
GROUP BY p.id_produto
ORDER BY total_vendido DESC
LIMIT 5;
```

### Ver clientes com mais carimbos
```sql
SELECT nome, carimbos_acumulados
FROM CLIENTE_FIDELIDADE
ORDER BY carimbos_acumulados DESC;
```

---

## 👥 Informações Acadêmicas

**Disciplina:** Modelagem de Banco de Dados  
**Projeto:** Experiência Prática IV  
**Instituição:** Faculdade Positivo  
**Período:** 2025/2

---

## 📝 Sobre o Projeto

Este projeto foi desenvolvido como parte das atividades práticas da disciplina de Banco de Dados, abordando todos os conceitos de modelagem relacional, normalização, SQL e boas práticas de desenvolvimento de banco de dados.

---

**Desenvolvido com ☕ e 🚴 para ciclistas que amam café!**
```

Deve ser algo como:
```
https://github.com/SEU_USUARIO/cafeteria-pingado-roda-grao
