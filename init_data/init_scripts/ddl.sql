CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

CREATE TABLE clubs (
    club_id SERIAL PRIMARY KEY,
    club_name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    membership_count INT
); 

CREATE TABLE sales_data (
    id SERIAL PRIMARY KEY,
    sale_date DATE,                   -- подходит для BRIN (временной порядок)
    total_price DECIMAL(10, 2),       -- подходит для B-tree (поиск по числам)
    products_array TEXT,            -- подходит для GIN (поиск по тегам/категориям)
    club_id INT,
    FOREIGN KEY (club_id) REFERENCES clubs(club_id)
);