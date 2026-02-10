--- DEPARTMENT

CREATE TABLE Department (
    DeptId INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

INSERT INTO Department (DeptId, DeptName)
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Sales');

select * from Department;

-- EMPLOY TABLE
CREATE TABLE Employee (
    EmpId INT PRIMARY KEY,
    EmpName VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    DeptId INT,
    BonusPoints INT DEFAULT 0,
    FOREIGN KEY (DeptId) REFERENCES Department(DeptId)
);

INSERT INTO Employee (EmpId, EmpName, Email, DeptId, BonusPoints)
VALUES
(101, 'Mahesh', 'mahesh@gmail.com', 1, 0),
(102, 'Anita', 'anita@gmail.com', 2, 0),
(103, 'Rahul', 'rahul@gmail.com', 3, 0),
(104, 'Sneha', 'sneha@gmail.com', 1, 0);


select * from Employee;

-- SALES TABLE
CREATE TABLE Sales (
    SaleId INT IDENTITY PRIMARY KEY,
    EmpId INT,
    SaleDate DATE,
    SaleAmount DECIMAL(10,2),
    FOREIGN KEY (EmpId) REFERENCES Employee(EmpId)
);


INSERT INTO Sales (EmpId, SaleDate, SaleAmount)
VALUES
(101, '2026-01-10', 60000),   -- +10 points
(101, '2026-02-05', 15000),   -- +0
(102, '2026-01-15', 25000),   -- +5
(103, '2026-01-20', 8000),    -- +0
(103, '2026-02-02', 55000);   -- +10


select * from sales;


-- Q2 alter bonus point zero

ALTER TABLE Employee
ADD BonusPoints INT DEFAULT 0;


--Q3  prevent invalid value  reward point shoulde between 0-100
ALTER TABLE Employee
ADD CONSTRAINT CK_Employee_BonusPoints
CHECK (BonusPoints BETWEEN 0 AND 100);


-- it will work and inseted  beacuse the  value is beteenn 0-100.
INSERT INTO Employee (BonusPoints)
VALUES (50);

-- this will give eroor and value not insert
INSERT INTO Employee (EmpId, EmpName, BonusPoints)
VALUES (1, 'Rahul', 150);

---Q4 inner join for employees who have made at least one sale.

SELECT 
    e.EmpName,
    d.DeptName,
    MONTH(s.SaleDate) AS SaleMonth,
    YEAR(s.SaleDate) AS SaleYear,
    s.SaleAmount

FROM Employee e
INNER JOIN Sales s ON e.EmpId = s.EmpId
INNER JOIN Department d ON e.DeptId = d.DeptId;


--Q5 calculate total sales for each employee for the current year.

SELECT 
    e.EmpName,
    SUM(s.SaleAmount) AS TotalSales
FROM Employee e
INNER JOIN Sales s ON e.EmpId = s.EmpId
WHERE YEAR(s.SaleDate) = YEAR(GETDATE())
GROUP BY e.EmpName;

--Q6  creating  a username Mahesh + IT + 101 → MahIT101

SELECT 
    e.EmpName,
    SUBSTRING(e.EmpName, 1, 3) +
    LEFT(d.DeptName, 2) +
    CAST(e.EmpId AS VARCHAR) AS Username
FROM Employee e
INNER JOIN Department d ON e.DeptId = d.DeptId;


--Q7 employees whose total sales amount is greater than the average sales amount of all employees.

SELECT EmpName
FROM Employee
WHERE EmpId IN (
    SELECT EmpId
    FROM Sales
    GROUP BY EmpId
    HAVING SUM(SaleAmount) >
        (SELECT AVG(SaleAmount) FROM Sales)
);


--Q8 sales made (High / Low)    Employees who made sales above ₹50,000 and below ₹10000


SELECT 
    e.EmpName,
    s.SaleAmount,
    'High' AS Category
FROM Sales s
INNER JOIN Employee e ON s.EmpId = e.EmpId
WHERE s.SaleAmount > 50000

UNION

SELECT 
    e.EmpName,
    s.SaleAmount,
    'Low' AS Category
FROM Sales s
INNER JOIN Employee e ON s.EmpId = e.EmpId
WHERE s.SaleAmount < 10000;


---Q9 Whenever a sale is inserted, automatically update BonusPoints. SaleAmount ≥ 50,000 → add 10 points and
--If SaleAmount ≥ 20,000 → add 5 points  else no bonus

-- CREATE TRIGGER trg_UpdateBonusPoints
-- ON Sales
-- AFTER INSERT
-- AS
-- BEGIN
--     UPDATE e
--     SET BonusPoints = BonusPoints +
--         CASE 
--             WHEN i.SaleAmount >= 50000 THEN 10
--             WHEN i.SaleAmount >= 20000 THEN 5
--             ELSE 0
--         END
--     FROM Employee e
--     INNER JOIN inserted i ON e.EmpId = i.EmpId;
-- END;



---Q10 validates whether  Normalization is correct, Trigger worked, 
--Aggregations are correct



SELECT 
    e.EmpName,
    d.DeptName,
    SUM(s.SaleAmount) AS TotalSales,
    e.BonusPoints,
    CASE
        WHEN e.BonusPoints >= 50 THEN 'A'
        WHEN e.BonusPoints BETWEEN 20 AND 49 THEN 'B'
        ELSE 'C'
    END AS PerformanceGrade
FROM Employee e
INNER JOIN Department d ON e.DeptId = d.DeptId
INNER JOIN Sales s ON e.EmpId = s.EmpId
GROUP BY 
    e.EmpName,
    d.DeptName,
    e.BonusPoints;







