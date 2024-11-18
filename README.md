# krds-task's

## Задание 1
Есть таблица A с тремя колонками B, C, D. Типы колонок — varchar2(10). В таблице нет никаких индексов, констрейнтов. Необходимо написать наиболее оптимизированный скрипт удаления в таблице дублей (повторений всех трех колонок). Результат удаления скрипта — в таблице должны остаться только неповторяющиеся записи.

### Реализация
**1. Создание таблицы `A`:**
```SQL
CREATE TABLE A (
    B VARCHAR(10),
    C VARCHAR(10),
    D VARCHAR(10)
);
```

**2. Вставка произвольных данных в таблицу `A`:**
```SQL
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
```
⠀
<div align="center">
    <strong>Рисунок 1 - Результат шагов 1-2</strong>
</div>
<p align="center">
    <img width="762" alt="1" src="https://github.com/user-attachments/assets/4404b80a-e266-4778-9f61-626ab16e94b6">
</p>

**3. Написание запроса - запрос на удаление в таблице дублей (повторений всех трех колонок):**
```SQL
DELETE FROM a
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM a
    GROUP BY b, c, d
);
```

**4. Написание js-скрипта:**
```javascript
const { Pool } = require('pg');

(async () => {
    const pool = new Pool({
        host: 'localhost',
        user: 'root',
        password: 'password',
        database: 'task1',
        port: 5432,
    });

    try {
        console.log('Подключение установлено.');

        const deleteDuplicates = `
            DELETE FROM a
            WHERE ctid NOT IN (
                SELECT MIN(ctid)
                FROM a
                GROUP BY b, c, d
            );
        `;

        const result = await pool.query(deleteDuplicates);
        console.log(`Дубли удалены. Количество удаленных строк: ${result.rowCount}`);
    } catch (error) {
        console.error('Ошибка при выполнении операции:', error.message);
    } finally {
        await pool.end();
        console.log('Соединение закрыто.');
    }
})();
```

**Тестирование шагов 3-4. Работа программы и результат ее работы представлен на рисунках 2-3.**

```text
Ожидаемый результат работы программы:
Иван Иванов 1234
Мария Петрова 5678
Алексей Смирнов 9876
Сергей Кузнецов 1122
Елена Ковалева 3344
Дмитрий Лебедев 5566
```

⠀

<div align="center">
    <strong>Рисунок 2 - Работа программы</strong>
</div>
<p align="center">
    <img width="762" alt="2" src="https://github.com/user-attachments/assets/7590f2b1-39e2-4633-ad71-49cad37ee858">
</p>

<div align="center">
    <strong>Рисунок 3 - Результат работы программы</strong>
</div>
<p align="center">
    <img width="762" alt="3" src="https://github.com/user-attachments/assets/8965d167-8d34-45e4-9f28-c4c33ec2d2b6">
</p>

---

## Задание 2
Есть две таблицы A и B. В каждой таблице есть колонка C. Составьте запрос так, чтобы результатом запроса стала выборка непересекающегося множества значений колонки C из таблиц A и B.

### Реализация
**1. Создание таблицы `B`:**
```SQL
CREATE TABLE B (
    D VARCHAR(10),
    C VARCHAR(10),
    E VARCHAR(10)
);
```

**2. Вставка произвольных данных в таблицу `B`:**
```SQL
insert into b (d, c, e) values ('Иван', 'Иванов', '1234');
insert into b (d, c, e) values ('Иван', 'Петров', '5679');
insert into b (d, c, e) values ('Алексей', 'Алексеев', '9221');
insert into b (d, c, e) values ('Дмитрий', 'Медведев', '9101');
insert into b (d, c, e) values ('Евгений', 'Евгеньев', '3344');
insert into b (d, c, e) values ('Егор', 'Лебедев', '3344');
```
⠀
<div align="center">
    <strong>Рисунок 4 - Результат шагов 1-2</strong>
</div>
⠀
<p align="center">
    <img width="1001" alt="1" src="https://github.com/user-attachments/assets/ccf071e0-b044-4976-8332-c3ef1931b919">
</p>

**3. Написание запроса - запрос на выборку непрекасающегося множества значений колонки `C` из таблиц `A` и `B`:**
```SQL
SELECT C
FROM A
WHERE C NOT IN (SELECT C FROM B)
UNION
SELECT C
FROM B
WHERE C NOT IN (SELECT C FROM A)
ORDER BY C;
```

**Тестирование шага 3. Результат работы скрипта представлен на рисунке 5.**

```text
Ожидаемый результат:
Петров
Петрова
Смирнов
Алексеев
Евгеньев
Ковалёва
Кузнецов
Медведев
```

⠀

<div align="center">
    <strong>Рисунок 5 - Результат работы скрипта</strong>
</div>
<p align="center">
    <img width="763" alt="2" src="https://github.com/user-attachments/assets/815ac63f-c24b-46d5-bae8-cfca29574ef0">
</p>

---

## Задание 3
Создайте структуру базы данных для решения следующей задачи: У управляющей компании стоит задача создать реестр квартир и жильцов дома. При этом нужно понимать, в каком подъезде и на каком этаже находится квартира. Количество квартир на этажах не всегда одинаковое. Количество квартир — 1471, подъездов — 7, этажей в доме — 17. Для квартир необходимо знать площадь и количество прописанных жильцов.

### Реализация
**1. Построение логической модели предметной области:**
⠀

⠀
<div align="center">
    <strong>Рисунок 6 - Логическая модель предметной области</strong>
</div>
⠀
⠀
<p align="center">
    <img width="763" alt="2" src="https://github.com/user-attachments/assets/b795b004-e907-4706-a830-5be8c3b220d0">
</p>

**2. Построение физической модели предметной области:**
⠀

⠀
<div align="center">
    <strong>Рисунок 7 - Физическая модель предметной области</strong>
</div>
⠀
⠀
<p align="center">
      <img width="763" alt="2" src="https://github.com/user-attachments/assets/9e3adf2f-49bd-4775-ab52-9876df50140a">
</p>

**3. Написание sql-скрипта:**
```sql
-- Таблица подъездов (entrances)
CREATE TABLE Entrances (
    entrance_id SERIAL PRIMARY KEY,       -- Идентификатор подъезда
    entrance_name VARCHAR(50) NOT NULL    -- Номер подъезда
);

-- Таблица этажей (floors)
CREATE TABLE Floors (
    floor_id SERIAL PRIMARY KEY,          -- Идентификатор этажа
    entrance_id INTEGER NOT NULL,         -- Внешний ключ на таблицу подъездов
    floor_num INTEGER NOT NULL,           -- Номер этажа
    
    CONSTRAINT fk_entrance                -- Связь
        FOREIGN KEY (entrance_id)         
        REFERENCES Entrances(entrance_id) ON DELETE CASCADE
);

-- Таблица квартир (apartments)
CREATE TABLE Apartments (
    apartment_id SERIAL PRIMARY KEY,      -- Идентификатор квартиры
    entrance_id INTEGER NOT NULL,         -- Внешний ключ на таблицу подъездов
    floor_id INTEGER NOT NULL,            -- Внешний ключ на таблицу этажей
    apartment_num VARCHAR(10) NOT NULL,   -- Номер квартиры
    area DECIMAL(6,2),                    -- Площадь квартиры
    residents INTEGER,                    -- Количество жильцов
    
    CONSTRAINT fk_floor                   -- Связь
        FOREIGN KEY (floor_id)            
        REFERENCES Floors(floor_id) ON DELETE CASCADE,
    CONSTRAINT fk_entrance_apartment      
        FOREIGN KEY (entrance_id)         
        REFERENCES Entrances(entrance_id) ON DELETE CASCADE
);

-- Таблица жильцов (residents)
CREATE TABLE Residents (
    resident_id SERIAL PRIMARY KEY,       -- Уникальный идентификатор жильца
    apartment_id INTEGER NOT NULL,        -- Внешний ключ на таблицу квартир
    full_name VARCHAR(100) NOT NULL,      -- ФИО Жильца
    date_of_birth DATE,                   -- Дата рождения жильца
    
    CONSTRAINT fk_apartment               -- Связь
        FOREIGN KEY (apartment_id)       
        REFERENCES Apartments(apartment_id) ON DELETE CASCADE
);
```

---

## Задание 4
Есть массив заказов `orders`, в котором каждый заказ — это объект `{id, status, deliveryDate, items}`, где `items` – массив объектов `{productName, cost, quantity}`.

Нужно написать функцию, которая: 
- Отфильтрует все заказы со статусом "delivered".
- Посчитает общую стоимость всех товаров в каждом заказе.
- Сгруппирует заказы по месяцам доставки.

Итого функция должна вернуть объект, где ключ – это название месяца (в формате "January", "February", и т.д.), а значение – это общая стоимость доставленных заказов за этот месяц.

Пример данных:
```javascript
const orders = [ 
    { 
        id: 1, 
        status: 'delivered', 
        deliveryDate: '2024-10-05', 
        items: [ 
            { productName: 'Item1', quantity: 2, price: 50 }, 
            { productName: 'Item2', quantity: 1, price: 100 } 
        ] 
    }, 
    { 
        id: 2, 
        status: 'pending', 
        deliveryDate: '2024-10-12', 
        items: [ 
            { productName: 'Item3', quantity: 1, price: 200 } 
        ] 
    } 
];
```

### Реализация
1. Создание массива заказов `orders`:
```javascript
const orders = [
    {
        id: 1,
        status: 'delivered',
        deliveryDate: '2024-10-05',
        items: [
            { productName: 'Item1', quantity: 2, price: 50 },
            { productName: 'Item2', quantity: 1, price: 100 }
        ]
    },
    {
        id: 2,
        status: 'pending',
        deliveryDate: '2024-10-12',
        items: [
            { productName: 'Item3', quantity: 1, price: 200 }
        ]
    },
    {
        id: 3,
        status: 'delivered',
        deliveryDate: '2024-10-15',
        items: [
            { productName: 'Item4', quantity: 2, price: 45 },
            { productName: 'Item5', quantity: 1, price: 90 }
        ]
    },
    {
        id: 4,
        status: 'delivered',
        deliveryDate: '2024-10-22',
        items: [
            { productName: 'Item6', quantity: 2, price: 80 },
            { productName: 'Item7', quantity: 1, price: 200 },
            { productName: 'Item8', quantity: 4, price: 120 }
        ]
    },
    {
        id: 5,
        status: 'pending',
        deliveryDate: '2024-11-05',
        items: [
            { productName: 'Item9', quantity: 4, price: 120 }
        ]
    },
    {
        id: 6,
        status: 'delivered',
        deliveryDate: '2024-11-15',
        items: [
            { productName: 'Item10', quantity: 3, price: 30 },
            { productName: 'Item11', quantity: 1, price: 150 }
        ]
    },
    {
        id: 7,
        status: 'delivered',
        deliveryDate: '2024-11-20',
        items: [
            { productName: 'Item12', quantity: 4, price: 75 },
            { productName: 'Item13', quantity: 2, price: 60 },
            { productName: 'Item14', quantity: 3, price: 90 },
            { productName: 'Item15', quantity: 1, price: 175 }
        ]
    },
    {
        id: 8,
        status: 'delivered',
        deliveryDate: '2024-11-25',
        items: [
            { productName: 'Item16', quantity: 1, price: 300 }
        ]
    },
    {
        id: 9,
        status: 'delivered',
        deliveryDate: '2024-12-01',
        items: [
            { productName: 'Item17', quantity: 5, price: 60 },
            { productName: 'Item18', quantity: 2, price: 120 }
        ]
    },
    {
        id: 10,
        status: 'pending',
        deliveryDate: '2024-12-10',
        items: [
            { productName: 'Item19', quantity: 3, price: 150 }
        ]
    }
];
```

**2. Написание функции, выполняющей перечисленные требования:**
- Отфильтрует все заказы со статусом "delivered".
- Посчитает общую стоимость всех товаров в каждом заказе.
- Сгруппирует заказы по месяцам доставки.

```javascript
function sumOrdersByMonth(orders) {
    return orders
        .filter(order => order.status === 'delivered') // Фильтруем заказы с статусом "delivered"
        .reduce((acc, order) => {
            // Подсчитываем общую стоимость всех товаров в каждом заказе
            const totalCost = order.items.reduce((sum, item) => sum + item.price * item.quantity, 0);
            
            // Получаем месяц доставки
            const deliveryMonth = new Date(order.deliveryDate).toLocaleString('en-US', { month: 'long' });

            // Группируем по месяцам доставки
            if (!acc[deliveryMonth]) {
                acc[deliveryMonth] = 0;
            }

            // Добавляем стоимость заказа в месяц
            acc[deliveryMonth] += totalCost;

            return acc;
        }, {});
}

// Вызов функции
const sumOrders = sumOrdersByMonth(orders);
console.log(sumOrders);
```

**Тестирование шага 2. Результат работы функции представлен на рисунке 8.**

```text
Ожидаемый результат:
October: 1220
November: 1405
December: 540
```

⠀

<div align="center">
    <strong>Рисунок 8 - Результат работы функции</strong>
</div>
<p align="center">
    <img width="762" alt="1" src="https://github.com/user-attachments/assets/e8a5ccff-22ff-427e-999b-4fb90c41690f">
</p>

---

