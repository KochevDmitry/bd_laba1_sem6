DROP INDEX IF EXISTS idx_products_array_gin;
DROP INDEX IF EXISTS idx_price_btree;
DROP INDEX IF EXISTS idx_sale_date_brin;

CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS pg_bigm;
CREATE EXTENSION IF NOT EXISTS pgcrypto;

--РАБОТА С РАСШИРЕНИЯМИ
--pg_trgm
SELECT products_array, similarity(products_array, 'Гир') AS sim
FROM sales_data
WHERE similarity(products_array, 'Гиря') > 0.3
ORDER BY sim DESC;

--pg_bigm 
EXPLAIN ANALYZE 
SELECT count(*)
FROM sales_data
WHERE products_array LIKE '%Гиря%';

--pgcrypto в файле crypto.sql

CREATE INDEX idx_price_btree ON sales_data(total_price);
CREATE INDEX idx_sale_date_brin ON sales_data USING BRIN(sale_date);
CREATE INDEX idx_products_array_gin ON sales_data USING GIN(products_array gin_trgm_ops);

--ПРОВЕРКА РАБОТЫ ИНДЕКСОВ

EXPLAIN ANALYZE  SELECT count(*)
FROM sales_data
WHERE products_array LIKE '%Гиря%';

SET enable_seqscan = OFF;  -- чтобы точно пошёл через индекс

EXPLAIN ANALYZE
SELECT *
FROM sales_data
WHERE total_price > 500;

-- SET enable_seqscan = OFF;  

EXPLAIN ANALYZE
SELECT *
FROM sales_data
WHERE sale_date BETWEEN '2024-01-01' AND '2024-12-31';



