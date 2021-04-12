use MNT

SELECT [U].Name,
		[O].Order_Date,
		Sum([Items].[Price] * [Items].[Qty]) AS [Sum],
		Sum(Sum([Items].[Price] * [Items].[Qty])) OVER(PARTITION BY [U].[Name] ORDER BY Order_Date) AS [RunningSum],
		Sum(Sum([Items].[Price] * [Items].[Qty])) OVER(PARTITION BY [U].[Name] ) AS [TotalSum],
		ROW_NUMBER() OVER(PARTITION BY [U].[Name] ORDER BY Order_Date) AS [OrdersSequence],
		COUNT(*) OVER(PARTITION BY [U].[Name]) AS [Count],
		LEAD(Sum([Items].[Price] * [Items].[Qty])) OVER(PARTITION BY [U].[Name] ORDER BY Order_Date) AS [Lead],
		Lag(Sum([Items].[Price] * [Items].[Qty])) OVER(PARTITION BY [U].[Name] ORDER BY Order_Date) AS [Lag],
		Sum([Items].[Price] * [Items].[Qty]) - Lag(Sum([Items].[Price] * [Items].[Qty])) OVER(PARTITION BY [U].[Name] ORDER BY Order_Date) AS [Diff],
		COUNT(*) OVER() AS [TotalCount]
FROM [eshop].Users AS [U]
JOIN [eshop].Orders AS [O]
ON [U].Id = [O].User_Id
JOIN [eshop].Order_Items AS [Items]
ON [Items].Order_Id = [O].Id
GROUP BY [U].Name, [O].Order_Date
ORDER BY [U].Name, [O].Order_Date

--===========================
CREATE TABLE #TMP(
[Id] INT, 
[Name]  VARCHAR(50)
)

INSERT INTO #TMP
([Id],[Name])
VALUES (2, 'A2')

SELECT * 
FROM #TMP


WITH Q AS 
	(SELECT [Id], 
			[Name],
			ROW_NUMBER() OVER (PARTITION BY [Id], [Name] ORDER BY [Id])  AS [RN]
	FROM #TMP)
DELETE FROM Q
WHERE [RN] > 1
