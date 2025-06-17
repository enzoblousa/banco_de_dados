create database prova1;
-- CONSULTA
-- 1. Liste o nome de cada projeto. Para cada projeto, conte quantas tarefas existem para cada nível de `prioridade` ('Baixa', 'Normal', 'Alta', 'Urgente').
SELECT 
    p.nome AS nome_projeto,
    SUM(CASE WHEN t.prioridade = 'Baixa' THEN 1 ELSE 0 END) AS baixa,
    SUM(CASE WHEN t.prioridade = 'Normal' THEN 1 ELSE 0 END) AS normal,
    SUM(CASE WHEN t.prioridade = 'Alta' THEN 1 ELSE 0 END) AS alta,
    SUM(CASE WHEN t.prioridade = 'Urgente' THEN 1 ELSE 0 END) AS urgente
FROM 
    Projetos p
LEFT JOIN 
    Tarefas t ON p.id = t.id_projeto
GROUP BY 
    p.nome
ORDER BY 
    p.nome;

-- 2. Mostre o nome dos responsáveis e a quantidade de tarefas pelas quais eles são responsáveis (id_responsavel_tarefa). Liste apenas os responsáveis que têm 3 ou mais tarefas atribuídas.
SELECT 
    r.nome,
    COUNT(t.id) AS quantidade_tarefas
FROM 
    Responsaveis r
JOIN 
    Tarefas t ON r.id = t.id_responsavel_tarefa
GROUP BY 
    r.nome
HAVING 
    COUNT(t.id) >= 3
ORDER BY 
    quantidade_tarefas DESC;

-- 3. Calcule a "duração percebida" média das tarefas (em dias) para projetos, agrupados pelo status do projeto.
SELECT 
    p.status,
    ROUND(AVG(DATEDIFF(t.data_prevista_entrega, p.data_inicio)), 2) AS duracao_percebida_media
FROM 
    Projetos p
JOIN 
    Tarefas t ON p.id = t.id_projeto
WHERE 
    t.data_prevista_entrega IS NOT NULL 
    AND p.data_inicio IS NOT NULL
GROUP BY 
    p.status;

-- 4. Para cada projeto 'Em Andamento', liste o nome do projeto, cargo dos responsáveis e número de tarefas por cargo.
SELECT 
    p.nome AS nome_projeto,
    r.cargo,
    COUNT(t.id) AS quantidade_tarefas
FROM 
    Projetos p
JOIN 
    Tarefas t ON p.id = t.id_projeto
JOIN 
    Responsaveis r ON t.id_responsavel_tarefa = r.id
WHERE 
    p.status = 'Em Andamento'
GROUP BY 
    p.nome, r.cargo
HAVING 
    COUNT(t.id) > 0
ORDER BY 
    p.nome, r.cargo;

-- 5. Gere um ranking com os Top 5 projetos com mais tarefas em atraso.
SELECT 
    p.nome AS nome_projeto,
    COUNT(t.id) AS tarefas_atrasadas
FROM 
    Projetos p
JOIN 
    Tarefas t ON p.id = t.id_projeto
WHERE 
    t.status != 'Concluída'
    AND t.data_prevista_entrega < CURDATE()
GROUP BY 
    p.nome
ORDER BY 
    tarefas_atrasadas DESC
LIMIT 5;

-- 6. Verifique quais as Tarefas são urgentes/altas e não concluídas
SELECT 
    t.titulo,
    t.prioridade,
    t.status,
    p.nome AS nome_projeto,
    r.nome AS responsavel_tarefa
FROM 
    Tarefas t
JOIN 
    Projetos p ON t.id_projeto = p.id
JOIN 
    Responsaveis r ON t.id_responsavel_tarefa = r.id
WHERE 
    t.prioridade IN ('Alta', 'Urgente')
    AND t.status != 'Concluída'
ORDER BY 
    t.prioridade DESC, t.status;

-- 7. Listar projetos com uma ou mais tarefas com status 'Pendente'
SELECT 
    p.nome AS nome_projeto,
    COUNT(t.id) AS tarefas_pendentes
FROM 
    Projetos p
JOIN 
    Tarefas t ON p.id = t.id_projeto
WHERE 
    t.status = 'Pendente'
GROUP BY 
    p.nome
HAVING 
    COUNT(t.id) >= 1
ORDER BY 
    p.nome;