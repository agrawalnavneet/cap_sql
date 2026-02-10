CREATE TABLE CollegeMaster3 (
    StudentId INT IDENTITY(1,1),
    StudentName VARCHAR(50),
    Gender VARCHAR(10)
);


INSERT INTO CollegeMaster3 (StudentName, Gender) VALUES
('Amit', 'Male'),
('Rahul', 'Male'),
('Arjun', 'Male'),
('Rohit', 'Male'),
('Neha', 'Female'),
('Pooja', 'Female'),
('Anita', 'Female');

select * from CollegeMaster3


CREATE PROCEDURE sp_GetGenderCoun
    @Gender VARCHAR(10),          
    @TC INT OUTPUT       
AS
BEGIN
    BEGIN TRY
        SELECT @TC = COUNT(*)
        FROM CollegeMaster3
        WHERE Gender = @Gender;
    END TRY
    BEGIN CATCH
        SET @TC = -1;  
    END CATCH
END;


-- male count
DECLARE @Result INT;

EXEC sp_GetGenderCoun
    @Gender = 'Male',
    @TC = @Result OUTPUT;

SELECT @Result AS TC;


-- female count

DECLARE @Result INT;

EXEC sp_GetGenderCoun
    @Gender = 'Female',
    @TC = @Result OUTPUT;

SELECT @Result AS TotalFemaleCount;

