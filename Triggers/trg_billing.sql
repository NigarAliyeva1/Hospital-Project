create or replace TRIGGER new_bill
AFTER INSERT ON billing
FOR EACH ROW
DECLARE
    v_appointments appointments%ROWTYPE;
    v_doctor_name doctors.name%TYPE;
    v_patient_name patients.name%TYPE;
    v_outstanding_bills patients.outstanding_bills%type;

BEGIN

    SELECT *
    INTO v_appointments
    FROM appointments
    WHERE appointment_id = :NEW.appointment_id;
    
    SELECT name INTO v_doctor_name FROM doctors WHERE doctor_id = v_appointments.doctor_id;
    SELECT name INTO v_patient_name FROM patients WHERE patient_id = v_appointments.patient_id;
    SELECT outstanding_bills INTO v_outstanding_bills FROM patients WHERE name=v_patient_name;

    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('New Bill ID: ' || :NEW.bill_id);
    DBMS_OUTPUT.PUT_LINE('New Doctor''s Name: ' || v_doctor_name);
    DBMS_OUTPUT.PUT_LINE('New Patient''s Name: ' || v_patient_name);
    DBMS_OUTPUT.PUT_LINE('New Appointment ID: ' || :NEW.appointment_id);
    DBMS_OUTPUT.PUT_LINE('New Appointment Time: ' || v_appointments.appointment_time);
    DBMS_OUTPUT.PUT_LINE('New Total Amount: ' || :NEW.total_amount);
    DBMS_OUTPUT.PUT_LINE('New Paid Amount: ' || :NEW.paid_amount);
    DBMS_OUTPUT.PUT_LINE('New Outstanding Bills: ' || v_outstanding_bills); 

    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
END;

create or replace TRIGGER update_BILLING
AFTER UPDATE ON BILLING
FOR EACH ROW
DECLARE
    v_new_appointments appointments%ROWTYPE;
    v_old_appointments appointments%ROWTYPE;
    v_new_doctor_name doctors.name%TYPE;
    v_new_patient_name patients.name%TYPE;
    v_old_doctor_name doctors.name%TYPE;
    v_old_patient_name patients.name%TYPE;
    v_new_outstanding_bills patients.outstanding_bills%type;


BEGIN
SELECT *
    INTO v_new_appointments
    FROM appointments
    WHERE appointment_id = :NEW.appointment_id;
    
    SELECT *
    INTO v_old_appointments
    FROM appointments
    WHERE appointment_id = :OLD.appointment_id;
    
    SELECT name INTO v_new_doctor_name FROM doctors WHERE doctor_id = v_new_appointments.doctor_id;
    SELECT name INTO v_new_patient_name FROM patients WHERE patient_id = v_new_appointments.patient_id;
    SELECT outstanding_bills INTO v_new_outstanding_bills FROM patients WHERE name=v_new_patient_name;
    
    SELECT name INTO v_old_doctor_name FROM doctors WHERE doctor_id = v_old_appointments.doctor_id;
    SELECT name INTO v_old_patient_name FROM patients WHERE patient_id = v_old_appointments.patient_id;

    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Bill Updated.');
    DBMS_OUTPUT.PUT_LINE('Old Bill ID: ' || :OLD.bill_id);
    DBMS_OUTPUT.PUT_LINE('Old Doctor''s Name: ' || v_old_doctor_name);
    DBMS_OUTPUT.PUT_LINE('Old Patient''s Name: ' || v_old_patient_name);
    DBMS_OUTPUT.PUT_LINE('Old Appointment ID: ' || :OLD.appointment_id);
    DBMS_OUTPUT.PUT_LINE('Old Appointment Time: ' || v_old_appointments.appointment_time);
    DBMS_OUTPUT.PUT_LINE('Old Total Amount: ' || :OLD.total_amount);
    DBMS_OUTPUT.PUT_LINE('Old Paid Amount: ' || :OLD.paid_amount); 

    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');


    DBMS_OUTPUT.PUT_LINE('New Bill ID: ' || :NEW.bill_id);
    DBMS_OUTPUT.PUT_LINE('New Doctor''s Name: ' || v_new_doctor_name);
    DBMS_OUTPUT.PUT_LINE('New Patient''s Name: ' || v_new_patient_name);
    DBMS_OUTPUT.PUT_LINE('New Appointment ID: ' || :NEW.appointment_id);
    DBMS_OUTPUT.PUT_LINE('New Appointment Time: ' || v_new_appointments.appointment_time);
    DBMS_OUTPUT.PUT_LINE('New Total Amount: ' || :NEW.total_amount);
    DBMS_OUTPUT.PUT_LINE('New Paid Amount: ' || :NEW.paid_amount);
    DBMS_OUTPUT.PUT_LINE('New Outstanding Bills: ' || v_new_outstanding_bills); 

    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
    
    
END;

