use Mnt

SELECT [U].[Name] as [UNname],
		[Q].[Sum],
		[Q].ODate
FROM [eshop].Users AS [U]
CROSS APPLY (SELECT TOP 1 SUM([Items].[Price] * [Items].[Qty]) AS [Sum],
							[O].Order_Date AS [ODate]
			FROM [eshop].Orders AS [O]
			JOIN [eshop].Order_Items AS [Items]
			ON [O].Id = [items].Order_Id
			WHERE [O].User_Id = [U].Id --corr subquery
			GROUP BY [O].Id, [O].Order_Date
			ORDER BY [O].Order_Date DESC) AS [Q]
-- CROSS APPLY as inner join
--OUTER return null

--1
SELECT DISTINCT([U].[Name]) as [UNname]
FROM [eshop].Users AS [U]
JOIN [eshop].Orders AS [O]
ON [O].User_Id = [U].Id

--2 (better)
SELECT [U].[Name] as [UNname]
FROM [eshop].Users AS [U]
WHERE  EXISTS (SELECT 1
				FROM [eshop].Orders AS [O]
				WHERE [O].User_Id = [U].Id) -- only subquery

--3
SELECT [U].[Name] as [UNname]
FROM [eshop].Users AS [U]
WHERE [U].Id IN (SELECT [O].[User_Id] FROM [eshop].Orders AS [O]) --subquery + const as list

--semi join if exists or in

--homework
--«апрос, что выводит только простые числа

use Mnt
SELECT ROW_NUMBER() OVER(ORDER BY Id) AS rn 
INTO #NUMBERS
	FROM (SELECT Id FROM [eshop].Order_Items
	UNION ALL
	SELECT Id FROM [eshop].Order_Items
	UNION ALL
	SELECT Id FROM [eshop].Order_Items) AS [Q]

SELECT [N].rn
FROM #NUMBERS AS [N]
WHERE NOT EXISTS 
	(SELECT [N2].rn 
	FROM #NUMBERS AS [N2] 
	WHERE [N].rn %  [N2].rn = 0 AND  [N2].rn < [N].rn  AND  [N2].rn > 1 )  





