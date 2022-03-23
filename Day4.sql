-- Question 1 --
CREATE VIEW view_products_order_audi
AS
SELECT p.ProductName, SUM(od.Quantity) [TOTAL ORDER QUANTITY]
FROM Products p
LEFT OUTER JOIN [Order Details] od
ON p.ProductID = od.ProductID
GROUP BY p.ProductName
GO

-- Testing --
SELECT *
FROM view_products_order_audi

DROP VIEW view_products_order_audi

-- Question 2 --
CREATE PROCEDURE sp_product_order_quantity_audi 
@prod_id int,
@total_quantity int out
AS
BEGIN
SELECT @total_quantity = SUM(od.Quantity)
FROM Products p
LEFT OUTER JOIN [Order Details] od
ON p.ProductID = od.ProductID
WHERE p.ProductID = @prod_id
GROUP BY p.ProductID
END

-- Testing --
BEGIN 
DECLARE @total_quantity INT
EXEC sp_product_order_quantity_audi 4, @total_quantity OUT
PRINT @total_quantity
END

DROP PROC sp_product_order_quantity_audi

-- Question 3 -- This quesion is not very clear. From a quick research it seems to be implied that we cannot 
-- return a table as an output of a procedure
CREATE PROCEDURE sp_product_order_city_audi
@prod_name nvarchar(40)
AS 
BEGIN
SELECT TOP 5 o.ShipCity, SUM(od.Quantity) [Order_Quantity]
FROM Products p 
INNER JOIN [Order Details] od 
ON p.ProductID = od.ProductID
INNER JOIN Orders o 
ON od.OrderID = o.OrderID
WHERE p.ProductName = @prod_name
GROUP BY ProductName, ShipCity
ORDER BY SUM(od.Quantity) DESC
END

-- Testing --
EXEC sp_product_order_city_audi 'Ikura';
DROP PROC sp_product_order_city_audi;


-- Question 4 --
CREATE TABLE people_audi (
id int,
FullName varchar(30),
City int
);

INSERT INTO people_audi VALUES (1, 'Aaron Rodgers', 2);
INSERT INTO people_audi VALUES (2, 'Russell Wilson', 1);
INSERT INTO people_audi VALUES (3, 'Jody Nelson', 2);

CREATE TABLE city_audi (
id int,
City varchar(20),
);

INSERT INTO city_audi VALUES (1, 'Seattle');
INSERT INTO city_audi VALUES (2, 'Green Bay');

CREATE TRIGGER city_del ON city_audi
FOR DELETE
AS 
DECLARE @id INT;
SELECT @id = del.id FROM DELETED del;
INSERT INTO city_audi VALUES (3, 'Madison');
UPDATE people_audi
SET City = 3
WHERE City = @id

DELETE FROM city_audi 
WHERE City = 'Seattle'

CREATE VIEW Packers_audi
AS 
SELECT FullName
FROM people_audi
WHERE City = 2 -- THIS IS 'GREEN BAY'


SELECT *
FROM Packers_audi

DROP TRIGGER city_del;
DROP VIEW Packers_audi;
DROP TABLE city_audi;
DROP TABLE people_audi;


-- Question 5 --
CREATE PROCEDURE sp_birthday_employees_audi
AS
BEGIN
CREATE TABLE birthday_employees_audi(
EmpID INT PRIMARY KEY, 
FullName VARCHAR(20), 
Birthdate DATETIME
)
INSERT INTO birthday_employees_audi SELECT EmployeeId, FirstName + ' '  + LastName [FullName], BirthDate
FROM Employees
WHERE MONTH(BirthDate) = 2
END

-- Testing --
EXEC sp_birthday_employees_audi;

SELECT *
FROM birthday_employees_audi

DROP TABLE birthday_employees_audi;

-- Question 6 --

SELECT *
FROM Products		-- table 1
EXCEPT
SELECT *
FROM Products		-- table 2

-- It should return no result set--