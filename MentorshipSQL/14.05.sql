use Mnt

SELECT [Gender], COUNT(DISTINCT ISNULL([Gender], '*')) --*
FROM [eshop].Users 
GROUP BY [Gender]

SELECT * FROM [eshop].Users

INSERT INTO [eshop].Users 
([Login],[Name],[Gender],[Date_Birth])
VALUES ('123','name', null, '2012-02-02')

WITH [Q] AS
(SELECT DATEDIFF(year,[eshop].Users.Date_Birth, GETDATE())
AS [Age], [Gender]
FROM [eshop].Users)

SELECT 
CASE WHEN [Q].Age < 18 THEN 'меньше 18'
	 WHEN [Q].Age BETWEEN 18 AND 30 THEN '18-30'
	 ELSE 'больше 30'
END AS [Category],
COUNT(CASE WHEN [Gender] = 'F' THEN 1 END) AS [FCount],
COUNT(CASE WHEN [Gender] = 'M' THEN 1 END) AS [MCount],
COUNT([Gender]) AS [Total] -- COUNT(*)
FROM [Q]
GROUP BY CASE WHEN [Q].Age < 18 THEN 'меньше 18'
	 WHEN [Q].Age BETWEEN 18 AND 30 THEN '18-30'
	 ELSE 'больше 30'
END
ORDER BY [Category]

SELECT [U].Name, COUNT(*)  
FROM [eshop].Orders AS [O] 
JOIN [eshop].Users AS [U]
ON [O].User_Id = [U].Id
GROUP BY [U].Name
HAVING COUNT(*) > 1

--2 
WITH [Q2] AS (SELECT  [U].Name, COUNT(*) AS [OrderCount] 
FROM [eshop].Orders AS [O] 
JOIN [eshop].Users AS [U]
ON [O].User_Id = [U].Id
GROUP BY [U].Name)

SELECT [Q2].Name , [Q2].OrderCount 
FROM [Q2] 
WHERE [Q2].OrderCount > 1

