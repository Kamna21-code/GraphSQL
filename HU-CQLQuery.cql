LOAD CSV WITH HEADERS FROM "FILE:///3S-e-commerce-2021.CSV" AS LINE
CRAETE (:LoadedCsv { InvoiceNo : LINE.InvoiceNo , StockCode : LINE.StockCode , Description : LINE.Description ,Quantity : LINE.Quantity ,InvoiceDate : date(LINE.InvoiceDate),     
        UnitPrice : LINE.UnitPrice , CustomerID : LINE.CustomerID , Country : LINE.Country });

//Question 1 How many customers are from the United Kingdom?
MATCH ( n:LoadedCsv ) where n.Country = 'United Kingdom'  
RETURN COUNT ( n.CustomerID );
//Question 2 Which product is the most popular one (i.e., most customers purchased it)?
MATCH(n:LoadedCsv) 
RETURN n.Description , COUNT(n.Description) as products_count order by COUNT(n.Description) desc limit 1;
//Question 3 Which customer spent the most money?
MATCH(n:LoadedCsv) RETURN n.CustomerID , sum(TOINTEGER(n.UnitPrice)) as total_price limit 1;
//Question 4 Display the customer who placed orders in the most consecutive calendar months?
MATCH(n:LoadedCsv) 
where ( n.InvoiceDate.month = datetime().month OR n.InvoiceDate.month = ((datetime().month)-1) 
RETURN distinct n.CustomerID;
//Question 5 What did the customers buy before and after they bought the most popular product
MATCH(p:LoadedCsv) CALL { MATCH (n:LoadedCsv) return distinct n.Description as descr, COUNT(n.InvoiceNo) as total_invoices
ORDER BY COUNT(n.InvoiceNo) DESC LIMIT 2}
RETURN  descr, total_invoices
order by total_invoices asc limit 1;