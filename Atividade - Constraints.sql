-- Criação do banco de dados
CREATE DATABASE lojaEsportiva;

-- Selecionar o banco de dados
USE lojaEsportiva;

-- Criação da tabela de categorias
CREATE TABLE Categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- Inserção das categorias
INSERT INTO Categoria (nome) VALUES
('Roupas Esportivas'),
('Equipamentos de Futebol'),
('Acessórios de Treino');

-- Criação da tabela de produtos
CREATE TABLE Produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL CHECK (preco > 0),
    quantidade_em_estoque INT NOT NULL CHECK (quantidade_em_estoque >= 0),
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES Categoria(id)
);

-- Inserção dos produtos
INSERT INTO Produto (nome, preco, quantidade_em_estoque, categoria_id) VALUES
('Camisa de Futebol', 89.90, 100, 2),
('Tênis de Corrida', 299.99, 50, 1),
('Faixa de Cabeça', 25.00, 200, 3);

-- Consultas solicitadas

-- 1. Consultar todos os produtos com suas categorias
SELECT Produto.nome, Produto.preco, Produto.quantidade_em_estoque, Categoria.nome AS categoria
FROM Produto
JOIN Categoria ON Produto.categoria_id = Categoria.id;

-- 2. Consultar todos os produtos de uma categoria específica (por exemplo, 'Equipamentos de Futebol')
SELECT Produto.nome, Produto.preco, Produto.quantidade_em_estoque
FROM Produto
JOIN Categoria ON Produto.categoria_id = Categoria.id
WHERE Categoria.nome = 'Equipamentos de Futebol';

-- 3. Consultar categorias que têm mais de 50 produtos em estoque
SELECT Categoria.nome
FROM Categoria
JOIN Produto ON Categoria.id = Produto.categoria_id
GROUP BY Categoria.nome
HAVING SUM(Produto.quantidade_em_estoque) > 50;

-- 4. Alterar o preço de um produto específico (por exemplo, 'Tênis de Corrida') para um novo valor (por exemplo, 279.99)
UPDATE Produto
SET preco = 279.99
WHERE nome = 'Tênis de Corrida';

-- 5. Adicionar uma nova categoria e atualizar um produto para essa nova categoria
INSERT INTO Categoria (nome) VALUES ('Novos Acessórios');
UPDATE Produto
SET categoria_id = (SELECT id FROM Categoria WHERE nome = 'Novos Acessórios')
WHERE nome = 'Faixa de Cabeça';

-- 6. Excluir um produto específico (por exemplo, 'Faixa de Cabeça')
DELETE FROM Produto
WHERE nome = 'Faixa de Cabeça';
