--Question 1--

SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product p


-- Question 2 --

SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product p
WHERE p.ListPrice != 0


-- Question 3 --

SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product p
WHERE p.Color IS NULL


-- Question 4 --

SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product p
WHERE p.Color IS NOT NULL


-- Question 5 --

SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product p
WHERE p.Color IS NOT NULL AND p.ListPrice > 0


-- Question 6 --
SELECT CONCAT(p.Name, ': ',  p.Color)
FROM Production.Product p
WHERE p.Color IS NOT NULL


-- Question 7 --
SELECT CONCAT('NAME: ', p.Name, ' --  COLOR: ',  p.Color) AS 'NAME/COLOR'
FROM Production.Product p
WHERE p.Color IS NOT NULL


-- Question 8 --
SELECT p.ProductID, p.Name
FROM Production.Product p
WHERE p.ProductID BETWEEN 400 AND 500


-- Question 9 --
SELECT p.ProductID, p.Name, p.Color
FROM Production.Product p
WHERE p.Color IN ('Black', 'Blue')


-- Question 10--
SELECT * 
FROM Production.Product p
WHERE p.Name LIKE 'S%'


-- Question 11--
SELECT p.Name, p.ListPrice
FROM Production.Product p
WHERE p.Name LIKE 'S%'
ORDER BY p.Name, p.ListPrice

-- Question 12--
SELECT p.Name, p.ListPrice
FROM Production.Product p
WHERE p.Name LIKE '[AS]%' 
ORDER BY p.Name, p.ListPrice


-- Question 13--
SELECT *
FROM Production.Product p
WHERE p.Name LIKE '[SPO][^K]%' 
ORDER BY p.Name


-- Question 14 --
SELECT DISTINCT p.Color
FROM Production.Product p
ORDER BY p.Color DESC


-- Question 15 --
SELECT DISTINCT p.ProductSubcategoryID, p.Color
FROM Production.Product p
WHERE p.ProductSubcategoryID IS NOT NULL AND p.Color IS NOT NULL