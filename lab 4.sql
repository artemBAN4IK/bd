SELECT category, --1
COUNT(*)
FROM Products GROUP BY category;

SELECT SUM(quantity * price_per_unit) --2
FROM order_items;

SELECT c.full_name, --3
COUNT(o.order_id)
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id 
GROUP BY c.customer_id, c.full_name;

SELECT ROUND(AVG(order_total), 2) --4
FROM ( SELECT order_id, SUM(quantity * price_per_unit)
FROM Order_Items GROUP BY order_id ) AS order_totals;

SELECT status, COUNT(*) --5
FROM Orders GROUP BY status;

SELECT category, COUNT(*) --6
FROM Products GROUP BY category
HAVING COUNT(*) > 1;

SELECT c.full_name --7
FROM Customers AS c
JOIN Orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) > 1;

SELECT p.product_name, SUM(oi.quantity) AS total_sold --8
FROM Products AS p
JOIN Order_Items AS oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 1;
