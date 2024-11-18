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