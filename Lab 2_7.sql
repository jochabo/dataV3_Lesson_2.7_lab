USE sakila;

-- 1) How many films are there for each of the categories in the category table. 
-- Use appropriate join to write this query.
SELECT * FROM film_category; -- film_id and category_id
SELECT * FROM category; -- category_id

SELECT c.category_id, c.name, COUNT(fc.film_id) AS sum_of_films
FROM sakila.category c
JOIN sakila.film_category fc
USING (category_id)
GROUP BY category_id;

-- 2) Display the total amount rung up by each staff member in August of 2005.
SELECT * FROM staff; -- staff_id
SELECT * FROM payment; -- payment_id, customer_id, staff_id and rental_id

SELECT 
    staff.staff_id, SUM(payment.amount)
FROM
    sakila.payment
        JOIN
    sakila.staff USING (staff_id)
WHERE
    DATE_FORMAT(CONVERT( LEFT(payment_date, 10) , DATE),
            '%m-%y') = '08-05'
GROUP BY staff_id;


-- 3) Which actor has appeared in the most films?

SELECT * FROM film_actor; -- actor_id, film_id
SELECT * FROM actor; -- actor_id

SELECT 
    fa.actor_id,
    COUNT(DISTINCT film_id) AS numbers_of_films,
    a.first_name,
    a.last_name
FROM
    sakila.film_actor fa
        JOIN
    sakila.actor a USING (actor_id)
GROUP BY fa.actor_id , a.first_name , a.last_name
ORDER BY numbers_of_films DESC
LIMIT 1;

-- 4) Most active customer (the customer that has rented the most number of films)
SELECT * FROM customer; -- customer_id
SELECT * FROM rental; -- customer_id, rental_id

SELECT 
    c.customer_id, c.first_name, c.last_name, COUNT(DISTINCT rental_id) AS number_of_rentals
FROM
    sakila.rental r
        JOIN
    sakila.customer c USING (customer_id)
    GROUP BY c.customer_id, c.first_name, c.last_name
    ORDER BY number_of_rentals DESC
LIMIT 1;

-- 5) Display the first and last names, as well as the address, of each staff member.
SELECT * FROM staff; -- first_name and last_name, address_id
SELECT * FROM address; -- address_id, address

SELECT 
    s.first_name,
    s.last_name,
    a.address,
    a.district,
    a.city_id,
    a.postal_code
FROM
    sakila.staff s
        JOIN
    sakila.address a USING (address_id);


-- 6) List each film and the number of actors who are listed for that film.
SELECT * FROM film; -- film_id
SELECT * FROM film_actor; -- film_id, actor_id

SELECT 
    film_id, title, COUNT(actor_id) AS number_of_actors
FROM
    sakila.film f
        JOIN
    sakila.film_actor fa USING (film_id)
GROUP BY film_id , title;

-- 7) Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name.
SELECT * FROM payment; -- customer_id, amount
SELECT * FROM customer; -- customer_id, last_name, first_name

SELECT 
    last_name, first_name, sum(amount) AS total_paid
FROM
    sakila.payment p
        JOIN
    sakila.customer c USING (customer_id)
    GROUP BY last_name, first_name
    ORDER BY last_name;

-- 8) List number of films per category.
SELECT * FROM film_category; -- film_id and category_id
SELECT * FROM category; -- category_id

SELECT c.category_id, c.name, COUNT(fc.film_id) AS sum_of_films
FROM sakila.category c
JOIN sakila.film_category fc
USING (category_id)
GROUP BY category_id;
