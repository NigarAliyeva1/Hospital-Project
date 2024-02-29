CREATE TABLE doctors (
    doctor_id number generated always as identity primary key,
    name VARCHAR2(50),
    specialization VARCHAR2(50),
    schedule VARCHAR2(100)
);

drop table doctors;
