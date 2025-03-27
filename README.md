# COVID-19 Analysis with SQL

**Overview**

This project leverages PostgreSQL to analyze global COVID-19 data, offering insights into total cases, deaths, infection rates, and vaccination adoption. The dataset, covering statistics up to April 30, 2021, for most countries, allows for an in-depth exploration of death rates, infection patterns, vaccination adoption, and the impact of immunization. By undertaking this project, I aimed to enhance my SQL proficiency while working with real-world data to uncover meaningful insights that can inform decision-making. This hands-on approach deepened my understanding of SQL concepts and their application in data analysis.

**Dataset**

The project uses two tables:

*	**Covid Deaths**: Contains daily records of cases, deaths, population data, etc.

*	**Covid Vaccinations**: Provides vaccination data per country over time.

**Project Goals**

The SQL queries in this project aim to address the following questions:

1.	What is the likelihood of dying if you contract COVID-19 in a specific country?
2.	Which countries have the highest infection rate compared to their population?
3.	What is the total number of deaths reported?
4.	Which countries have the highest death count per population?
5.	What are the total deaths for each continent?
6.	What are the global numbers for total cases, deaths, and death percentage, both daily and overall?
7.	How do Covid Deaths and Covid Vaccinations tables relate?
8.	What is the total population vs. vaccinations?
9.	What is the rolling count of new vaccinations?
10.	What is the percentage of the population vaccinated?
11.	What is the relationship between the percentage of the population vaccinated and the death percentage? Do Countries with higher vaccination percentages have lower death rates?
12.	Create views for visualization.

**SQL Concepts Demonstrated**

The project demonstrates the following SQL concepts:

*	Basic SELECT queries.

*	Filtering with the WHERE clause.

*	Aggregate functions such as MAX, SUM, and ROUND.

*	Grouping data with the GROUP BY clause.

*	Filtering groups with the HAVING clause.

*	Ordering results with the ORDER BY clause.

*	Joining tables with the JOIN clause.

*	Type casting with CAST or ‘::’.

*	Using Common Table Expressions (CTEs) with WITH.

*	Creating and using temporary tables with CREATE TEMPORARY TABLE.

*	Window functions like OVER and PARTITION BY.

*	Creating Views.

**Key Insight.**

The analysis revealed a clear correlation between higher vaccination rates and lower death percentages. Countries with greater vaccination coverage tended to experience reduced mortality rates, underscoring the critical role of immunization in strengthening immune defenses and mitigating the severity of the virus.

**Future Improvements**

*	Automate data updates from external COVID-19 sources.

*	Implement advanced time-series analysis.

*	Create dashboard visualizations using Tableau or Power BI.
