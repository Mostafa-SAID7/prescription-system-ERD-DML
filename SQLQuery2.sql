--1.	SELECT: Retrieve all columns from the Doctor table.
SELECT * FROM Doctor;

--2.	ORDER BY: List patients in the Patient table in ascending order of their ages.
SELECT * FROM Patient
ORDER BY Age ASC;

--3.	OFFSET FETCH: Retrieve the first 10 patients from the Patient table, starting from the 5th record.
SELECT * FROM Patient
ORDER BY URNumber
OFFSET 4 ROWS FETCH NEXT 10 ROWS ONLY;
--4.	SELECT TOP: Retrieve the top 5 doctors from the Doctor table.
SELECT TOP 5 * FROM Doctor;

--5.	SELECT DISTINCT: Get a list of unique address from the Patient table.
SELECT DISTINCT Address FROM Patient;

--6.	WHERE: Retrieve patients from the Patient table who are aged 25.
SELECT * FROM Patient
WHERE Age = 25;

--7.	NULL: Retrieve patients from the Patient table whose email is not provided.
SELECT * FROM Patient
WHERE Email IS NULL;

--8.	AND: Retrieve doctors from the Doctor table who have experience greater than 5 years and specialize in 'Cardiology'.
SELECT * FROM Doctor
WHERE YearsOfExperience > 5 AND Specialty = 'Cardiology';

--9.	IN: Retrieve doctors from the Doctor table whose speciality is either 'Dermatology' or 'Oncology'.
SELECT * FROM Doctor
WHERE Specialty IN ('Dermatology', 'Oncology');

--10.	BETWEEN: Retrieve patients from the Patient table whose ages are between 18 and 30.
SELECT * FROM Patient
WHERE Age BETWEEN 18 AND 30;

--11.	LIKE: Retrieve doctors from the Doctor table whose names start with 'Dr.'.
SELECT * FROM Doctor
WHERE Name LIKE 'Dr.%';

--12.	Column & Table Aliases: Select the name and email of doctors, aliasing them as 'DoctorName' and 'DoctorEmail'.
SELECT Name AS DoctorName, Email AS DoctorEmail
FROM Doctor;

--13.	Joins: Retrieve all prescriptions with corresponding patient names.
SELECT Prescription.*, Patient.Name AS PatientName
FROM Prescription
JOIN Patient ON Prescription.PatientID = Patient.URNumber;

--14.	GROUP BY: Retrieve the count of patients grouped by their cities.
SELECT Address AS City, COUNT(*) AS PatientCount
FROM Patient
GROUP BY Address;

--15.	HAVING: Retrieve cities with more than 3 patients.
SELECT Address AS City, COUNT(*) AS PatientCount
FROM Patient
GROUP BY Address
HAVING COUNT(*) > 3;

--16.	GROUPING SETS: Retrieve counts of patients grouped by cities and ages.
SELECT Address AS City, Age, COUNT(*) AS PatientCount
FROM Patient
GROUP BY GROUPING SETS ((Address), (Age));

--17.	CUBE: Retrieve counts of patients considering all possible combinations of city and age.
SELECT Address AS City, Age, COUNT(*) AS PatientCount
FROM Patient
GROUP BY CUBE (Address, Age);

--18.	ROLLUP: Retrieve counts of patients rolled up by city.
SELECT Address AS City, COUNT(*) AS PatientCount
FROM Patient
GROUP BY ROLLUP (Address);

--19.	EXISTS: Retrieve patients who have at least one prescription.
SELECT * FROM Patient
WHERE EXISTS (
    SELECT 1 FROM Prescription WHERE Prescription.PatientID = Patient.URNumber
);

--20.	UNION: Retrieve a combined list of doctors and patients.
SELECT Name, Email FROM Doctor
UNION
SELECT Name, Email FROM Patient;

--21.	Common Table Expression (CTE): Retrieve patients along with their doctors using a CTE.
WITH PatientDoctor AS (
    SELECT p.Name AS PatientName, d.Name AS DoctorName
    FROM Patient p
    JOIN Doctor d ON p.PrimaryDoctorID = d.DoctorID
)
SELECT * FROM PatientDoctor;

--22.	INSERT: Insert a new doctor into the Doctor table.
INSERT INTO Doctor (DoctorID, Name, Email, Phone, Specialty, YearsOfExperience)
VALUES (101, 'Dr. Smith', 'drsmith@example.com', '1234567890', 'Cardiology', 10);

--23.	INSERT Multiple Rows: Insert multiple patients into the Patient table.
INSERT INTO Patient (URNumber, Name, Address, Age, Email, Phone, PrimaryDoctorID)
VALUES 
(1, 'John Doe', 'Geelong', 30, 'john@example.com', '9876543210', 101),
(2, 'Jane Roe', 'Melbourne', 25, 'jane@example.com', '1231231234', 101);

--24.	UPDATE: Update the phone number of a doctor.
UPDATE Doctor
SET Phone = '1112223333'
WHERE DoctorID = 101;

--25.	UPDATE JOIN: Update the city of patients who have a prescription from a specific doctor.
UPDATE Patient
SET Address = 'Newtown'
WHERE URNumber IN (
    SELECT PatientID FROM Prescription WHERE DoctorID = 101
);

--26.	DELETE: Delete a patient from the Patient table.
DELETE FROM Patient
WHERE URNumber = 1;

--27.	Transaction: Insert a new doctor and a patient, ensuring both operations succeed or fail together.
BEGIN TRANSACTION;

INSERT INTO Doctor (DoctorID, Name, Email, Phone, Specialty, YearsOfExperience)
VALUES (102, 'Dr. Jane', 'drjane@example.com', '4445556666', 'Pediatrics', 8);

INSERT INTO Patient (URNumber, Name, Address, Age, Email, Phone, PrimaryDoctorID)
VALUES (3, 'Alice Smith', 'Ballarat', 28, 'alice@example.com', '7778889999', 102);

COMMIT;

--28.	View: Create a view that combines patient and doctor information for easy access.
CREATE VIEW PatientDoctorInfo AS
SELECT p.Name AS PatientName, p.Email AS PatientEmail, d.Name AS DoctorName, d.Email AS DoctorEmail
FROM Patient p
JOIN Doctor d ON p.PrimaryDoctorID = d.DoctorID;

--29.	Index: Create an index on the 'phone' column of the Patient table to improve search performance.
CREATE INDEX idx_phone ON Patient(Phone);

--30.	Backup: Perform a backup of the entire database to ensure data safety.
-- Syntax may vary depending on RDBMS (example for SQL Server)
BACKUP DATABASE PrescriptionSystem
TO DISK = 'C:\Backup\PrescriptionSystem.bak';
