create or replace TRIGGER new_appointment
AFTER INSERT ON appointments
FOR EACH ROW
DECLARE
    v_doctor_name doctors.name%TYPE;
    v_patient_name patients.name%TYPE;

BEGIN
    SELECT name INTO v_doctor_name FROM doctors WHERE doctor_id = :NEW.doctor_id;
    SELECT name INTO v_patient_name FROM patients WHERE patient_id = :NEW.patient_id;
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('New ID: ' || :new.appointment_id);
    DBMS_OUTPUT.PUT_LINE('New Doctor''s Name: ' || v_doctor_name);
    DBMS_OUTPUT.PUT_LINE('New Patient''s Name: ' || v_patient_name);
    DBMS_OUTPUT.PUT_LINE('New Appointment Time: ' || :NEW.appointment_time);
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

END;

create or replace TRIGGER update_appointment
AFTER UPDATE ON appointments
FOR EACH ROW
DECLARE
    v_new_doctor_name doctors.name%TYPE;
    v_new_patient_name patients.name%TYPE;
    v_old_doctor_name doctors.name%TYPE;
    v_old_patient_name patients.name%TYPE;
BEGIN
    SELECT name INTO v_new_doctor_name FROM doctors WHERE doctor_id = :NEW.doctor_id;
    SELECT name INTO v_new_patient_name FROM patients WHERE patient_id = :NEW.patient_id;
    SELECT name INTO v_old_doctor_name FROM doctors WHERE doctor_id = :OLD.doctor_id;
    SELECT name INTO v_old_patient_name FROM patients WHERE patient_id = :OLD.patient_id;
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Appointment Updated.');
    DBMS_OUTPUT.PUT_LINE('Old ID: ' || :old.appointment_id);
    DBMS_OUTPUT.PUT_LINE('Old Doctor''s Name: ' || v_old_doctor_name);
    DBMS_OUTPUT.PUT_LINE('Old Patient''s Name: ' || v_old_patient_name);
    DBMS_OUTPUT.PUT_LINE('Old Appointment Time: ' || :OLD.appointment_time);
    
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('New ID: ' || :new.appointment_id);
    DBMS_OUTPUT.PUT_LINE('New Doctor''s Name: ' || v_new_doctor_name);
    DBMS_OUTPUT.PUT_LINE('New Patient''s Name: ' || v_new_patient_name);
    DBMS_OUTPUT.PUT_LINE('New Appointment Time: ' || :NEW.appointment_time);
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

    
END;



create or replace TRIGGER delete_appointments
AFTER DELETE ON appointments
FOR EACH ROW
DECLARE
    v_old_doctor_name doctors.name%TYPE;
    v_old_patient_name patients.name%TYPE;
BEGIN
    SELECT name INTO v_old_doctor_name FROM doctors WHERE doctor_id = :OLD.doctor_id;
    SELECT name INTO v_old_patient_name FROM patients WHERE patient_id = :OLD.patient_id;
    DBMS_OUTPUT.PUT_LINE('Appointment Deleted.');
    DBMS_OUTPUT.PUT_LINE('Old ID: ' || :old.appointment_id);
    DBMS_OUTPUT.PUT_LINE('Old Doctor''s Name: ' || v_old_doctor_name);
    DBMS_OUTPUT.PUT_LINE('Old Patient''s Name: ' || v_old_patient_name);
    DBMS_OUTPUT.PUT_LINE('Old Appointment Time: ' || :OLD.appointment_time);
END;