use music_database;
 -- Question Set 1 - beginner
 
 -- Q1: Who is the senior most employee based on job title?

select * from employee order by levels desc limit 1 ;

-- Q2: Which countries have the most Invoices?

select count(*), billing_country from invoice group by billing_country; 

-- Q3: What are top 3 values of total invoice

select total from invoice order by total desc limit 3;

/* Q4: Which city has the best customers? We would like to throw a promotional Music 
Festival in the city we made the most money.Write a query that returns one city that has 
the highest sum of invoice totals. Return both the city name & sum of all invoice totals. */

select sum(total) as invoice_total, billing_city from invoice group by billing_city order by 
invoice_total desc;

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the
best customer. Write a query that returns the person who has spent the most money. */

select c.customer_id, c.first_name, c.last_name, sum(i.total) as  total from customer as c
join invoice as i on c.customer_id = i.customer_id 
group by c.customer_id, c.first_name, c.last_name
order by total 
desc limit 1 ;

-- Question Set 2 - Moderate

/*  Q6: Write query to return the email, first name, last name, & Genre of all Rock Music
listeners. Return your list ordered  alphabetically by email starting with A. */

select distinct email, first_name, last_name from customer as c
join invoice as i on c.customer_id =  i.customer_id 
join invoice_line as il on i.invoice_id = il.invoice_id
where track_id in ( 
     select track_id from track as t
    join genre as g on t.genre_id = g.genre_id
    where g.name like "Rock" ) 
    order by email ;
select * from track;

/*  Q7: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

select ar.artist_id, ar.name, count(ar.artist_id) as no_of_songs from track as t
join album as al on al.ï»¿Album_id = t.album_id
join artist as ar on ar.artist_id - al.artist_id
join genre as g on g.genre_id = t.genre_id
where g.name like "Rock" 
group by ar.artist_id, ar.name
order by no_of_songs desc limit 10 ;

/*  Q8: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs 
listed first. */

select name, milliseconds from track where milliseconds > (
select avg(milliseconds) as avg_track_length from track )
order by milliseconds desc;

-- Question Set 3 - Advance

/*  Q9: Find how much amount spent by each customer on artists? Write a query to return
 customer name, artist name and total spent. */

with best_selling_artist as (
   select ar.artist_id, ar.name as artist_name, sum(il.unit_price * il.quantity) as total_sales 
   from invoice_line as il
   join track as t on t.track_id = il.track_id
   join album as al on al.ï»¿Album_id = t.album_id
   join artist as ar on ar.artist_id = al.artist_id
   group by artist_id, artist_name
   order by 3 desc limit 1 ) 

select c.customer_id, c.first_name, c.last_name, bsa.artist_name,
sum(il.unit_price*il.quantity) as amount_spent from invoice as i 
join customer as c on c.customer_id = i.customer_id
join  invoice_line as il on il.invoice_id = i.invoice_id
join track as t on t.track_id = il.track_id
join album as al on al.ï»¿Album_id = t.album_id
join best_selling_artist as bsa on bsa.artist_id = al.artist_id
group by c.customer_id, c.first_name, c.last_name, bsa.artist_name
order by 5 desc;

/*  Q10: We want to find out the most popular music Genre for each country. We determine the most
popular genre as the genre with the highest amount of purchases. Write a query that returns each country 
along with the top Genre. For countries where the maximum number of purchases is shared return all Genres.  */

with popular_genre as (
select count(il.quantity) as purchases ,c.country, g.name, g.genre_id,
row_number() over(partition by c.country order by count(il.quantity)desc) as Rowno
from invoice_line as il 
join invoice as i on i.invoice_id = il.invoice_id
join customer as c on c.customer_id = i.customer_id
join track as t on t.track_id = il.track_id
join genre as g on g.genre_id = t.genre_id 
group by 2,3,4
order by 2 asc, 1 desc)
select * from popular_genre where Rowno <= 1 ;

/*  Q11: Write a query that determines the customer that has spent the most on music for each 
country. Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount.  */


WITH RECURSIVE
customter_with_country AS (
SELECT c.customer_id, first_name, last_name, billing_country, SUM(total) AS total 
FROM invoice as i
JOIN customer as c ON c.customer_id = i.customer_id 
GROUP BY 1,2,3,4 
ORDER BY 1,5 DESC),

country_max_spending AS(
SELECT billing_country, MAX(total) AS max_spending
FROM customter_with_country
GROUP BY billing_country)
SELECT cc.billing_country, cc.total, cc.first_name, cc.last_name
FROM customter_with_country as cc
JOIN country_max_spending as ms
ON cc.billing_country = ms.billing_country
WHERE cc.total = ms.max_spending
ORDER BY 1;

-- Another way to solve 
WITH Customter_with_country AS (
     SELECT c.customer_id, first_name, last_name, billing_country, SUM(total) AS total_spending, 
     ROW_NUMBER() OVER (PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo
     FROM invoice as i 
     JOIN customer as c ON c.customer_id = i.customer_id
     GROUP BY 1,2,3,4
     ORDER BY 4 ASC,5 DESC)
SELECT * FROM Customter_with_country WHERE RowNo <= 1;

