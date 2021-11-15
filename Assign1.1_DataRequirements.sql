

CREATE DATABASE data_requirements ;

CREATE TABLE book(book_id INT PRIMARY KEY, author TEXT, title TEXT, publisher TEXT, edition NUMERIC(2,0), description_id INT, note TEXT);
CREATE TABLE physical_description(description_id INT PRIMARY KEY,no_page INT,size NUMERIC(3,0) );


SELECT * FROM book
SELECT * FROM physical_description

INSERT INTO book VALUES (1 , 'JEN','LOLO','HOME',1,001,'N/A');
