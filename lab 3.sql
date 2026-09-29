SELECT c.full_name, o.order_date --1
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id;

SELECT c.full_name --2
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT p.product_name, i.quantity, i.price_per_unit --3
FROM Order_Items i
JOIN Products p ON i.product_id = p.product_id
WHERE i.order_id = 1;

SELECT c.full_name --4
FROM Customers c
WHERE c.customer_id IN (
    SELECT o.customer_id
    FROM Orders o
    WHERE o.order_id IN (
        SELECT i.order_id
        FROM Order_Items i
        JOIN Products p ON i.product_id = p.product_id
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
