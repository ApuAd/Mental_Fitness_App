/* 
===================================
1. Use SELECT * and specific columns
===================================
*/
-- Select all columns from the Users table
SELECT * FROM Users;

-- Select specific columns from the Products table
SELECT product_name, price, product_type FROM Products;


/* 
===================================
2. Apply WHERE, AND, OR, LIKE, BETWEEN
===================================
*/
-- Get users who are active and older than 30
SELECT name, age, status FROM Users
WHERE status = 'active' AND age > 30;

-- Find products that are either subscriptions or priced under 200
SELECT product_name, price FROM Products
WHERE product_type = 'Subscription' OR price < 200;

-- Find exercises whose name contains the word 'Match'
SELECT exercise_name FROM Exercises
WHERE exercise_name LIKE '%Match%';

-- Get users whose age is between 25 and 40
SELECT name, age FROM Users
WHERE age BETWEEN 25 AND 40;


/* 
===================================
3. Sort with ORDER BY
===================================
*/
-- List users sorted by join_date (newest first)
SELECT name, email, join_date FROM Users
ORDER BY join_date DESC;

-- Show products sorted by price (lowest to highest)
SELECT product_name, price FROM Products
ORDER BY price ASC;


/* 
===================================
Combining all
===================================
*/
-- Get active users aged 25–40 whose name starts with 'A', sorted by age
SELECT name, age FROM Users
WHERE status = 'active' AND age BETWEEN 25 AND 40 AND name LIKE 'A%'
ORDER BY age;
