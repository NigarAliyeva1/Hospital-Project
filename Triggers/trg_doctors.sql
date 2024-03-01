create or replace TRIGGER new_doctor
AFTER INSERT ON doctors
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('New ID: ' || :NEW.doctor_id);
    DBMS_OUTPUT.PUT_LINE('New Name: ' || :NEW.name);
    DBMS_OUTPUT.PUT_LINE('New Specialization: ' || :NEW.specialization);
    DBMS_OUTPUT.PUT_LINE('New Schedule: ' || :NEW.schedule);
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

END;

create or replace TRIGGER update_doctor
AFTER UPDATE ON doctors
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Doctor Updated.');
    DBMS_OUTPUT.PUT_LINE('Old ID: ' || :old.doctor_id);
    DBMS_OUTPUT.PUT_LINE('Old Name: ' || :old.name);
    DBMS_OUTPUT.PUT_LINE('Old Specialization: ' || :old.specialization);
    DBMS_OUTPUT.PUT_LINE('Old Schedule: ' || :old.schedule);

    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

    DBMS_OUTPUT.PUT_LINE('New ID: ' || :NEW.doctor_id);
    DBMS_OUTPUT.PUT_LINE('New Name: ' || :NEW.name);
    DBMS_OUTPUT.PUT_LINE('New Specialization: ' || :NEW.specialization);
    DBMS_OUTPUT.PUT_LINE('New Schedule: ' || :NEW.schedule);

    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');


END;


create or replace TRIGGER delete_doctor
AFTER DELETE ON doctors
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

    DBMS_OUTPUT.PUT_LINE('Doctor Deleted.');
    DBMS_OUTPUT.PUT_LINE('Old ID: ' || :old.doctor_id);
    DBMS_OUTPUT.PUT_LINE('Old Name: ' || :old.name);
    DBMS_OUTPUT.PUT_LINE('Old Specialization: ' || :old.specialization);
    DBMS_OUTPUT.PUT_LINE('Old Schedule: ' || :old.schedule);
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

END;