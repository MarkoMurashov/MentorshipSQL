--Homework
--табличка: название товара, кол-во ед проданных за прошлый год, за этот год, сумма проданных товаров за прошлый год, за этот год
use Mnt

--INSERT INTO [eshop].Orders 
--([Order_Date],[User_id])
--VALUES ('2020-05-15', 19)

--INSERT INTO [eshop].Order_Items
--([Order_Id], [Product_Id], [Qty],[Price])
--VALUES (SCOPE_IDENTITY(), 23,5,10)

SELECT  [P].Name,
		Count(CASE WHEN DATEDIFF(year,[Order_Date], GETDATE() > 1 THEN 1 END) AS [LongTime],
		Count(CASE WHEN DATEDIFF(year,[Order].Order_Date, GETDATE()) <= 1 THEN 1 END) AS [ThisYear],
		SUM(CASE WHEN DATEDIFF(year,[Order].Order_Date, GETDATE()) > 1 THEN [Items].Price * [Items].Qty  ELSE 0 END) AS [SumLongTime],
		SUM(CASE WHEN DATEDIFF(year,[Order].Order_Date, GETDATE()) <= 1 THEN [Items].Price * [Items].Qty ELSE 0 END) AS [SumThisYear]
FROM [eshop].Products AS [P]
	JOIN [eshop].Order_Items AS [Items]
	ON [Items].Product_id = [P].Id
		JOIN [eshop].Orders AS [Order]
		ON [Order].Id = [Items].Order_Id
GROUP BY [P].Name
