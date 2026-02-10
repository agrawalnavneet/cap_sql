CREATE TABLE Sipmle(
    Id INT identity(1,1) PRIMARY KEY,
    Name varchar(50) not null
);

SELECT name FROM sys.databases;

CREATE DATABASE Simple_query;


SELECT name, is_disabled FROM sys.sql_logins WHERE name = 'sa';

ALTER LOGIN sa WITH PASSWORD = 'StrongPassword@123';


USE Simple_query;

CREATE TABLE Simple
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

INSERT INTO Simple (Name, Age)
VALUES 
('Amit', 25),
('Riya', 21),
('Rahul', 28);



drop table [Simple]

select * from Simple;



