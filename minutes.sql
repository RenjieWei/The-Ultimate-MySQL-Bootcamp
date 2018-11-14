--  CRUD Commands
--  Create 
CREATE TABLE cats 
  ( 
     cat_id INT NOT NULL AUTO_INCREMENT, 
     name   VARCHAR(100), 
     breed  VARCHAR(100), 
     age    INT, 
     PRIMARY KEY (cat_id) 
  ); 

INSERT INTO cats(name, breed, age) 
VALUES ('Ringo', 'Tabby', 4),
       ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);

SELECT database();
 
CREATE DATABASE shirts_db;
 
use shirts_db;
 
SELECT database();
 
CREATE TABLE shirts
  (
    shirt_id INT NOT NULL AUTO_INCREMENT,
    article VARCHAR(100),
    color VARCHAR(100),
    shirt_size VARCHAR(100),
    last_worn INT,
    PRIMARY KEY(shirt_id)
  );
 
DESC shirts;
 
INSERT INTO shirts(article, color, shirt_size, last_worn) 
VALUES
('t-shirt', 'white', 'S', 10),
('t-shirt', 'green', 'S', 200),
('polo shirt', 'black', 'M', 10),
('tank top', 'blue', 'S', 50),
('t-shirt', 'pink', 'S', 0),
('polo shirt', 'red', 'M', 5),
('tank top', 'white', 'S', 200),
('tank top', 'blue', 'M', 15);
 
SELECT * FROM shirts;
 
INSERT INTO shirts(color, article, shirt_size, last_worn) 
VALUES('purple', 'polo shirt', 'medium', 50);
 
SELECT * FROM shirts;
--  Read 
-- * all the column

SELECT * FROM cats;
SELECT name FROM cats;
SELECT name, age FROM cats;

SELECT * FROM cats where age=4;

SELECT cat_id AS id, name FROM cats;
SELECT name AS 'cat name', breed AS 'kitty breed' FROM cats;
DESC cats;

-- Updata
UPDATE cats SET breed='Shorthair' WHERE breed='Tabby';

-- Delete
DELECT FROM cats where name='Egg';
DELECT FROM cats;




-- The world of String functions

-- Run sql files
source fil_ename.sql;

-- Combine Data For Cleaner Output
SELECT author_fname AS first, author_lname AS last, 
  CONCAT(author_fname, ', ', author_lname) AS full
FROM books;

SELECT 
    CONCAT_WS(' - ', title, author_fname, author_lname) 
FROM books;


-- Work with parts of strings

-- SUBSTRING/substr 
SELECT SUBSTRING('Hello World', 1, 4);
SELECT SUBSTRING('Hello World', 4);
SELECT SUBSTRING('Hello World', -4);
SELECT CONCAT
    (
        SUBSTRING(title, 1, 10),
        '...'
    ) AS 'short title'
FROM books;

-- REPLACE
-- The REPLACE() function, as well as the other string functions, only change the query output, they don't affect the actual data in the database.
SELECT REPLACE('Hello World', 'l', '7');

-- REVERSE
SELECT REVERSE('Hello World');

-- Length
SELECT author_lname, CHAR_LENGTH(author_lname) AS 'length' FROM books;

-- Changing Case with UPPER and LOWER
SELECT UPPER('Hello World');
SELECT LOWER('Hello World');



-- Refine Selections

-- Distinct
SELECT DISTINCT author_lname FROM books;
SELECT DISTINCT author_fname, author_lname FROM books;

-- Sorting data
SELECT author_lname FROM books ORDER BY author_lname;
SELECT author_lname FROM books ORDER BY author_lname DESC;
SELECT title, author_fname, author_lname FROM books ORDER BY 2;
SELECT author_fname, author_lname FROM books ORDER BY author_lname, author_fname;

-- Limit the number
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 5;
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 0,5;
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 10,1;

-- Better searching
SELECT title, author_fname FROM books WHERE author_fname LIKE '%da%';
SELECT title, author_fname FROM books WHERE author_fname LIKE 'da%';
SELECT title, author_fname FROM books WHERE author_fname LIKE '%da';

SELECT title FROM books WHERE title LIKE '%\%%'
-- 4 underscores
SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '____';


-- aggregate functions

-- Count
SELECT COUNT(*) FROM books;  
SELECT COUNT(DISTINCT author_fname) FROM books;
SELECT COUNT(DISTINCT author_lname, author_fname) FROM books;
SELECT COUNT(*) FROM books WHERE title LIKE '%the%';

-- 'Group by' summarizes or aggregates identical data into single row
SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_lname;
SELECT CONCAT('In ', released_year, ' ', COUNT(*), ' book(s) released') AS year FROM books GROUP BY released_year;

-- MIN and MAX
SELECT MIN(released_year) FROM books;
SELECT MAX(released_year) FROM books;

-- max page with title ****
SELECT title, pages FROM books WHERE pages = (SELECT Min(pages) FROM books); 
-- fast
SELECT title, pages FROM books ORDER BY pages ASC LIMIT 1;

SELECT author_fname, author_lname, Min(released_year) 
FROM   books 
GROUP  BY author_lname, 
          author_fname;

-- SUM
SELECT author_fname,
       author_lname,
       Sum(pages)
FROM books
GROUP BY
    author_lname,
    author_fname;

-- Average
SELECT released_year, AVG(stock_quantity) 
FROM books 
GROUP BY released_year;

SELECT released_year AS year,
    COUNT(*) AS '# of books',
    AVG(pages) AS 'avg pages'
FROM books
    GROUP BY released_year;


-- Data types

-- Difference between VARCHAR and CHAR: 1.CHAR has a fixed length; 2.CHAR is faster for fixed length

-- Decimal
CREATE TABLE items(price DECIMAL(5,2));

INSERT INTO items(price) VALUES(7);
 
INSERT INTO items(price) VALUES(7987654);
 
INSERT INTO items(price) VALUES(34.88);
 
INSERT INTO items(price) VALUES(298.9999);
 
INSERT INTO items(price) VALUES(1.9999);
 
SELECT * FROM items;

-- Difference between FLOAT,DOUBLE & DECIMAL: 1.CHAR has a fixed length: both are floating-point types and calculations are approximate

-- DATES & TIMES & DATETIME

CREATE TABLE people (name VARCHAR(100), birthdate DATE, birthtime TIME, birthdt DATETIME);
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Padma', '1983-11-11', '10:07:35', '1983-11-11 10:07:35');

-- CURDATE() -current DATE 
-- CURTIME() -current TIME
-- NOW() -current DATETIME

-- Format of DATE
SELECT DATE_FORMAT(birthdt, 'Was born on a %W') FROM people;
 
SELECT DATE_FORMAT(birthdt, '%m/%d/%Y') FROM people;
 
SELECT DATE_FORMAT(birthdt, '%m/%d/%Y at %h:%i') FROM people;

-- DATE ARITHMETIC

-- DATEDIFF-return day
SELECT DATEDIFF(NOW(), birthdate) FROM people;

-- DATE_ADD
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 10 SECOND) FROM people;

-- +/-
SELECT birthdt, birthdt + INTERVAL 1 MONTH FROM people;

-- Adding timestamp into data



-- Logical Operators
SELECT title FROM books WHERE released_year != 2017;
SELECT title FROM books WHERE title NOT LIKE 'W%';
SELECT title, released_year FROM books WHERE released_year >= 2000 ORDER BY released_year;

SELECT 9 > -10
-- true
 
SELECT 1 > 1
-- false
 
SELECT 'A' >=  'a'
-- true

SELECT 'h' < 'p';
-- true
 
SELECT 'Q' <= 'q';
-- true


SELECT title, author_lname, released_year FROM books WHERE released_year > 2010 && author_lname='Eggers';
SELECT title, author_lname, released_year FROM books WHERE released_year > 2010 and author_lname='Eggers';

SELECT title, author_lname, released_year FROM books WHERE released_year > 2010 || author_lname='Eggers';
SELECT title, author_lname, released_year FROM books WHERE released_year > 2010 or author_lname='Eggers';

SELECT title, released_year FROM books WHERE released_year BETWEEN 2004 AND 2015;
SELECT title, released_year FROM books WHERE released_year NOT BETWEEN 2004 AND 2015;

SELECT title, author_lname FROM booksWHERE author_lname IN ('Carver', 'Lahiri', 'Smith');
SELECT title, author_lname FROM booksWHERE author_lname NOT IN ('Carver', 'Lahiri', 'Smith');

-- CASE statements
SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books;

SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity <= 50 THEN '*'
        WHEN stock_quantity <= 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books; 



-- Type of data relationship

--------- one to one 


---------  one to many ***

-- Working With Foreign Keys
CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);


-- Cross join
-- Finding Orders Placed By George: Using a subquery

SELECT * FROM orders WHERE customer_id =
    (
        SELECT id FROM customers
        WHERE last_name='George'
    );

SELECT * FROM customers, orders;

-- Inner join
-- Explicit inner join
SELECT first_name, last_name, order_date, amount
FROM customers, orders 
    WHERE customers.id = orders.customer_id;

SELECT first_name, last_name, order_date, amount 
FROM customers
JOIN orders
    ON customers.id = orders.customer_id
ORDER BY amount ;

-- left join
SELECT 
    first_name, 
    last_name,
    IFNULL(SUM(amount), 0) AS total_spent
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent;

-- right join
SELECT * FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id;

-- DELETE CASCADE
CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) 
        REFERENCES customers(id)
        ON DELETE CASCADE
);

SELECT first_name, 
       Ifnull(Avg(grade), 0) AS average, 
       CASE 
         WHEN Avg(grade) IS NULL THEN 'FAILING' 
         WHEN Avg(grade) >= 75 THEN 'PASSING' 
         ELSE 'FAILING' 
       end                   AS passing_status 
FROM   students 
       LEFT JOIN papers 
              ON students.id = papers.student_id 
GROUP  BY students.id 
ORDER  BY average DESC;

--------- many to many ***

-- CREATING THE REVIEWERS TABLE
CREATE TABLE reviewers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);
-- CREATING THE SERIES TABLE

CREATE TABLE series(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    released_year YEAR(4),
    genre VARCHAR(100)
);
-- CREATING THE REVIEWS TABLE

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rating DECIMAL(2,1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY(series_id) REFERENCES series(id),
    FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
);
-- INSERTING A BUNCH OF DATA

INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
 
 
INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
 
INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);

-- challenge 1
SELECT title, rating
FROM reviews
JOIN series 
    ON reviews.series_id = series.id;
    
-- challenge 2
SELECT title, AVG(rating) as avg_rating
FROM reviews
JOIN series 
    ON reviews.series_id = series.id
    GROUP BY title
    ORDER BY avg_rating;
    
-- challenge 3
SELECT first_name, last_name, rating
FROM reviews
JOIN reviewers
 on reviews.reviewer_id = reviewers.id;

-- challenge 4
SELECT title AS unreviewed_series
FROM series
LEFT JOIN reviews
    ON series.id = reviews.series_id
WHERE rating IS NULL;

-- challenge 5
SELECT genre, round(avg(rating),2) as avg_rating
FROM series
JOIN reviews
    ON reviews.series_id = series.id
    GROUP BY genre;

-- challenge 6
SELECT first_name, 
       last_name, 
       Count(rating)                               AS COUNT, 
       Ifnull(Min(rating), 0)                      AS MIN, 
       Ifnull(Max(rating), 0)                      AS MAX, 
       Round(Ifnull(Avg(rating), 0), 2)            AS AVG, 
       IF(Count(rating) > 0, 'ACTIVE', 'INACTIVE') AS STATUS 
FROM   reviewers 
       LEFT JOIN reviews 
              ON reviewers.id = reviews.reviewer_id 
GROUP  BY reviewers.id; 

SELECT first_name, 
       last_name, 
       Count(rating)                    AS COUNT, 
       Ifnull(Min(rating), 0)           AS MIN, 
       Ifnull(Max(rating), 0)           AS MAX, 
       Round(Ifnull(Avg(rating), 0), 2) AS AVG, 
       CASE 
         WHEN Count(rating) >= 10 THEN 'POWER USER' 
         WHEN Count(rating) > 0 THEN 'ACTIVE' 
         ELSE 'INACTIVE' 
       end                              AS STATUS 
FROM   reviewers 
       LEFT JOIN reviews 
              ON reviewers.id = reviews.reviewer_id 
GROUP  BY reviewers.id; 

-- challenge 7
SELECT 
    title,
    rating,
    CONCAT(first_name,' ', last_name) AS reviewer
FROM reviewers
INNER JOIN reviews 
    ON reviewers.id = reviews.reviewer_id
INNER JOIN series
    ON series.id = reviews.series_id
ORDER BY title;

