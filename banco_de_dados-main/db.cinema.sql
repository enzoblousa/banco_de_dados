create database cinema;
use cinema;

CREATE TABLE directors(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  age INTEGER NOT NULL
);

INSERT INTO directors(name, age) VALUES
('John Smith',20),
('Jane Doe',30),
('Xavier Wills',30),
('Bev Scott',15),
('Bree Jensen',90);

CREATE TABLE movies(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  director_id INTEGER REFERENCES directors 
);

INSERT INTO movies(name, director_id) VALUES
('Movie 1', 1),
('Movie 2', 1),
('Movie 3', 2),
('Movie 4', NULL),
('Movie 5', NULL);

CREATE TABLE tickets(
  id SERIAL PRIMARY KEY,
  movie_id INTEGER REFERENCES movies
);
INSERT INTO tickets(movie_id) VALUES (1), (1), (3);

-- Produto cartesiano (Cross Join)
SELECT *
FROM movies as m, directors as d;

-- Junção natural
SELECT *
FROM movies as m, directors as d
WHERE d.id = m.director_id;

-- EXERCICIO 1 Liste todos os diretores e os filmes que eles dirigiram
SELECT *
FROM movies as m JOIN directors as d
	ON d.id = m.director_id;

-- EXERCICCIO 2 Liste todos os filmes e seus tickets vendidos
SELECT *
FROM movies as m JOIN tickets as t 
	ON m.id = t.movie_id;
    
-- EXERCICIO 3 Liste todos os filmes, seus diretores e os tickets vendidos
SELECT *
FROM movies as m JOIN directors as d
	ON d.id = m.director_id
    JOIN tickets as t ON m.id = t.movie_id;