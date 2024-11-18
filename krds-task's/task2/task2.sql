-- Создание таблицы 'B'
CREATE TABLE B (
    D VARCHAR(10),
    C VARCHAR(10),
    E VARCHAR(10)
);

-- Вставка данных в таблицу 'B'
insert into b (d, c, e) values ('Иван', 'Иванов', '1234');
insert into b (d, c, e) values ('Иван', 'Петров', '5679');
insert into b (d, c, e) values ('Алексей', 'Алексеев', '9221');
insert into b (d, c, e) values ('Дмитрий', 'Медведев', '9101');
insert into b (d, c, e) values ('Евгений', 'Евгеньев', '3344');
insert into b (d, c, e) values ('Егор', 'Лебедев', '3344');

-- Ожидаемый результат:
-- Петрова
-- Петров
-- Смирнов
-- Алексеев
-- Кузнецов
-- Медведев
-- Ковалёва
-- Евгеньев

-- Запрос на выборку непересекающегося множества значений колонки C из таблиц А и B 
SELECT C
FROM A
WHERE C NOT IN (SELECT C FROM B)
UNION
SELECT C
FROM B
WHERE C NOT IN (SELECT C FROM A)
ORDER BY C;