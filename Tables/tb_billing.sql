CREATE TABLE billing (
    bill_id number generated always as identity primary key,
    appointment_id NUMBER,constraint 
    fk_appointments_appointment_id foreign key (appointment_id) references appointments(appointment_id),
    total_amount NUMBER,
    paid_amount NUMBER
);

drop table billing;

truncate table billing;