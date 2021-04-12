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