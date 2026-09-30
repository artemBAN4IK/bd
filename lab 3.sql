SELECT c.full_name, o.order_date --1
FROM Customers AS c
JOIN Orders AS o
    ON c.customer_id = o.customer_id;

SELECT c.full_name --2
FROM Customers AS c
LEFT JOIN Orders AS o 
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT p.product_name, oi.quantity, oi.price_per_unit --3
FROM Order_Items AS oi
JOIN Products AS p 
ON oi.product_id = p.product_id
WHERE oi.order_id = 1;

SELECT c.full_name --4
FROM Customers AS c
WHERE c.customer_id IN (
    SELECT o.customer_id
    FROM Orders AS o
    WHERE o.order_id IN (
        SELECT oi.order_id
        FROM Order_Items AS oi
        JOIN Products p ON oi.product_id = p.product_id
        WHERE p.product_name = 'Смартфон'
    )
);

SELECT product_name, price --5
FROM Products
WHERE price > (SELECT AVG(price) FROM Products);

SELECT o.order_id, o.order_date --6
FROM orders AS o
WHERE EXISTS (
    SELECT 1
    FROM order_items AS oi
    WHERE oi.order_id = o.order_id 
      AND oi.price_per_unit > 100000
);

SELECT DISTINCT c.customer_id, c.full_name --7.1
FROM Customers AS c
LEFT JOIN Orders AS o 
ON c.customer_id = o.customer_id
LEFT JOIN Order_Items AS oi 
ON o.order_id = oi.order_id
LEFT JOIN Products AS p 
ON oi.product_id = p.product_id AND p.product_name = 'Ноутбук'
WHERE p.product_id IS NULL;

SELECT c.customer_id, c.full_name --7.2
FROM Customers AS c
WHERE c.customer_id NOT IN (
    SELECT o.customer_id
    FROM Orders AS o
    JOIN Order_Items AS oi 
    ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
    WHERE p.product_name = 'Ноутбук'
);

SELECT p.product_id, p.product_name --8
FROM Products AS p
LEFT JOIN Order_Items AS oi 
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

SELECT c.full_name AS customer_name, p.product_name, oi.quantity --9
FROM Customers AS c
FULL OUTER JOIN Orders AS o 
ON c.customer_id = o.customer_id
FULL OUTER JOIN Order_Items AS oi 
ON o.order_id = oi.order_id
FULL OUTER JOIN Products AS p 
ON oi.product_id = p.product_id;

SELECT DISTINCT c.full_name --10.1
FROM Customers AS c
JOIN Orders AS o 
ON c.customer_id = o.customer_id
JOIN Order_Items AS oi 
ON o.order_id = oi.order_id
JOIN Products AS p 
ON oi.product_id = p.product_id
WHERE p.price = (SELECT MAX(price) FROM Products);

SELECT full_name --10.2
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE order_id IN (
        SELECT order_id
        FROM Order_Items
        WHERE product_id IN (
            SELECT product_id
            FROM Products
            WHERE price = (SELECT MAX(price) FROM Products)
        )
    )
);

SELECT c.full_name, p.category --11
FROM Customers AS c
CROSS JOIN (
    SELECT DISTINCT category 
    FROM Products
    ) AS p
ORDER BY c.full_name, p.category;

SELECT c.full_name AS new_customer, r.full_name AS recommended_by --12
FROM Customers AS c
JOIN Customers AS r 
ON c.recommended_by = r.customer_id;
