/*
** DISTINCT ON Clause

** The DINSTINCT ON clause is used to select only one row per group based on the specified columns, effectively filtering out duplicates. 
*/

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20)
);

COPY orders (
    order_id, 
    customer_id, 
    order_date,
    status)
FROM '../data/custom/orders_table.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL 'NULL');

/*
** The query below returns one row for each customer, choosing the row with the most recent order per customer.
*/
SELECT DISTINCT ON (customer_id) *
FROM orders
ORDER BY customer_id ASC, order_date DESC
