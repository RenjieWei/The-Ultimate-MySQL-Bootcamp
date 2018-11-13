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

