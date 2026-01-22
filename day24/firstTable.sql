CREATE TABLE Student(
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    student_name VARCHAR(100),
    age INT,
    city VARCHAR(50)
);

INSERT INTO Student(student_name, age, city)
VALUES
('Rahul', 21, 'Delhi'),
('Neha', 22, 'Mumbai');

SELECT * FROM Student1;


CREATE TABLE Student1 (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    subject VARCHAR(50)
);

INSERT INTO Student1 (name, department, subject)
VALUES
('Amit', 'CSE', 'DBMS'),
('Riya', 'IT', 'Operating Systems');

SELECT * FROM Student1;

DROP TABLE Student;
