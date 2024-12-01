use TSQLV6 
-- 2. Get All Orders Happened in June 2021
SELECT * FROM Sales.Orders WHERE orderdate >= '2021-06-01' AND orderdate < '2021-07-01';

-- 3. Get Orders Placed on Day Before the Last Day of the Month
SELECT * FROM Sales.Orders WHERE orderdate = DATEADD(DAY, -1, EOMONTH(orderdate));

--4. Get Employees with Last Name Containing 'e' Twice or More
SELECT * FROM HR.Employees WHERE lastname LIKE '%e%e%';

--5. Get Orders with Total Value Greater Than 10000
SELECT * FROM Sales.OrderDetails WHERE qty * unitprice > 10000;

-- 6. Get Employees with Last Name Starting with Lowercase Letter
select * from hr.Employees where SUBSTRING(LastName, 1, 1) collate Latin1_General_BIN =
 LOWER(SUBSTRING(LastName, 1, 1));

SELECT * FROM HR.Employees WHERE lastname LIKE '[a-z] %';

--7-THE difference between this two query 
--Query 1:
 SELECT empid , COUNT(*) AS numorders FROM Sales.Orders WHERE orderdate <'20220501'GROUP BY empid;

 --Query 2:
 SELECT empid, COUNT(*) AS numorders FROM Sales.Orders GROUP BY empid HAVING MAX(orderdate) < '20220501';

 -- 8. Get Top 3 Ship Countries with Highest Average Freight in 2021
 SELECT TOP 3 shipcountry, AVG(freight) AS freightAvg FROM Sales.Orders WHERE YEAR(orderdate) = 2021 GROUP BY shipcountry ORDER BY freightAvg DESC;

-- 9. Get Row Numbers for Orders Based on Order Date
SELECT custid, orderid, orderdate,
ROW_NUMBER() OVER (PARTITION BY custid ORDER BY orderdate, orderid) AS rownum FROM Sales.Orders;

--10. Return Gender of Employees Based on Title of Courtesy
SELECT empid, titleofcourtesy, CASE  WHEN titleofcourtesy IN ('Ms.', 'Mrs.') THEN 'Female' WHEN titleofcourtesy = 'Mr.' THEN 'Male' ELSE 'unknown' END AS empGender FROM HR.Employees;

-- 11. Get Customer ID and Region with NULLs Sorted Last
SELECT custid, region FROM Sales.Customers ORDER BY CASE WHEN region IS NULL THEN 1 ELSE 0 END, region ASC;
