--Student no:	C3238805
--Assign 1
--COMP1140

CREATE DATABASE assignment1;		--NEW database

go
USE assignment1;
/*------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE movable(resource_id INT PRIMARY KEY NOT NULL , name VARCHAR(50),make VARCHAR(50),manufacturer VARCHAR(50),model VARCHAR(50),year NUMERIC(4,0), asset_value NUMERIC(4,0), maxTime_borrow CHAR(10)); --movable Table.
SELECT * FROM movable;
DELETE FROM movable;
DROP TABLE movable;

INSERT INTO movable VALUES (1,'camera','Sony','Sony pty ltd','S01',2012,2530,'48 (hrs)');
INSERT INTO movable VALUES (2,'earphone','boss','boss pty ltd','bs001',2020,5000,'24 (hrs)');


/*------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE immovable(resource_id INT PRIMARY KEY,name VARCHAR(50),capacity NUMERIC(3,0), maxTime_borrow CHAR(10) );--immovable Table
SELECT * FROM immovable;
DELETE FROM immovable;
DROP TABLE immovable;

INSERT INTO immovable VALUES (3,'class room',300,'4 (hrs)');
INSERT INTO immovable VALUES (4,'reading room',10,'6 (hrs)');

/*------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE locations(location_id INT PRIMARY KEY,room NUMERIC(4,0),building VARCHAR(50), campus VARCHAR(50) );--location Table
SELECT * FROM locations;
DELETE FROM locations;
DROP TABLE locations;

INSERT INTO locations VALUES (1,409,'ES','Callaghan');
INSERT INTO locations VALUES (2,201,'EA','Callaghan');
INSERT INTO locations VALUES (3,888,'Hunter','Callaghan');

/*------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE presentStatus(status_no INT PRIMARY KEY,present_status VARCHAR(50)); -- ADD resource present status.
SELECT * FROM presentStatus;
DELETE FROM presentStatus;
DROP TABLE presentStatus;

INSERT INTO presentStatus VALUES (1,'In use');
INSERT INTO presentStatus VALUES (2,'Maintenace');
INSERT INTO presentStatus VALUES (3,'Available');
INSERT INTO presentStatus VALUES (4,'Borrowed');
INSERT INTO presentStatus VALUES (5,'Lost');
INSERT INTO presentStatus VALUES (6,'Damaged');


/*------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE resource(resource_id INT PRIMARY KEY,description VARCHAR(50),status_no INT FOREIGN KEY REFERENCES presentStatus(status_no),location_id INT FOREIGN KEY REFERENCES locations(location_id) ,category_code INT FOREIGN KEY REFERENCES category(category_code));		--ADD resource Table.
SELECT * FROM resource;
DELETE FROM resource;
DROP TABLE resource;

INSERT INTO resource VALUES(1,'photo',1,1,1);
INSERT INTO resource VALUES(2,'music',2,2,2);
INSERT INTO resource VALUES(3,'lecture',3,3,1);
INSERT INTO resource VALUES(4,'reading',4,3,1);


-----------------------------------TEST Movable resources --------------------------------------------------------------------

SELECT resource.resource_id,movable.name,movable.make,movable.manufacturer,movable.model,movable.year,movable.asset_value,movable.maxTime_borrow,locations.location_id,locations.room,locations.building,locations.campus FROM ((resource		
INNER JOIN movable ON resource.resource_id = movable.resource_id)
INNER JOIN locations ON resource.location_id = locations.location_id);
------------------------------------------------------------ --------------------------------------------------------------------
-----------------------------------TEST Immovable resources --------------------------------------------------------------------
SELECT resource.resource_id,immovable.name,immovable.capacity,immovable.maxTime_borrow,locations.location_id,locations.room,locations.building,locations.campus FROM ((resource		
INNER JOIN immovable ON resource.resource_id = immovable.resource_id)
INNER JOIN locations ON resource.location_id = locations.location_id);

/*------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE category(category_code INT PRIMARY KEY, name VARCHAR(50), description VARCHAR(50), maxTime_borrow CHAR(10)); --ADD category.
SELECT * FROM category;
DELETE FROM category;
DROP TABLE category;

INSERT INTO category VALUES(1,'CIVIL','year1','36 (hrs)');
INSERT INTO category VALUES(2,'software','year2','18 (hrs)');

/*----------------------------------------Display resources in all category-----------------------------------------------------------------*/

SELECT category.category_code ,category.name, category.description, category.maxTime_borrow,resource.resource_id,movable.name,immovable.name  FROM (((category 
LEFT JOIN resource ON resource.category_code = category.category_code)
LEFT JOIN movable ON resource.resource_id = movable.resource_id)
LEFT JOIN immovable ON resource.resource_id = immovable.resource_id);

/*--------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE members (member_id INT PRIMARY KEY,name VARCHAR(50), address VARCHAR(50), phone NUMERIC (10),email VARCHAR(50),status VARCHAR(50),comments_field VARCHAR(50));
SELECT * FROM members;
DELETE FROM members;
DROP TABLE members;

INSERT INTO members VALUES (1001,'jenny','31 waterside',0426884330,'a719824@gmail.com','Valid',NULL);
INSERT INTO members VALUES (1002,'YU','28 waterside',000000,'YU@gmail.com','Valid',NULL);
INSERT INTO members VALUES (1003,'nuoya','31 waterside',0424312072,'nuoya@gmail.com','Valid',NULL);
INSERT INTO members VALUES (1004,'shan',NULL,NULL,NULL,'Valid',NULL)

/*------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE staff(member_id INT PRIMARY KEY,resource_id INT FOREIGN KEY REFERENCES resource(resource_id));
SELECT * FROM staff;
DELETE FROM staff;
DROP TABLE staff;

INSERT INTO staff VALUES (1002,1);
INSERT INTO staff VALUES (1004,3);

--------Display staff loanding resources
SELECT staff.member_id,staff.resource_id,movable.name,immovable.name FROM (((staff
LEFT JOIN resource ON resource.resource_id = staff.resource_id )
LEFT JOIN movable ON movable.resource_id = staff.resource_id)
LEFT JOIN immovable ON immovable.resource_id = staff.resource_id);

/*---------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE course(course_id INT PRIMARY KEY, name VARCHAR(50), member_id INT FOREIGN KEY REFERENCES members(member_id) );
SELECT * FROM course;
DELETE FROM course;
DROP TABLE course;

INSERT INTO course VALUES(1140,'data management',1001);
INSERT INTO course VALUES(1050,'web data',NULL);
INSERT INTO course VALUES (1120,'data structure',1001);

/*---------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE course_offering(offering_id INT PRIMARY KEY, course_id INT FOREIGN KEY REFERENCES course(course_id), name VARCHAR(50),semester_offered NUMERIC(4,0), date_begins DATE, date_ends DATE);
SELECT * FROM course_offering;
DELETE FROM course_offering;
DROP TABLE course_offering;




/*---------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE students(member_id INT PRIMARY KEY, offering_id INT FOREIGN KEY REFERENCES course_offering(offering_id), points INT);
SELECT * FROM students;
DELETE FROM students;
DROP TABLE students;




/*---------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE non_privilege(member_id INT FOREIGN KEY REFERENCES members(member_id),privilege_status VARCHAR(50));      --ADD table for non_privilege student.
SELECT * FROM non_privilege;
DELETE FROM non_privilege;
DROP TABLE non_privilege;

INSERT INTO non_privilege VALUES (1003,'disable');


--------display non_privilege info
SELECT non_privilege.member_id, members.name ,non_privilege.privilege_status,members.status  FROM (non_privilege
INNER JOIN members ON members.member_id = non_privilege.member_id );

/*---------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE privilege(member_id INT FOREIGN KEY REFERENCES members(member_id),course_id INT FOREIGN KEY REFERENCES course(course_id), 
						name VARCHAR(50), description VARCHAR(50), category_code INT FOREIGN KEY REFERENCES category(category_code), max_resources_borrowed CHAR(10));
SELECT * FROM privilege;
DELETE FROM privilege;
DROP TABLE privilege;

INSERT INTO privilege VALUES(1001,1140,'data management',NULL,1,'48 (hrs)');
INSERT INTO privilege VALUES(1002,1050,NULL,'YEAR1',2,'16 (HRS)');

/*-------------------Display information of ALL resources ------------------------------------------------------------------*/


/*-------------------Display information of ALL resources ------------------------------------------------------------------*/

