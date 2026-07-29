create database employee;
use employee;

-- DDL Commands 
-- table creation

create table departments(department_id int,
department_name varchar(100));

create table location(location_id int,
location varchar (30));

create table employees(employee_id int,
employee_name varchar(50),
gender ENUM('M', 'F'),
age int,
hire_date date,
designation varchar(100),
department_id int ,
location_id int ,
salary decimal (10,2));

-- Table Alteration

alter table employees add email varchar(100);
alter table employees modify designation varchar(200);
alter table employees drop age;
alter table employees rename column hire_date to date_of_joining;

-- Table Renaming

rename table departments to Departments_Info;
rename table location to Locations;

--  Table Truncation

TRUNCATE TABLE employees;
DROP TABLE employees;
DROP DATABASE employee;

-- Constraints
--  Database Recreation

create database employee;
use employee;

create table departments(department_id int,
department_name varchar(100));

create table location(location_id int,
location varchar (30));

create table employees(employee_id int,
employee_name varchar(50),
gender ENUM('M', 'F'),
age int,
hire_date date,
designation varchar(100),
department_id int ,
location_id int ,
salary decimal (10,2));

-- Departments Table

ALTER TABLE departments ADD PRIMARY KEY (department_id);
ALTER TABLE departments
MODIFY department_name VARCHAR(100) NOT NULL,
ADD UNIQUE (department_name);

--  Location Table

ALTER TABLE location
MODIFY location_id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE location MODIFY location VARCHAR(30) NOT NULL UNIQUE;

-- Employees Table

ALTER TABLE employees ADD PRIMARY KEY (employee_id);
ALTER TABLE employees MODIFY employee_name VARCHAR(100) NOT NULL;
ALTER TABLE employees ADD CHECK (gender IN ('M', 'F'));
ALTER TABLE employees ADD CHECK (age >= 18);
ALTER TABLE employees MODIFY hire_date DATE DEFAULT (CURRENT_DATE);
ALTER TABLE employees ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE employees ADD FOREIGN KEY (location_id) REFERENCES location(location_id);



