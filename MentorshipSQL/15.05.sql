use Mnt
CREATE TABLE [eshop].DISCOUNT 
( [Id] INT IDENTITY(1,1) NOT NULL,
  [Name] VARCHAR(50) NOT NULL,
  [Description] VARCHAR(100),
  CONSTRAINT PK_DISCOUNT PRIMARY KEY Clustered(Id),
  CONSTRAINT UNI_Name UNIQUE([Name])
)

INSERT INTO [eshop].DISCOUNT 
([Name],[Description])
VALUES('FOOD','≈‰‡')

CREATE TABLE [eshop].Users_Discount 
( [Id] INT IDENTITY(1,1) NOT NULL,
  [User_Id] INT NOT NULL,
  [Discount_Id] INT NOT NULL,
  [Proc] NUMERIC(5,2),
  [Start_date] DATE,
  [End_date] DATE,
  CONSTRAINT PK_User_Discount PRIMARY KEY Clustered(Id),
  CONSTRAINT FK_User_Id_Discount FOREIGN KEY([User_Id]) REFERENCES [eshop].Users,
  CONSTRAINT FK_Discount_Id FOREIGN KEY([Discount_Id]) REFERENCES [eshop].DISCOUNT
)

INSERT INTO [eshop].Users_Discount
([User_Id],[Discount_Id],[Proc],[Start_date],[End_date])
VALUES (3,2,15, '2018-02-02', NULL)


SELECT [U].Name AS [UName],
		MAX(CASE WHEN [D].Name = 'CLOTHES' THEN [UD].[Proc] END) AS [ClothesProc],
		MAX(CASE WHEN [D].Name = 'SHOSE' THEN [UD].[Proc] END) AS [ShoseProc],
		MAX(CASE WHEN [D].Name = 'FOOD' THEN [UD].[Proc] END) AS [FoodProc]
FROM [eshop].Users AS [U]
LEFT JOIN [eshop].Users_Discount AS [UD]
ON [UD].User_Id = [U].Id AND [UD].Start_date < GETDATE() AND ISNULL([UD].End_date,'9999-12-31') > GETDATE()
LEFT JOIN [eshop].DISCOUNT AS [D]
ON [D].Id = [UD].Discount_Id
GROUP BY [U].Name 

--2
--PIVOT
SELECT  [P].[UName],
		[P].[CLOTHES],
		[P].[SHOSE],
		[P].[FOOD]
FROM (SELECT [U].Name AS [UName], [UD].[Proc] AS [DProc], [D].[Name] AS [DName]
		FROM [eshop].Users AS [U]
		LEFT JOIN [eshop].Users_Discount AS [UD]
		ON [UD].User_Id = [U].Id AND [UD].Start_date < GETDATE() AND ISNULL([UD].End_date,'9999-12-31') > GETDATE()
		LEFT JOIN [eshop].DISCOUNT AS [D]
		ON [D].Id = [UD].Discount_Id
		) AS [Q]
PIVOT
( 
MAX([Q].[DProc])
FOR [Q].[DName] IN ([CLOTHES], [SHOSE], [FOOD])
) AS [P]