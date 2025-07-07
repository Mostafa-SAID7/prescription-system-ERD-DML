
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Specialty VARCHAR(100),
    YearsOfExperience INT
);

CREATE TABLE Patient (
    URNumber INT PRIMARY KEY,
    Name VARCHAR(100),
    Address TEXT,
    Age INT,
    Email VARCHAR(100),
    Phone VARCHAR(15),
    MedicareCardNumber VARCHAR(20),
    PrimaryDoctorID INT,
    FOREIGN KEY (PrimaryDoctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE PharmaceuticalCompany (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address TEXT,
    Phone VARCHAR(15)
);

CREATE TABLE Drug (
    DrugID INT PRIMARY KEY,
    TradeName VARCHAR(100),
    Strength VARCHAR(50),
    CompanyID INT,
    FOREIGN KEY (CompanyID) REFERENCES PharmaceuticalCompany(CompanyID) ON DELETE CASCADE
);

CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    DrugID INT,
    Date DATE,
    Quantity INT,
    FOREIGN KEY (PatientID) REFERENCES Patient(URNumber),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (DrugID) REFERENCES Drug(DrugID)
);
