SELECT category, --1
COUNT(*)
FROM Products GROUP BY category;

SELECT SUM(quantity * price_per_unit) --2
FROM order_items;

SELECT c.fullname, --3
COUNT(o.order_id)
FROM customers AS c
LEFT JOIN orders AS o ON c.customers_id = o.customer_id 
GROUP BY c.customer_id, c.full_name;
