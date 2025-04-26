
\copy products(product_id, product_name, category, price, stock_quantity) FROM '/init_data/products.csv' WITH (FORMAT CSV);

\copy clubs(club_id, club_name, location, membership_count) FROM 'init_data/clubs.csv' WITH (FORMAT CSV);

\copy sales_data(sale_date, total_price, products_array, club_id) FROM '/init_data/sales_data.csv' WITH (FORMAT CSV);


ANALYZE products;
ANALYZE clubs;
ANALYZE sales_data;


-- CREATE INDEX idx_price_btree ON sales_data(total_price);
-- CREATE INDEX idx_sale_date_brin ON sales_data USING BRIN(sale_date);
-- CREATE INDEX idx_products_array_gin ON sales_data USING GIN(products_array);

-- SET enable_seqscan TO off;
-- SET enable_seqscan TO on;

-- -- B-tree
-- SELECT COUNT(*)
-- FROM sales_data
-- WHERE total_price BETWEEN 500 AND 600;

-- -- GIN 
-- SELECT COUNT(*)
-- FROM sales_data
-- WHERE 'Гиря' = ANY(products_array);

-- -- BRIN
-- SELECT COUNT(*)
-- FROM sales_data
-- WHERE sale_date BETWEEN '2024-01-01' AND '2024-12-31';