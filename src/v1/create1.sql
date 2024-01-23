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

create table Hospital (
    ID PRIMARY KEY,
    name,
    address,
    phone,
    email,
    website,
    director,
    foundation --date
);

create table Department (
    ID PRIMARY KEY,
    type,
    manager,
    bedsOccupied,
    location,
    waitingTime,
    rating,
    hospitalID,
    FOREIGN KEY (hospitalID) REFERENCES Hospital (ID)
);

create table Pharmacy (
    ID PRIMARY KEY,
    profit,
    operatingHours
);

create table Room (
    ID PRIMARY KEY,
    area,
    typeRoom,
    departmentID,
    FOREIGN KEY (departmentID) REFERENCES Department (ID)
);




-- Inventory Information

create table Inventory (
    ID PRIMARY KEY,
    inspectionDate
);

create table Supplier (
    ID PRIMARY KEY,
    deliveryDate
);

create table Item (
    ID PRIMARY KEY,
    label,
    quantity,
    price,
    inventoryID,
    pharmacyID,
    FOREIGN KEY (inventoryID) REFERENCES Inventory(ID),
    FOREIGN KEY (pharmacyID) REFERENCES Pharmacy(ID)
);


-- People Information

create table Patient (
    ID PRIMARY KEY,
    name,
    dateOfBirth,
    gender,
    phone,
    email
);

create table Nurse (
    ID PRIMARY KEY,
    name,
    hourRate,
    typeNurse,
    gender,
    phone,
    email,
    departmentID,
    FOREIGN KEY (departmentID) REFERENCES Department (ID)
);

create table Doctor (
    ID PRIMARY KEY,
    name,
    hourRate,
    hoursWorked,
    gender,
    phone,
    email
);

create table Office (
    ID PRIMARY KEY,
    area,
    doctorID,
    FOREIGN KEY (doctorID) REFERENCES Doctor(ID)
);

create table Specialty (
    ID PRIMARY KEY,
    specialty
);

-- Relations Information

create table Appointment (
    ID PRIMARY KEY,
    date,
    reason,
    status
);

create table Diagnosis (
    patientID,
    doctorID,
    appointmentID,
    disease,
    treatment,
    FOREIGN KEY (patientID) REFERENCES Patient (ID),
    FOREIGN KEY (doctorID) REFERENCES Doctor (ID),
    FOREIGN KEY (appointmentID) REFERENCES Appointment (ID),
    PRIMARY KEY (patientID, doctorID, appointmentID)
);

create table SupplierItem (
    supplierID,
    itemID,
    FOREIGN KEY (supplierID) REFERENCES Supplier (ID),
    FOREIGN KEY (itemID) REFERENCES Item (ID)
    PRIMARY KEY (supplierID, itemID)
);

create table ItemDepartment (
    itemID,
    departmentID,
    FOREIGN KEY (itemID) REFERENCES Item (ID),
    FOREIGN KEY (departmentID) REFERENCES Department (ID),
    PRIMARY KEY (itemID, departmentID)
);

create table DepartmentDoctor (
    departmentID,
    doctorID,
    FOREIGN KEY (departmentID) REFERENCES Department (ID),
    FOREIGN KEY (doctorID) REFERENCES Doctor (ID),
    PRIMARY KEY (departmentID, doctorID)
);


create table DoctorSpecialty (
    doctorID,
    specialtyID,
    FOREIGN KEY (doctorID) REFERENCES Doctor (ID),
    FOREIGN KEY (specialtyID) REFERENCES Specialty (ID),
    PRIMARY KEY (doctorID, specialtyID)
);

create table Medication (
    pharmacyID,
    patientID,
    primaryEffect,
    secondaryEffect,
    name,
    date,
    FOREIGN KEY (pharmacyID) REFERENCES Pharmacy (ID),
    FOREIGN KEY (patientID) REFERENCES Patient (ID),
    PRIMARY KEY (pharmacyID, patientID)
);

create table PatientAppointmentNurse (
    patientID,
    appointmentID,
    nurseID,
    FOREIGN KEY (patientID) REFERENCES Patient (ID),
    FOREIGN KEY (appointmentID) REFERENCES Appointment (ID),
    FOREIGN KEY (nurseID) REFERENCES Nurse (ID),
    PRIMARY KEY (patientID, appointmentID, nurseID)
);