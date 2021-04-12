use Mnt

CREATE OR ALTER PROCEDURE eshop.usp_InsertUsers @login varchar(50), @name varchar(100), @gender varchar(1), @date date 
AS  
BEGIN
		INSERT INTO [eshop].Users 
		([Login], [Name],[Gender],[Date_Birth])
		VALUES (@login, @name, @gender, @date);
		RETURN SCOPE_IDENTITY();
END;
GO

DECLARE @n int
EXECUTE @n = eshop.usp_InsertUsers 'log1', 'name2', 'M', '2020-02-02'
PRINT @n

SELECT * 
FROM [eshop].Users

--id  return order num