-- Insert user with missing optional fields (age, gender)
INSERT INTO Users (name, email, join_date)
VALUES ('Priya Sharma', 'priya.s@example.com', CURRENT_DATE);


-- Insert product relying on default values
INSERT INTO Products (product_name, product_type, price)
VALUES ('Focus Booster Pack', 'One-time', 399.00);


-- Insert exercise with minimal info
INSERT INTO Exercises (module_id, exercise_name, instructions)
VALUES (1, 'Speed Match', 'Match fast-moving symbols.');



Select * from Users;
Select * FROM Products;
SELECT * FROM Exercises;