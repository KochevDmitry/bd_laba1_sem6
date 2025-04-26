
-- Оформление новой продажи

BEGIN;


INSERT INTO sales_data (sale_date, total_price, products_array, club_id)
VALUES (CURRENT_DATE, 3000.00, 'Гиря', 3);

UPDATE products
SET stock_quantity = stock_quantity - 2
WHERE product_id = 3 AND stock_quantity >= 2;


-- Если товара не хватило, нужно выполнить ROLLBACK.

COMMIT;
-- Или ROLLBACK; 


-- Добавление нового товара и начальной партии
BEGIN;
-- SELECT setval('products_product_id_seq', (SELECT MAX(product_id) FROM products));

INSERT INTO products (product_name, category, price, stock_quantity)
VALUES ('Новый Супер-Эспандер', 'Функциональное', 1200.00, 0);


UPDATE products
SET stock_quantity = 50
WHERE product_name = 'Новый Супер-Эспандер';

COMMIT;
-- Или ROLLBACK;


-- Перевод товара в другую категорию с изменением цены
BEGIN;

-- Меняем категорию и цену для товара ID 10
UPDATE products
SET category = 'Силовое',
    price = 6500.00
WHERE product_id = 10;

COMMIT;
-- Или ROLLBACK; 