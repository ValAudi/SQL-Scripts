-- Question 1 --
SELECT COUNT(*) AS 'TOTAL NUMBER OF PRODUCTS'
FROM Production.Product p


-- Question 2 --
SELECT COUNT(*) AS 'NUMBER OF PRODUCTS IN SUBCATEGORY'
FROM Production.Product p
WHERE p.ProductSubcategoryID IS NOT NULL


-- Question 3 --
SELECT p.ProductSubcategoryID, COUNT(p.ProductSubcategoryID) AS 'CountedProducts'
FROM Production.Product p
WHERE p.ProductSubcategoryID IS NOT NULL
GROUP BY p.ProductSubcategoryID


-- Question 4 --
SELECT COUNT(*) AS 'NUMBER OF PRODUCTS NOT IN SUBCATEGORY'
FROM Production.Product p
WHERE p.ProductSubcategoryID IS NULL


-- Question 5 --
SELECT SUM(p.Quantity) AS 'SUM OF PRODUCTS'
FROM Production.ProductInventory p


-- Question 6 --
SELECT p.ProductID, SUM(p.Quantity) AS 'TheSum'
FROM Production.ProductInventory p
WHERE p.LocationID = 40
GROUP BY p.ProductID
HAVING SUM(p.Quantity) < 100


-- Question 7 --
SELECT p.Shelf, p.ProductID, SUM(p.Quantity) AS 'TheSum'
FROM Production.ProductInventory p
WHERE p.LocationID = 40
GROUP BY p.Shelf, p.ProductID
HAVING SUM(p.Quantity) < 100


-- Question 8 --
SELECT AVG(p.Quantity) AS 'TheAverage'
FROM Production.ProductInventory p
WHERE p.LocationID = 10


-- Question 9 --
SELECT p.ProductID, p.Shelf, AVG(p.Quantity) AS 'TheAvg'
FROM Production.ProductInventory p
GROUP BY p.ProductID, p.Shelf


-- Question 10 --
SELECT p.ProductID, p.Shelf, AVG(p.Quantity) AS 'TheAvg'
FROM Production.ProductInventory p
WHERE p.Shelf != 'N/A'
GROUP BY p.ProductID, p.Shelf


-- Question  11 --
SELECT p.Color, p.Class, COUNT(*) AS 'TheCount', AVG(p.ListPrice) AS 'AvgPrice'
FROM Production.Product p
WHERE p.Color IS NOT NULL AND p.Class IS NOT NULL
GROUP BY p.Color, p.Class
ORDER BY p.Color


-- Question 12 --
SELECT c.Name, sp.Name
FROM Person.CountryRegion c
JOIN Person.StateProvince sP
ON c.CountryRegionCode = sp.CountryRegionCode
ORDER BY c.Name, sp.Name


-- Question 13 --
SELECT c.Name, sp.Name
FROM Person.CountryRegion c
JOIN Person.StateProvince sP
ON c.CountryRegionCode = sp.CountryRegionCode
WHERE c.Name IN ('Germany','Canada')
ORDER BY c.Name, sp.Name


-- Question 14 --
-- Assumption made: If it is in the order table it has been sold atleats once --
SELECT p.ProductName AS 'ORDERED PRODUCTS'
FROM [Products] AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN [Orders] AS o
ON od.OrderID = o.OrderID
WHERE o.OrderDate > DATEADD(YEAR, -25, GETDATE())
GROUP BY p.ProductName


-- Question 15 --
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity) AS 'QUANTITIES OF PRODUCTS SOLD'
FROM [Products] AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN [Orders] AS o
ON od.OrderID = o.OrderID
GROUP BY o.ShipPostalCode
ORDER BY SUM(od.Quantity) DESC


-- Question 16 --
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity) AS 'QUANTITIES OF PRODUCTS SOLD'
FROM [Products] AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN [Orders] AS o
ON od.OrderID = o.OrderID
WHERE o.OrderDate > DATEADD(YEAR, -25, GETDATE())
GROUP BY o.ShipPostalCode
ORDER BY SUM(od.Quantity) DESC


-- Question 17 --
SELECT c.City, COUNT(*) AS 'NUMBER OF CUSTOMERS'
FROM [Customers] AS c
GROUP BY c.City
ORDER BY 'NUMBER OF CUSTOMERS' DESC


-- Question 18 --
SELECT c.City, COUNT(*) AS 'NUMBER OF CUSTOMERS'
FROM [Customers] AS c
GROUP BY c.City
HAVING COUNT(*) > 2
ORDER BY 'NUMBER OF CUSTOMERS' DESC


-- Question 19 --
SELECT C.ContactName, o.OrderDate
FROM [Customers] AS c
INNER JOIN [Orders] AS o
ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01'


-- Question 20 --
SELECT c.ContactName, o.OrderDate
FROM [Customers] AS c
INNER JOIN [Orders] AS o
ON c.CustomerID = o.CustomerID
ORDER BY o.OrderDate DESC


-- Question 21 --
-- ? --
SELECT c.ContactName, COUNT(od.ProductID) AS 'COUNT OF PRODUCTS'
FROM [Customers] AS c
INNER JOIN [Orders] AS o
ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] AS od
ON o.OrderID = od.OrderID
GROUP BY c.ContactName
ORDER BY COUNT(od.Quantity) DESC


-- Question 22 --
-- ? --
SELECT c.ContactName, COUNT(od.ProductID) AS 'COUNT OF PRODUCTS'
FROM [Customers] AS c
INNER JOIN [Orders] AS o
ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] AS od
ON o.OrderID = od.OrderID
GROUP BY c.ContactName
HAVING COUNT(od.Quantity) > 100


-- Question 23 --
SELECT s.CompanyName, sh.CompanyName
FROM [Suppliers] AS s
INNER JOIN [Products] AS p
ON s.SupplierID = p.SupplierID
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN [Orders] AS o
ON od.OrderID = o.OrderID
INNER JOIN [Shippers] AS sh
ON o.ShipVia = sh.ShipperID
GROUP BY s.CompanyName, sh.CompanyName
ORDER BY s.CompanyName


-- Question 24
SELECT o.OrderDate, p.ProductName
FROM [Orders] AS o
INNER JOIN [Order Details] AS od
ON o.OrderID = od.OrderID
INNER JOIN [Products] AS p
ON od.ProductID = p.ProductID


-- Question 25
SELECT e1.LastName + e1.FirstName AS 'Full Name of 1st', e2.LastName + e2.FirstName AS 'Full Name of 2nd'
FROM Employees AS e1, Employees AS e2
WHERE e1.EmployeeID != e2.EmployeeID AND e1.Title = e2.Title


-- Question 26 --
SELECT e.LastName + e.FirstName AS 'Full', E.ReportsTo AS 'EMPLOYESS REPORTING TO THEM'
FROM [Employees] AS e
WHERE e.ReportsTo > 2

