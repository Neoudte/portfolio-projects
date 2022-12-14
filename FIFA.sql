-- Viewing our clean data

SELECT *
FROM [Portfolio Project].[dbo].[FIFA 22 CLEAN]

-- Viewing top 10 young players to sign for free after 2023

SELECT TOP 10 [NAME], [Best Position], [AGE], NATIONALITY, [Contract Valid Until], [OVERALL], [POTENTIAL], [VALUE], [WAGE], Photo
FROM [Portfolio Project].[dbo].[FIFA 22 CLEAN]
WHERE [Contract Valid Until] = 2023 AND [Age] <= 23
ORDER BY Potential DESC

-- Viewing top young players potential in each positions

SELECT CLEAN.[Name], CLEAN.[Best Position], CLEAN.[AGE], NATIONALITY, CLEAN.[Overall] , CLEAN.[Potential], CLEAN.[VALUE], CLEAN.[WAGE], CLEAN.Photo
FROM [Portfolio Project].[dbo].[FIFA 22 CLEAN] AS CLEAN,
	(SELECT [Best Position], MAX([Potential]) AS MAXPOT
	FROM [Portfolio Project].[dbo].[FIFA 22 CLEAN]
	WHERE [Age] <= 23
	GROUP BY [Best Position]) AS RESULTS
WHERE CLEAN.[Best Position] = RESULTS.[Best Position]
AND CLEAN.[Potential] = RESULTS.MAXPOT
AND [Age] <= 23
ORDER BY CLEAN.[Potential] DESC

-- Viewing the FIFA World Ranking data

SELECT *
FROM [Portfolio Project].[dbo].[FIFA WORLD RANKING]

-- Joining our the two datas for further analysis

SELECT *
FROM [Portfolio Project].[dbo].[FIFA 22 CLEAN] AS CLEAN
INNER JOIN [Portfolio Project].[dbo].[FIFA WORLD RANKING] AS RANKING ON CLEAN.Nationality = RANKING.Team

-- Viewing young players with high potential 

SELECT CLEAN.Name, CLEAN.[Best Position], CLEAN.AGE, MAXBYRANKING.Nationality, CLEAN.Overall, CLEAN.POTENTIAL, Value, Wage, Photo
FROM [Portfolio Project].[dbo].[FIFA 22 CLEAN] AS CLEAN,
	(SELECT MAX(Potential) AS MAXPOT, Nationality
	FROM [Portfolio Project].[dbo].[FIFA 22 CLEAN] AS CLEAN
	INNER JOIN [Portfolio Project].[dbo].[FIFA WORLD RANKING] AS RANKING ON CLEAN.Nationality = RANKING.Team
	GROUP BY Nationality) AS MAXBYRANKING
WHERE CLEAN.POTENTIAL = MAXBYRANKING.MAXPOT
AND MAXBYRANKING.Nationality = CLEAN.Nationality
AND CLEAN.Age <= 23
ORDER BY CLEAN.Potential DESC
