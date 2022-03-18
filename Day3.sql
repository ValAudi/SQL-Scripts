-- Question 1 --
SELECT DISTINCT e.City
FROM Employees e
WHERE e.City IN (SELECT c.City
FROM Customers c)


-- Question 2a --
SELECT DISTINCT c.City
FROM Customers c
WHERE c.City NOT IN (SELECT e.City
FROM Employees e)


-- Question 2b --
SELECT c.City
FROM Customers c
EXCEPT 
SELECT e.City
FROM Employees e


-- Question 3
SELECT p.ProductName, SUM(od.Quantity) [TOTAL ORDER QUANTITY]
FROM Products p
LEFT OUTER JOIN [Order Details] od
ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY p.ProductName


-- Question 4 --
SELECT c.City, SUM(od.Quantity) [TOTAL QUANTITY OF PRODUCTS ORDERED]
FROM [Products] AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN [Orders] AS o
ON od.OrderID = o.OrderID
INNER JOIN [Customers] AS c
ON o.CustomerID = c.CustomerID
GROUP BY c.City
ORDER BY c.City


-- Question 5a --
SELECT c1.City, COUNT(*) [NUMBER OF CUSTOMERS]
FROM Customers c1
GROUP BY c1.City
HAVING COUNT(*) > 1
UNION
SELECT c1.City, COUNT(*) [NUMBER OF CUSTOMERS]
FROM Customers c1
GROUP BY c1.City
HAVING COUNT(*) > 1


-- Question 5b --
SELECT City 
FROM (SELECT c1.City, COUNT(*) [CUST_COUNT]
FROM Customers c1
GROUP BY c1.City) dt
WHERE CUST_COUNT > 1


-- Question 5: Extra solution using SELF JOIN
SELECT DISTINCT c1.City
FROM Customers c1, Customers c2
WHERE c1.CustomerID != c2.CustomerID AND c1.City = c2.City


-- Question 6 --
SELECT City, NUM_PROD
FROM (SELECT c.City, COUNT(od.ProductID) [NUM_PROD]
FROM [Products] AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN [Orders] AS o
ON od.OrderID = o.OrderID
INNER JOIN [Customers] AS c
ON o.CustomerID = c.CustomerID
GROUP BY c.City) dt
WHERE NUM_PROD > 1
ORDER BY City


-- Question 7 --
SELECT DISTINCT ContactName
FROM (SELECT	c.ContactName, 
				o.OrderID, 
				c.City, 
				o.ShipCity
FROM [Products] AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN [Orders] AS o
ON od.OrderID = o.OrderID 
INNER JOIN [Customers] AS c
ON o.CustomerID = c.CustomerID) dt
WHERE City != ShipCity
ORDER BY ContactName


-- Question 8 ?--
-- Most popular by orders made for it or most popular by quantity --
-- I assumed most popular by number of orders --
SELECT  TOP 5 COUNT(od.ProductID) [MOST POPULAR PRODUCT], 
		SUM(od.Quantity) [QUANTITY OF PRODUCT SOLD],
		AVG(od.UnitPrice) [AVERAGE PRICE], 
		c.City
FROM [Products] AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN [Orders] AS o
ON od.OrderID = o.OrderID 
INNER JOIN [Customers] AS c
ON o.CustomerID = c.CustomerID
GROUP BY c.City
ORDER BY COUNT(od.ProductID) DESC

-- Extra: Question 8 --
-- Assuming most popular by quantity sold --
SELECT  TOP 5 COUNT(od.ProductID) [MOST POPULAR PRODUCT], 
		SUM(od.Quantity) [QUANTITY OF PRODUCT SOLD],
		AVG(od.UnitPrice) [AVERAGE PRICE], 
		c.City
FROM [Products] AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN [Orders] AS o
ON od.OrderID = o.OrderID 
INNER JOIN [Customers] AS c
ON o.CustomerID = c.CustomerID
GROUP BY c.City
ORDER BY SUM(od.Quantity) DESC


-- Question 9a --
SELECT DISTINCT e.City
FROM Employees e
WHERE e.City NOT IN (SELECT c.City
FROM [Products] AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN [Orders] AS o
ON od.OrderID = o.OrderID
INNER JOIN [Customers] AS c
ON o.CustomerID = c.CustomerID)


-- Question 9b --
SELECT e.City
FROM Employees e
EXCEPT
SELECT c.City
FROM [Products] AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID
INNER JOIN [Orders] AS o
ON od.OrderID = o.OrderID
INNER JOIN [Customers] AS c
ON o.CustomerID = c.CustomerID


-- Question 10 --
SELECT ShipCity
FROM (SELECT e.FirstName, 
			 o.ShipCity, 
			 COUNT(o.OrderID) [NO OF ORDERS], 
			 RANK() OVER(ORDER BY COUNT(o.OrderID) DESC) [ORD_RANK]
	 FROM [Employees] AS e 
	 INNER JOIN Orders o
	 ON e.EmployeeID = o.EmployeeID
	 INNER JOIN [Order Details] od
	 ON o.OrderID = od.OrderID
	 INNER JOIN Products p
	 ON od.ProductID = p.ProductID
	 GROUP BY e.FirstName, o.ShipCity) dt
WHERE ORD_RANK = 1
UNION
SELECT ShipCity
FROM (SELECT e.FirstName, 
			 p.ProductName, 
			 o.ShipCity, 
			 SUM(od.Quantity) [QUANTITY OF ORDERS],
			 RANK() OVER(ORDER BY SUM(od.Quantity) DESC) [QUAN_RANK]
	 FROM [Employees] AS e 
	 INNER JOIN Orders o
	 ON e.EmployeeID = o.EmployeeID
	 INNER JOIN [Order Details] od
	 ON o.OrderID = od.OrderID
	 INNER JOIN Products p
	 ON od.ProductID = p.ProductID
	 GROUP BY e.FirstName, p.ProductName, o.ShipCity) dt
WHERE QUAN_RANK = 1


-- Question 11 --

-- If in a query result set by using the key word DISTINCT. --
-- I think we can save the query result of one table into another --
-- table --
