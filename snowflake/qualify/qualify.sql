/*
** QUALIFY Clause

** The QUALIFY clause is used in conjunction with window functions to filter the results of the window function directly within the same query level. 
** It is a Snowflake-specific extension of SQL.
** Works similarly to how HAVING in standard SQL filters aggregate functions.
*/

SELECT * FROM orders;

/*
** The query below retrieves the order with the most recent date for each customer using ROW_NUMBER() window function and 
** the QUALIFY clause which filters results and ensures that only the most recent order per customer is returned.
*/

SELECT 
    order_id, 
    customer_id, 
    order_date,
    status     
FROM orders
QUALIFY ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) = 1
ORDER BY customer_id;

EXPLAIN USING TABULAR SELECT 
    order_id, 
    customer_id, 
    order_date,
    status     
FROM orders
QUALIFY ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) = 1
ORDER BY customer_id;