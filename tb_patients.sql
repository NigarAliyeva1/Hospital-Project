CREATE TABLE patients (
    patient_id number generated always as identity primary key,
    name VARCHAR2(50),
    dob DATE,
    gender VARCHAR2(10),
    medical_history VARCHAR2(100),
    outstanding_bills NUMBER
);


drop table patients;

truncate table patients;

