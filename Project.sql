-- Question 1
-- Total cases vs Total deaths
SELECT * FROM coviddeaths;
-- Shows likelihood of dying if you contract covid in your country
-- Daily
SELECT
    location,
	date,
	total_cases, -- rolling count
	total_deaths, -- rolling count
    ROUND((total_deaths)*100.0/total_cases, 2) AS "Death Percentage"
FROM
    coviddeaths
WHERE 
	continent IS NOT NULL;

-- Aggregate
SELECT
    location,
	MAX(total_cases) AS total_cases,
	MAX(total_deaths) AS total_deaths,
    ROUND(MAX(total_deaths)*100.0/MAX(total_cases), 2) AS "Death Percentage"
FROM
    coviddeaths
WHERE 
	continent IS NOT NULL
GROUP BY
	location
HAVING
	MAX(total_deaths) > 0
ORDER BY
	"Death Percentage" DESC;

-- Question 2
-- Countries with the Highest Infection Rate compared to Population
SELECT * FROM coviddeaths;
-- Method 1
SELECT
	location,
	population,
	MAX(total_cases) as HighestInfectionCount,
	ROUND(MAX((CAST(total_cases as DECIMAL)/population))*100, 2) as PercentagePopulationInfected
FROM
	coviddeaths
WHERE
	total_cases IS NOT NULL
	AND continent IS NOT NULL
GROUP BY
	location,
	population
ORDER BY
	PercentagePopulationInfected DESC;

-- Method 2 uses :: to CAST "total_cases" to DECIMAL	
SELECT
    location,
    population,
    MAX(total_cases) AS HighestInfectionCount,
    ROUND(MAX(total_cases::DECIMAL / population) * 100, 2) AS PercentagePopulationInfected
FROM
    coviddeaths
WHERE
	total_cases IS NOT NULL
	AND continent IS NOT NULL
GROUP BY
    location, population
ORDER BY
    PercentagePopulationInfected DESC;

-- For Tableau Visualizations
SELECT
    location,
    population,
	date,
    MAX(total_cases) AS HighestInfectionCount,
    ROUND(MAX(total_cases::DECIMAL / population) * 100, 2) AS PercentagePopulationInfected
FROM
    coviddeaths
WHERE
	total_cases IS NOT NULL
	AND continent IS NOT NULL
GROUP BY
    location, population, date
ORDER BY
    location ASC, date ASC;

-- Method 3 multiplies "total_cases" by 100.0 to implicitly cast "total_cases" to DECIMAL, 
-- ensuring the result is a decimal instead of an integer. 	
SELECT
    location,
    population,
    MAX(total_cases) AS HighestInfectionCount,
    ROUND(MAX(total_cases) * 100.0 / population, 2) AS PercentagePopulationInfected
FROM
    coviddeaths
WHERE
	total_cases IS NOT NULL
	AND continent IS NOT NULL
GROUP BY
    location,
    population
ORDER BY
    PercentagePopulationInfected DESC;

-- Question 3
-- Total number of deaths
-- Method 1
-- Used WHERE clause to filter out 'total deaths' NULL values
SELECT
    location,
    MAX(total_deaths) AS TotalDeathCount
FROM
    coviddeaths
WHERE -- Filter out NULL values
	continent IS NOT NULL
	AND total_deaths IS NOT NULL
GROUP BY
    location
ORDER BY
    TotalDeathCount DESC;

-- Method 2
-- Used HAVING clause to filter out 'total deaths' NULL values
SELECT
    location,
    MAX(total_deaths) AS TotalDeathCount
FROM
    coviddeaths
WHERE
	continent IS NOT NULL
GROUP BY
    location
HAVING -- Filter out NULL values
	MAX(total_deaths) > 0
ORDER BY
    TotalDeathCount DESC;

-- Question 4
-- Showing Countries with the Highest Death Count per Population
SELECT
    location,
	population,
    MAX(total_deaths) AS TotalDeathCount,
    ROUND((MAX(total_deaths::DECIMAL)/population)*100, 2) AS DeathPercentage
FROM
    coviddeaths
WHERE
	total_deaths IS NOT NULL
	AND continent IS NOT NULL
GROUP BY
    location,
    population
ORDER BY
    DeathPercentage DESC;

-- Question 5
-- Calculate Total Deaths by Continent
SELECT * FROM coviddeaths;
-- Experiment 1
SELECT
	continent,
	location,
	MAX(total_deaths) AS total_death_count
FROM
	coviddeaths
WHERE
	continent = 'Oceania'
GROUP BY
	continent,
	location
ORDER BY
	location DESC;

-- Experiment 2
SELECT
    continent,
    location,
    MAX(total_deaths) AS total_death_location
FROM
    coviddeaths
WHERE
    continent IS NOT NULL AND total_deaths IS NOT NULL
GROUP BY
    continent, location
ORDER BY
    continent, location;  -- Reminder: Always separate columns with a comma, not AND

-- Final Query/Result
-- Used CTE to 1st calculate total death by Country before summing it up to find total death by continent
WITH TotalCountryDeath AS (
	SELECT
		continent,
		location,
		MAX(total_deaths) AS total_death_location
	FROM
		coviddeaths
	WHERE
		continent IS NOT NULL AND total_deaths IS NOT NULL
	GROUP BY
		continent, location	
)
SELECT
	continent,
	SUM(total_death_location) AS total_death_continent
FROM
	TotalCountryDeath
GROUP BY
	continent
ORDER BY
	total_death_continent ASC;

-- Question 6
-- Global Numbers
SELECT
    date,
	SUM(new_cases) AS total_cases,
	SUM(new_deaths) AS total_deaths,
    ROUND((SUM(new_deaths::DECIMAL)/SUM(new_cases))*100, 2) AS DeathPercentage
FROM
    coviddeaths
WHERE 
	continent IS NOT NULL
GROUP BY
	date
ORDER BY
	date ASC;

-- Without date (total number)
SELECT
	SUM(new_cases) AS total_cases,
	SUM(new_deaths) AS total_deaths,
    ROUND((SUM(new_deaths::DECIMAL)/SUM(new_cases))*100, 2) AS DeathPercentage
FROM
    coviddeaths
WHERE 
	continent IS NOT NULL;

-- Question 7
-- Join CovidDeaths and CovidVaccinatiions
SELECT *
FROM
	coviddeaths cd
JOIN
	covidvaccinations cv
ON
	cd.location = cv.location
AND
	cd.date = cv.date;

-- Question 8
SELECT * FROM covidvaccinations;
-- Looking at Total Population vs Vaccinations
SELECT 
	cd.continent, 
	cd.location, 
	cd.date, 
	cd.population, 
	cv.new_vaccinations
FROM
	coviddeaths cd
JOIN
	covidvaccinations cv
ON
	cd.location = cv.location
AND
	cd.date = cv.date
WHERE 
	cd.continent IS NOT NULL
ORDER BY
	cd.location;

-- Question 9
-- 'Rolling Count' of new_vaccinations using OVER & PARTITION BY
SELECT 
	cd.continent, 
	cd.location, 
	cd.date, 
	cd.population, 
	cv.new_vaccinations,
	SUM(cv.new_vaccinations) 
		OVER(PARTITION BY cd.location -- OVER creates a window and PARTITION BY partitions/separates by 'location' 
				ORDER BY cd.date ASC) AS rolling_people_vaccinated
FROM
	coviddeaths cd
JOIN
	covidvaccinations cv
ON
	cd.location = cv.location
AND
	cd.date = cv.date
WHERE 
	cd.continent IS NOT NULL
ORDER BY
	cd.location;

-- Question 10
-- Finding Percentage of Population Vaccinated
-- Method 1: Using CTE (Common Table Expression)
WITH VaccinationData AS (
	SELECT 
	cd.date,
	cd.continent, 
	cd.location,  
	cd.population, 
	cv.new_vaccinations,
	SUM(cv.new_vaccinations) 
		OVER(PARTITION BY cd.location ORDER BY cd.date ASC) AS rolling_people_vaccinated
	FROM
		coviddeaths cd
	JOIN
		covidvaccinations cv
	ON
		cd.location = cv.location
	AND
		cd.date = cv.date
	WHERE 
		cd.continent IS NOT NULL
)

SELECT 
	date,
	continent, 
	location,  
	population, 
	new_vaccinations,
	rolling_people_vaccinated,
	ROUND((rolling_people_vaccinated::DECIMAL/population)*100, 2) AS percentage_population_vaccinated
FROM
	VaccinationData
ORDER BY
	location, date;

-- Method 2A: Using Temporary Table and AS SELECT to create the TEMP Table
CREATE TEMP TABLE TempVaccinationStats AS 
SELECT 
    cd.date,
    cd.continent, 
    cd.location,  
    cd.population, 
    cv.new_vaccinations,
    SUM(cv.new_vaccinations) 
        OVER(PARTITION BY cd.location ORDER BY cd.date ASC) AS rolling_people_vaccinated
FROM
    coviddeaths cd
JOIN
    covidvaccinations cv
ON
    cd.location = cv.location
AND
    cd.date = cv.date
WHERE 
    cd.continent IS NOT NULL;

SELECT 
    date,
    continent,
    location,
    population,
    new_vaccinations,
    rolling_people_vaccinated,
    ROUND((rolling_people_vaccinated::DECIMAL / population) * 100, 2) AS percentage_population_vaccinated
FROM 
    TempVaccinationStats
ORDER BY 
    location, date;

-- Drop the temp table if needed
DROP TABLE TempVaccinationStats;
 
-- Method 2B: Using Temporary Table and INSERT to create the TEMP Table
-- Step 1: Create the Temporary Table, specify data types
CREATE TEMP TABLE TempVaccinationStats (
    date DATE,
    continent VARCHAR(100),
    location VARCHAR(255),
    population BIGINT,
    new_vaccinations INT,
    rolling_people_vaccinated BIGINT
);

-- Step 2: Insert Data Into the Temporary Table
INSERT INTO TempVaccinationStats (date, continent, location, population, new_vaccinations, rolling_people_vaccinated)
SELECT 
    cd.date,
    cd.continent, 
    cd.location,  
    cd.population, 
    cv.new_vaccinations,
    SUM(cv.new_vaccinations) OVER(PARTITION BY cd.location ORDER BY cd.date ASC) AS rolling_people_vaccinated
FROM
    coviddeaths cd
JOIN
    covidvaccinations cv
ON
    cd.location = cv.location
AND
    cd.date = cv.date
WHERE 
    cd.continent IS NOT NULL;

-- Step 3: Query the Temporary Table
SELECT 
    date,
    continent,
    location,
    population,
    new_vaccinations,
    rolling_people_vaccinated,
    ROUND((rolling_people_vaccinated::DECIMAL / population) * 100, 2) AS percentage_population_vaccinated
FROM 
    TempVaccinationStats
ORDER BY 
    location, date;

-- Step 4: Drop the Temporary Table If Needed
DROP TABLE TempVaccinationStats;

-- Question 11
-- Understand the relationship between the percentage of the population vaccinated and the death rate per Country
WITH CovidData AS (
	SELECT
	    cd.location,
		MAX(cd.date) AS date,  -- Getting the latest available date for each location
		cd.population,
		MAX(total_cases) AS total_cases, -- Running total of cases
	    MAX(cd.total_deaths) AS total_deaths, -- Running total of deaths
		MAX(cv.total_vaccinations) AS people_vaccinated	
	FROM
	    coviddeaths cd
	JOIN
		covidvaccinations cv
	ON
		cd.location = cv.location
	AND
		cd.date = cv.date
	WHERE
		cd.total_deaths IS NOT NULL
	AND 
		cd.continent IS NOT NULL
	AND 
		cv.total_vaccinations IS NOT NULL
	GROUP BY
	    cd.location,
	    cd.population
)
SELECT 
	location,
	date,
	population, 
	ROUND((people_vaccinated::DECIMAL/population) * 100, 2) AS percentage_population_vaccinated,
	ROUND((total_deaths::DECIMAL/total_cases) * 100, 2) AS death_percentage,
	ROUND(((people_vaccinated::DECIMAL/population) * 100)/((total_deaths::DECIMAL/total_cases)* 100), 2) AS vaccination_to_death_ratio
FROM
	CovidData
ORDER BY
	vaccination_to_death_ratio DESC;

-- Question 12
-- Create Views (For visualizations)
-- Total Deaths by Continent
-- Method 1: Using CTE
CREATE VIEW continent_total_death AS
WITH TotalCountryDeath AS (
	SELECT
		continent,
		location,
		MAX(total_deaths) AS total_death_location
	FROM
		coviddeaths
	WHERE
		continent IS NOT NULL AND total_deaths IS NOT NULL
	GROUP BY
		continent, location	
)
SELECT
	continent,
	SUM(total_death_location) AS total_death_continent 
FROM
	TotalCountryDeath
GROUP BY
	continent
ORDER BY
	total_death_continent ASC;

-- Method 2: Using Subquery
CREATE VIEW continent_total_death AS
SELECT
	continent,
	SUM(total_death_location) AS total_death_continent -- Main Query
FROM (
	SELECT
		continent,
		location,
		MAX(total_deaths) AS total_death_location
	FROM
		coviddeaths
	WHERE
		continent IS NOT NULL AND total_deaths IS NOT NULL
	GROUP BY
		continent, location	
) AS TotalCountryDeath -- Subquery
GROUP BY
	continent
ORDER BY
	total_death_continent ASC;

-- Query View
SELECT * FROM continent_total_death;

-- Drop View
DROP VIEW continent_total_death;

-- Vaccination to Death Ratio
CREATE VIEW VaccinationToDeathRatio AS
	WITH CovidData AS (
		SELECT
		    cd.location,
			MAX(cd.date) AS date,  -- Getting the latest available date for each location
			cd.population,
			MAX(total_cases) AS total_cases, -- Running total of cases
		    MAX(cd.total_deaths) AS total_deaths, -- Running total of deaths
			MAX(cv.total_vaccinations) AS people_vaccinated	
		FROM
		    coviddeaths cd
		JOIN
			covidvaccinations cv
		ON
			cd.location = cv.location
		AND
			cd.date = cv.date
		WHERE
			cd.total_deaths IS NOT NULL
		AND 
			cd.continent IS NOT NULL
		AND 
			cv.total_vaccinations IS NOT NULL
		GROUP BY
		    cd.location,
		    cd.population
	)
	SELECT 
		location,
		date,
		population, 
		ROUND((people_vaccinated::DECIMAL/population) * 100, 2) AS percentage_population_vaccinated,
		ROUND((total_deaths::DECIMAL/total_cases) * 100, 2) AS death_percentage,
		ROUND(((people_vaccinated::DECIMAL/population) * 100)/((total_deaths::DECIMAL/total_cases)* 100), 2) AS vaccination_to_death_ratio
	FROM
		CovidData
	ORDER BY
		vaccination_to_death_ratio DESC;

-- Query View
SELECT * FROM VaccinationToDeathRatio;

























































































































































































































































































































































































































































































































































