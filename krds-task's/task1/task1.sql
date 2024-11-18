-- Создание таблицы 'A'
CREATE TABLE A (
    B VARCHAR(10),
    C VARCHAR(10),
    D VARCHAR(10)
);

-- Вставка данных в таблицу 'A'
INSERT INTO a (b, c, d) VALUES ('Иван', 'Иванов', '1234');
INSERT INTO a (b, c, d) VALUES ('Мария', 'Петрова', '5678');
INSERT INTO a (b, c, d) VALUES ('Дмитрий', 'Лебедев', '5566');
INSERT INTO a (b, c, d) VALUES ('Алексей', 'Смирнов', '9876');
INSERT INTO a (b, c, d) VALUES ('Сергей', 'Кузнецов', '1122');
INSERT INTO a (b, c, d) VALUES ('Елена', 'Ковалёва', '3344');
INSERT INTO a (b, c, d) VALUES ('Иван', 'Иванов', '1234');      -- Дубликат
INSERT INTO a (b, c, d) VALUES ('Иван', 'Иванов', '1234');      -- Дубликат
INSERT INTO a (b, c, d) VALUES ('Алексей', 'Смирнов', '9876');  -- Дубликат
INSERT INTO a (b, c, d) VALUES ('Сергей', 'Кузнецов', '1122');  -- Дубликат

-- Ожидаемый результат:
-- Иван Иванов 1234
-- Мария Петрова 5678
-- Алексей Смирнов 9876
-- Сергей Кузнецов 1122
-- Елена Ковалева 3344
-- Дмитрий Лебедев 5566

-- Запрос на удаление в таблице дублей (повторений всех трех колонок)
DELETE FROM a
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM a
    GROUP BY b, c, d
);