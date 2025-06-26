-- Update the status of a specific user to 'banned' based on email
UPDATE Users
SET status = 'banned'
WHERE email = 'priya.s@example.com';

-- Update the price of a specific product
UPDATE Products
SET price = 299.00
WHERE product_name = 'Focus Booster Pack';


-- Delete a specific user by email
DELETE FROM Users
WHERE email = 'priya.s@example.com';
