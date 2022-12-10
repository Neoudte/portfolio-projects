-- Viewing our clean data

SELECT *
FROM [Portfolio Project].[dbo].[FIFA 22 CLEAN]

-- Viewing top 10 young players to sign for free after 2023

SELECT TOP 10 [NAME], [AGE], [Contract Valid Until], [OVERALL], [POTENTIAL], [VALUE], [WAGE], Photo
FROM [Portfolio Project].[dbo].[FIFA 22 CLEAN]
WHERE [Contract Valid Until] = 2023 AND [Age] <= 23
ORDER BY Potential DESC

-- Viewing top young players potential in each positions

SELECT CLEAN.[Best Position], CLEAN.[Name], CLEAN.[AGE], CLEAN.[Overall] , CLEAN.[Potential], CLEAN.[VALUE], CLEAN.[WAGE], CLEAN.Photo
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

-- Viewing the top  20 FIFA RANKED countries with high potential young players

SELECT CLEAN.Name, MAXBYRANKING.Nationality, CLEAN.POTENTIAL
FROM [Portfolio Project].[dbo].[FIFA 22 CLEAN] AS CLEAN,
	(SELECT MAX(Potential) AS MAXPOT, Nationality
	FROM [Portfolio Project].[dbo].[FIFA 22 CLEAN] AS CLEAN
	INNER JOIN [Portfolio Project].[dbo].[FIFA WORLD RANKING] AS RANKING ON CLEAN.Nationality = RANKING.Team
	GROUP BY Nationality) AS MAXBYRANKING
WHERE CLEAN.POTENTIAL = MAXBYRANKING.MAXPOT
AND MAXBYRANKING.Nationality = CLEAN.Nationality
AND CLEAN.Age <= 23
ORDER BY CLEAN.Potential DESC