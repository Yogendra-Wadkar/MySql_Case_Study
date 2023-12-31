# MySQL Case Study - Music Sales Analysis
This MySQL case study focuses on analyzing music sales data to derive insights and answer various business questions. It involves using SQL queries and functions to perform data manipulation and aggregation.

## Objective
The objective of this case study is to analyze the music sales data and answer the following questions:

1. Who is the senior most employee based on job title?
2. Which countries have the most invoices?
3. What are the top 3 values of total invoice?
4. Which city has the best customers? We want to throw a promotional Music Festival in the city we made the most money.
5. Who is the best customer? The customer who has spent the most money will be declared the best customer.
6. Retrieve the email, first name, last name, and genre of all Rock Music listeners.
7. Invite the artists who have written the most rock music in our dataset. Return the artist name and total track count of the top 10 rock bands.
8. Return all the track names that have a song length longer than the average song length.
9. Find the amount spent by each customer on artists. Return customer name, artist name, and total spent.
10. Determine the most popular music genre for each country.
11. Determine the customer that has spent the most on music for each country.

## Dataset
The dataset used in this case study consists of the following tables:

- album
- artist
- customer
- employee
- genre
- invoice
- invoice line
- media type
- playlist
- playlist track
- track

## Methodology
The methodology employed to answer the business questions involved using various SQL queries and functions, including but not limited to:

- JOIN: To combine data from multiple tables based on common keys.
- GROUP BY: To group the data based on specific columns for aggregation.
- Aggregate Functions: To perform calculations on grouped data, such as SUM, COUNT, MAX, MIN.
- ORDER BY: To sort the results based on specific columns.
- WHERE: To filter the data based on specified conditions.
- DISTINCT: To remove duplicate values from the results.
- LIMIT: To limit the number of rows returned.
- Subqueries: To perform queries within queries.
- Common Table Expressions (CTEs): To create temporary named result sets for complex queries.
- Recursive Queries: To perform recursive operations on hierarchical data.

## Results
The results of the analysis provide answers to the business questions outlined above. Each question is addressed using SQL queries and presented with the
relevant data and calculations.

Please refer to the SQL scripts provided in the repository to see the queries used to obtain the results.
