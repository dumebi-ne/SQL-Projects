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

**Visualization**

Feel free check out my visualization and dashboard on Tableau from the link below
Link: https://public.tableau.com/views/Covid19_17451196013960/Covid19Analysis?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

**Future Improvements**

*	Automate data updates from external COVID-19 sources.

*	Implement advanced time-series analysis.

**Visualization Sneak Peek 👀😂**

<img width="976" alt="Screenshot 2025-04-24 at 12 49 29 PM" src="https://github.com/user-attachments/assets/4c0ab02f-e40a-47fe-9c10-a3c9221d478c" />


**SQL Query Results**

<img width="940" alt="Screenshot 2025-03-30 at 4 27 14 PM" src="https://github.com/user-attachments/assets/f7428f15-f2b0-4c36-83f7-bfbc0340c02e" />

<img width="940" alt="Screenshot 2025-03-30 at 4 18 28 PM" src="https://github.com/user-attachments/assets/7cbfc5cf-9f48-47ac-b59a-9c061979be3c" />

<img width="941" alt="Screenshot 2025-03-30 at 4 20 04 PM" src="https://github.com/user-attachments/assets/a88d7d03-74ef-4ef2-92a0-75c5c5a0e5a3" />

<img width="939" alt="Screenshot 2025-03-30 at 4 20 40 PM" src="https://github.com/user-attachments/assets/835dbd79-7f68-46a4-8482-e2146dea6c38" />

<img width="939" alt="Screenshot 2025-03-30 at 4 22 55 PM" src="https://github.com/user-attachments/assets/f80c7447-bc80-4789-b22c-dc1fdd1c7597" />

<img width="940" alt="Screenshot 2025-03-30 at 4 24 06 PM" src="https://github.com/user-attachments/assets/bdf6cf48-5042-4177-ac6a-3a9ce277c155" />

<img width="939" alt="Screenshot 2025-03-30 at 4 25 50 PM" src="https://github.com/user-attachments/assets/0ed8b41c-eddb-4b3f-a73b-83cc1f5d2549" />







