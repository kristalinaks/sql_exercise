-- Exercise 1

USE sakila;

-- Nomor 1: Customer Active
SELECT customer_id, first_name, last_name, active
FROM customer
WHERE active=1;

-- Nomor 2: Customer yang namanya dimulai dengan Y
SELECT customer_id, first_name, last_name, active
FROM customer
WHERE first_name LIKE "Y%";

-- Nomor 3: Customer yang store_id = 2
SELECT *
FROM customer
WHERE store_id = 2
ORDER BY first_name;

-- Nomor 4: ID Pegawai yang paling sering melayani customer
SELECT staff_id, COUNT(staff_id) AS frekuensi
FROM payment
GROUP BY staff_id;

-- Nomor 5: Customer yg meminjam lebih dari $175
SELECT customer_id, SUM(amount) AS total
FROM payment
GROUP BY customer_id
HAVING total>=175
ORDER BY total DESC;

-- Nomor 6: Durasi film terlama
SELECT title, length, rating, 
	DENSE_RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS ranking
FROM film
WHERE rating="PG";

-- Nomor 7: Banyak stok film Alone Trip
SELECT title, COUNT(inventory_id) AS jmlh
FROM inventory i LEFT JOIN film f
ON i.film_id = f.film_id
WHERE title = "ALONE TRIP";

-- Nomor 8: Aktor yang berperan di film Academy Dinosaur
SELECT title, first_name, last_name
FROM film_actor fa INNER JOIN film f INNER JOIN actor a
ON fa.film_id = f.film_id AND fa.actor_id = a.actor_id
WHERE title = "ACADEMY DINOSAUR";

-- Nomor 9: Top 10 kategori film yg paling banyak dirental xx
SELECT title, rental_rate
FROM film
ORDER BY rental_rate DESC
LIMIT 10;

-- Nomor 10: Kategori film yang paling banyak menghasilkan sales xx
CREATE VIEW TopRental AS
SELECT film_id, COUNT(film_id) AS jmlhRental
FROM rental r 
LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY film_id;

SELECT name, jmlhRental
FROM TopRental t
LEFT JOIN film_category fc ON t.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id
GROUP BY name
ORDER BY jmlhRental DESC;

-- Nomor 11: 5 customer yang paling banyak total pembayarannya
SELECT first_name, last_name, SUM(amount) AS jmlhPembayaran 
FROM payment p
LEFT JOIN customer c ON p.customer_id = c.customer_id
GROUP BY p.customer_id
ORDER BY jmlhPembayaran DESC
LIMIT 5;