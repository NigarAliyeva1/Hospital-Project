-- Declare a cursor to fetch asthma patient records 
set serveroutput on
DECLARE
    CURSOR patient_cursor IS
        SELECT patient_id, name, dob, gender, medical_history, outstanding_bills
        FROM patients
        WHERE medical_history='Asthma';
    
    v_patient_id patients.patient_id%TYPE;
    v_name patients.name%TYPE;
    v_dob patients.dob%TYPE;
    v_gender patients.gender%TYPE;
    v_medical_history patients.medical_history%TYPE;
    v_outstanding_bills patients.outstanding_bills%TYPE;
BEGIN

    DBMS_OUTPUT.PUT_LINE('Patient Report');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    DBMS_OUTPUT.PUT_LINE('ID | Name | Date of Birth | Gender | Medical History | Outstanding Bills');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');


    OPEN patient_cursor;
    LOOP
        FETCH patient_cursor INTO v_patient_id, v_name, v_dob, v_gender, v_medical_history, v_outstanding_bills;
        EXIT WHEN patient_cursor%NOTFOUND;


        DBMS_OUTPUT.PUT_LINE(v_patient_id || ' | ' || v_name || ' | ' || TO_CHAR(v_dob, 'DD-MON-YYYY') || ' | ' || v_gender || ' | ' || v_medical_history || ' | ' || v_outstanding_bills);
    END LOOP;


    CLOSE patient_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;

-- Declare a cursor to fetch Allergies rareness
DECLARE
    CURSOR medical_count IS
        SELECT  medical_history, count(medical_history)
        FROM patients
        where medical_history like 'Allergies to %'
        group by medical_history;
    
    v_medical_history patients.medical_history%TYPE;
    v_counted_medical_history number;
BEGIN

    DBMS_OUTPUT.PUT_LINE('Patient Report');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    DBMS_OUTPUT.PUT_LINE(' Medical History | Number of patients');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');


    OPEN medical_count;
    LOOP
        FETCH medical_count INTO v_medical_history, v_counted_medical_history;
        EXIT WHEN medical_count%NOTFOUND;


        DBMS_OUTPUT.PUT_LINE(v_medical_history || ' | ' || v_counted_medical_history);
    END LOOP;


    CLOSE medical_count;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
-- Declare a cursor to fetch disease
DECLARE
    CURSOR medical_count IS
        SELECT  medical_history, count(medical_history)
        FROM patients
        group by medical_history;
    
    v_medical_history patients.medical_history%TYPE;
    v_counted_medical_history number;
BEGIN

    DBMS_OUTPUT.PUT_LINE('Patient Report');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    DBMS_OUTPUT.PUT_LINE(' Medical History | Number of patients');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');


    OPEN medical_count;
    LOOP
        FETCH medical_count INTO v_medical_history, v_counted_medical_history;
        EXIT WHEN medical_count%NOTFOUND;


        DBMS_OUTPUT.PUT_LINE(v_medical_history || ' | ' || v_counted_medical_history);
    END LOOP;


    CLOSE medical_count;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
