CREATE TABLE appointments (
    appointment_id number generated always as identity primary key,
    doctor_id NUMBER, constraint 
    fk_doctors_doctor_id foreign key (doctor_id) references doctors(doctor_id),
    patient_id NUMBER, constraint 
    fk_patients_patient_id foreign key (patient_id) references patients(patient_id),
    appointment_time TIMESTAMP
);

drop table appointments;

truncate table appointments;