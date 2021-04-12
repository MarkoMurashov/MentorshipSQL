use Mnt

CREATE TABLE [eshop].ProductCategory(
	[Id] int Identity(1,1),
	[Name] VARCHAR(100),
	[ParentId] int, 
	CONSTRAINT PK_ProductCategory PRIMARY KEY ([Id])
)

AlTER TABLE [eshop].[ProductCategory] 
ADD	CONSTRAINT FK_ProductCategory FOREIGN KEY ([ParentId]) REFERENCES [eshop].[ProductCategory]

INSERT INTO [eshop].ProductCategory
([Name], [ParentId])
VALUES ('Category1.1.1', 3)

WITH [Q] ([Id],[Name],[Level]) AS
(SELECT [Id], [Name], 1 AS [Level] --start recurcive
FROM [eshop].ProductCategory
WHERE [ParentId] IS NULL
UNION ALL
--вісчитіваем на основе пред строки
SELECT [PC].Id AS [Id],
	CAST([Q].[Name] + ' -> '  +[PC].[Name] AS VARCHAR(100)) AS [Name],
	[Q].[Level] + 1 AS [Level]
FROM [Q]
JOIN [eshop].ProductCategory AS [PC]
ON  [Q].Id = [PC].ParentId)


SELECT *
FROM [Q]
ORDER BY [Q].Name, [Q].Level
OPTION (MAXRECURSION 2)


WITH [Q2] ([Num]) AS
(SELECT 1 AS [Num] 
UNION ALL 
SELECT [Num] + 1 AS [Num]
FROM [Q2]
WHERE [Num] + 1 <= 100)

SELECT *
FROM [Q2]
