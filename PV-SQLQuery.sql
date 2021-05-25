--no of invoices we get from UK
SELECT COUNT(x.CustomerID) as cust FROM CSVLoaded x WHERE x.Country = 'United Kingdom'

--top 1 product selling count
SELECT TOP 1 x.Description , COUNT(x.Description) AS total FROM CSVLoaded x
GROUP BY (x.Description) 
ORDER BY COUNT(x.Description) DESC
 
--sum of total sale of customer 
SELECT TOP 1 SUM(convert(int,x.UnitPrice)) AS toatal ,  x.CustomerID FROM CSVLoaded x
GROUP BY x.CustomerID
ORDER BY SUM(convert(int,x.UnitPrice)) DESC

--get custmer who buy in conective months
SELECT DISTINCT e.CustomerID FROM CSVLoaded e
WHERE (MONTH(e.InvoiceDate) = MONTH(getdate()) OR MONTH(e.InvoiceDate) = (MONTH(getdate())-1));

--get second highest selling product
WITH E AS
(
SELECT x.Description ,COUNT(x.InvoiceNo) AS counts,DENSE_RANK() OVER (ORDER BY  COUNT(x.InvoiceNo) Desc) AS rw_rak
FROM CSVLoaded x group by  x.Description
)

--now we will select desired columns 
SELECT E.Description , E.counts
FROM E 
WHERE rw_rak=2;






  