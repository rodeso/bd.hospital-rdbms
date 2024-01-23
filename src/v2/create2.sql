drop table if exists Hospital;
drop table if exists Supplier;
drop table if exists Item;
drop table if exists Inventory;
drop table if exists Pharmacy;
drop table if exists Specialty;
drop table if exists Office;
drop table if exists Doctor;
drop table if exists Patient;
drop table if exists Appointment;
drop table if exists Diagnosis;
drop table if exists Department;
drop table if exists Room;
drop table if exists Nurse;
drop table if exists SupplierItem;
drop table if exists ItemDepartment;
drop table if exists DepartmentDoctor;
drop table if exists DepartmentRoom;
drop table if exists AppointmentRoom;
drop table if exists DoctorSpecialty;
drop table if exists Medication;
drop table if exists PatientAppointmentNurse;

-- Hospital Information

CREATE TABLE Hospital (
    ID INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    website VARCHAR(255) NOT NULL,
    director VARCHAR(255) NOT NULL,
    foundation DATE NOT NULL
);

CREATE TABLE Department (
    ID INT PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    manager VARCHAR(255) NOT NULL,
    bedsOccupied INT CHECK (bedsOccupied >= 0),  
    location VARCHAR(255) NOT NULL,
    waitingTime INT NOT NULL CHECK (waitingTime >= 0),  
    rating FLOAT CHECK (rating >= 0.0 AND rating <= 10.0),  
    hospitalID INT,
    FOREIGN KEY (hospitalID) REFERENCES Hospital (ID)
);

CREATE TABLE Pharmacy (
    ID INT PRIMARY KEY,
    profit DECIMAL(10, 2) CHECK (profit >= 0.0),  
    operatingHours VARCHAR(255) NOT NULL
);

CREATE TABLE Room (
    ID INT PRIMARY KEY,
    area DECIMAL(10, 2), 
    typeRoom VARCHAR(255),
    departmentID INT,
    FOREIGN KEY (departmentID) REFERENCES Department (ID)
);


-- Inventory Information

CREATE TABLE Inventory (
    ID INT PRIMARY KEY,
    inspectionDate DATE NOT NULL
);

CREATE TABLE Supplier (
    ID INT PRIMARY KEY,
    deliveryDate DATE NOT NULL
);

CREATE TABLE Item (
    ID INT PRIMARY KEY,
    label VARCHAR(255) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),  
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0.0),  
    inventoryID INT,
    pharmacyID INT,
    FOREIGN KEY (inventoryID) REFERENCES Inventory(ID),
    FOREIGN KEY (pharmacyID) REFERENCES Pharmacy(ID)
);


-- People Information

CREATE TABLE Patient (
    ID INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    dateOfBirth DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE Nurse (
    ID INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    hourRate DECIMAL(5, 2) NOT NULL CHECK (hourRate > 0.0),
    typeNurse VARCHAR(255),
    gender VARCHAR(10) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    departmentID INT,
    FOREIGN KEY (departmentID) REFERENCES Department (ID)
);

CREATE TABLE Doctor (
    ID INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    hourRate DECIMAL(5, 2) NOT NULL CHECK (hourRate > 0.0),
    hoursWorked INT NOT NULL CHECK (hoursWorked >= 0),
    gender VARCHAR(10) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE Office (
    ID INT PRIMARY KEY,
    area DECIMAL(10, 2), 
    doctorID INT,
    FOREIGN KEY (doctorID) REFERENCES Doctor(ID)
);

CREATE TABLE Specialty (
    ID INT PRIMARY KEY,
    specialty VARCHAR(255) NOT NULL
);

-- Relations Information

CREATE TABLE Appointment (
    ID INT PRIMARY KEY,
    date DATE NOT NULL,
    reason VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL
);

CREATE TABLE Diagnosis (
    patientID INT,
    doctorID INT,
    appointmentID INT,
    disease VARCHAR(255) NOT NULL,
    treatment VARCHAR(255) NOT NULL,
    FOREIGN KEY (patientID) REFERENCES Patient (ID),
    FOREIGN KEY (doctorID) REFERENCES Doctor (ID),
    FOREIGN KEY (appointmentID) REFERENCES Appointment (ID),
    PRIMARY KEY (patientID, doctorID, appointmentID)
);

CREATE TABLE SupplierItem (
    supplierID INT,
    itemID INT,
    FOREIGN KEY (supplierID) REFERENCES Supplier (ID),
    FOREIGN KEY (itemID) REFERENCES Item (ID),
    PRIMARY KEY (supplierID, itemID)
);

CREATE TABLE ItemDepartment (
    itemID INT,
    departmentID INT,
    FOREIGN KEY (itemID) REFERENCES Item (ID),
    FOREIGN KEY (departmentID) REFERENCES Department (ID),
    PRIMARY KEY (itemID, departmentID)
);

CREATE TABLE DepartmentDoctor (
    departmentID INT,
    doctorID INT,
    FOREIGN KEY (departmentID) REFERENCES Department (ID),
    FOREIGN KEY (doctorID) REFERENCES Doctor (ID),
    PRIMARY KEY (departmentID, doctorID)
);

CREATE TABLE DoctorSpecialty (
    doctorID INT,
    specialtyID INT,
    FOREIGN KEY (doctorID) REFERENCES Doctor (ID),
    FOREIGN KEY (specialtyID) REFERENCES Specialty (ID),
    PRIMARY KEY (doctorID, specialtyID)
);

CREATE TABLE Medication (
    pharmacyID INT,
    patientID INT,
    primaryEffect VARCHAR(255) NOT NULL,
    secondaryEffect VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (pharmacyID) REFERENCES Pharmacy (ID),
    FOREIGN KEY (patientID) REFERENCES Patient (ID),
    PRIMARY KEY (pharmacyID, patientID)
);

CREATE TABLE PatientAppointmentNurse (
    patientID INT,
    appointmentID INT,
    nurseID INT,
    FOREIGN KEY (patientID) REFERENCES Patient (ID),
    FOREIGN KEY (appointmentID) REFERENCES Appointment (ID),
    FOREIGN KEY (nurseID) REFERENCES Nurse (ID),
    PRIMARY KEY (patientID, appointmentID, nurseID)
);