create or replace TRIGGER new_patient
AFTER INSERT ON patients
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('New ID: ' || :NEW.patient_id);
    DBMS_OUTPUT.PUT_LINE('New Name: ' || :NEW.name);
    DBMS_OUTPUT.PUT_LINE('New DOB: ' || :NEW.dob);
    DBMS_OUTPUT.PUT_LINE('New Gender: ' || :NEW.gender);
    DBMS_OUTPUT.PUT_LINE('New Medical History: ' || :NEW.medical_history);
    DBMS_OUTPUT.PUT_LINE('New Outstanding Bills: ' || :NEW.outstanding_bills);
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

END;

create or replace TRIGGER update_patient
AFTER UPDATE ON patients
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

    DBMS_OUTPUT.PUT_LINE('Patient Updated.');
    DBMS_OUTPUT.PUT_LINE('Old ID: ' || :old.patient_id);
    DBMS_OUTPUT.PUT_LINE('Old Name: ' || :old.name);
    DBMS_OUTPUT.PUT_LINE('Old DOB: ' || :old.dob);
    DBMS_OUTPUT.PUT_LINE('Old Gender: ' || :old.gender);
    DBMS_OUTPUT.PUT_LINE('Old Medical History: ' || :old.medical_history);
    DBMS_OUTPUT.PUT_LINE('New Outstanding Bills: ' || :old.outstanding_bills);

    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

    DBMS_OUTPUT.PUT_LINE('New ID: ' || :NEW.patient_id);
    DBMS_OUTPUT.PUT_LINE('New Name: ' || :NEW.name);
    DBMS_OUTPUT.PUT_LINE('New DOB: ' || :NEW.dob);
    DBMS_OUTPUT.PUT_LINE('New Gender: ' || :NEW.gender);
    DBMS_OUTPUT.PUT_LINE('New Medical History: ' || :NEW.medical_history);
    DBMS_OUTPUT.PUT_LINE('New Outstanding Bills: ' || :NEW.outstanding_bills);
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

END;


create or replace TRIGGER delete_patient
AFTER DELETE ON patients
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

    DBMS_OUTPUT.PUT_LINE('Patient Deleted.');
    DBMS_OUTPUT.PUT_LINE('Old ID: ' || :old.patient_id);
    DBMS_OUTPUT.PUT_LINE('Old Name: ' || :old.name);
    DBMS_OUTPUT.PUT_LINE('Old DOB: ' || :old.dob);
    DBMS_OUTPUT.PUT_LINE('Old Gender: ' || :old.gender);
    DBMS_OUTPUT.PUT_LINE('Old Medical History: ' || :old.medical_history);
    DBMS_OUTPUT.PUT_LINE('New Outstanding Bills: ' || :old.outstanding_bills);
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');


END;
