-- The following queries consists of the datasets filtered by Africa and 2018 

-- Country code Africa 

SELECT *
FROM [10alytics].[dbo].[country code]
WHERE [Continent_Name] = 'Africa'

-- Africa medic per 10k

SELECT [Location], [ThreeLocCode], [FactValueNumeric] AS medic
FROM [dbo].[medical doc]
WHERE [ParentLocation] = 'Africa'
AND [Period] = '2018'
AND [Indicator] = 'Medical doctors (per 10,000)'
ORDER BY [Location]

-- Population of African countries

SELECT [Entity], [Code], [Population (historical estimates)] AS Population
FROM [dbo].['5# World Population$'] AS popn
INNER JOIN [10alytics].[dbo].[country code] AS code ON popn.code = code.[Three_Letter_Country_Code]
WHERE [Continent_Name] = 'Africa'
AND [Year] = '2018'

-- Total death

SELECT Entity, Code, [Deaths 70+ years] + [Deaths 50-69 years] + [Deaths Age: 15-49 years] + [Deaths 5-14 years] + [Deaths Under 5] AS totaldeath
FROM [dbo].['2# number-of-deaths-by-age-grou$'] AS agegroup
INNER JOIN [10alytics].[dbo].[country code] AS code ON agegroup.code = code.[Three_Letter_Country_Code]
WHERE [Continent_Name] = 'Africa'
AND [Year] = '2018'
ORDER BY totaldeath

-- Health expenditure

SELECT [Country Name], [Country Code], [2018]
FROM [dbo].['Current health expenditure$'] AS expenses
INNER JOIN [10alytics].[dbo].[country code] AS code ON expenses.[Country Code] = code.[Three_Letter_Country_Code]
WHERE [Continent_Name] = 'Africa'
ORDER BY [2018] DESC

-- Total death per population calculated

SELECT TOTDE.CODE, TOTDE.totaldeath, TOTDE.Entity, popn.[Population (historical estimates)], TOTDE.totaldeath / popn.[Population (historical estimates)] AS totdeathpop
FROM [dbo].['5# World Population$'] AS popn,
	(SELECT Entity, Code, [Deaths 70+ years] + [Deaths 50-69 years] + [Deaths Age: 15-49 years] + [Deaths 5-14 years] + [Deaths Under 5] AS totaldeath
	FROM [dbo].['2# number-of-deaths-by-age-grou$'] AS agegroup
	INNER JOIN [10alytics].[dbo].[country code] AS code ON agegroup.code = code.[Three_Letter_Country_Code]
	WHERE [Continent_Name] = 'Africa'
	AND [Year] = '2018') AS TOTDE
WHERE TOTDE.Entity = popn.Entity
AND popn.[Year] = '2018'