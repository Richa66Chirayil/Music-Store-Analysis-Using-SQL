-- Q1) Who is the senior most employee based on job title?

Select last_name, first_name, title
From employee
order by levels desc
limit 1; 


-- Q2) Which countries have the most invoices?

SELECT count(invoice_id) invoices, billing_country
FROM invoice
GROUP BY billing_country
ORDER BY invoices desc
limit 5;


-- Q3) What are top 3 value of total invoice?

SELECT total, invoice_id
FROM invoice
ORDER BY total desc
LIMIT 3;


-- Q4) Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns one city that has the highest sum of invoice totals. Return both the city name and sum of all invoice totals.

SELECT round(sum(total), 2) invoice, billing_city
FROM invoice
GROUP BY billing_city 
ORDER BY 1 desc
limit 1;


-- Q5) Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that return the person who has spent the most money.

SELECT customers.first_name, customers.last_name, ROUND(sum(invoice.total), 2) as Total
FROM customers join invoice
on customers.customer_id = invoice.customer_id
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 1;


------------------------------------------------------- MODERATE --------------------------------------------------------------------


-- Q1) Write query to return the email, first name, last name, & Genre of all Rock Music listerners. 
-- Return your list ordered alphabetically by email starting with A.

SELECT DISTINCT email, first_name, last_name
From customers JOIN invoice
ON customers.customer_id = invoice.customer_id
JOIN invoice_line 
ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
SELECT track_id
FROM track JOIN genre
ON track.genre_id = genre.genre_id
WHERE genre.name = "ROCK")
ORDER BY email;


-- Q2) Let's invite the artists who have written the most rock music in our dataset.
-- Write a query that returns the Artist name and total track count of the top 10 rock bands.

SELECT artist.name, count(artist.artist_id) as no_of_songs
FROM track JOIN album
ON track.album_id = album.album_id
JOIN artist
ON artist.artist_id = album.artist_id
JOIN genre
ON genre.genre_id = track.genre_id
Where genre.name = "ROCK"
GROUP BY artist.name
ORDER BY 2 DESC
limit 10;


-- Q3) Return all the track names that have a song length longer than the average song length.
-- Return the name and milliseconds for each track. Order by the song length with longest songs listed first.

SELECT name, milliseconds
FROM track
WHERE milliseconds > (
SELECT avg(milliseconds)
FROM track)
ORDER BY 2 DESC;

