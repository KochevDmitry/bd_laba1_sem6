-- Скрипты для демонстрации аномалий изоляции транзакций.
-- Запускать в двух разных psql сессиях (Терминал 1 и Терминал 2).

-- Пример 1: Non-Repeatable Read
-- Терминал 1 (T1):
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT price FROM products WHERE product_id = 3;
-- (Не завершать транзакцию, перейти к Терминалу 2)

-- Терминал 2 (T2):
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE products SET price = 90000 WHERE product_id = 3;
COMMIT; 

-- Терминал 1 (T1, продолжение):
SELECT price FROM products WHERE product_id = 3; --цена изменилась
COMMIT; -- Завершить T1


-- Пример 2: Phantom Read
-- Терминал 1 (T1):
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT COUNT(*) FROM products WHERE category = 'Кардио';
-- (Не завершать транзакцию, перейти к Терминалу 2)

-- Терминал 2 (T2):
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
INSERT INTO products (product_name, category, price, stock_quantity)
VALUES ('Гребной тренажер', 'Кардио', 55000, 15);
COMMIT; -- T2 завершена

-- Терминал 1:
SELECT COUNT(*) FROM products WHERE category = 'Кардио';
-- PostgreSQL обычно предотвращает фантомы на этом уровне.
COMMIT;


-- Попытка Dirty Read
-- Терминал 1:
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE products SET price = 1000 WHERE product_id = 1;
-- (перейти к Терминалу 2)

-- Терминал 2:
BEGIN TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
SELECT price FROM products WHERE product_id = 1;
-- Вывод: (старая цена), например 1500. Изменение из T1 не видно.
COMMIT;

-- Терминал 1:
ROLLBACK; -- Откатить изменения T1 