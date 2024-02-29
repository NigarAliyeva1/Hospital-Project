create or replace package pkg_patients as
    PROCEDURE register_patient(
    p_name patients.name%type,
    p_dob patients.dob%type,
    p_gender patients.gender%type,
    p_medical_history patients.medical_history%type
    );

    PROCEDURE update_patient(
    p_patient_id patients.patient_id%type,
    p_name patients.name%type,
    p_dob patients.dob%type,
    p_gender patients.gender%type,
    p_medical_history patients.medical_history%type
    );
    
    PROCEDURE delete_patient(
        p_patient_id patients.patient_id%TYPE
    );
end;

create or replace package body pkg_patients as
    PROCEDURE register_patient(
        p_name patients.name%type,
        p_dob patients.dob%type,
        p_gender patients.gender%type,
        p_medical_history patients.medical_history%type
    ) IS  
    BEGIN
        INSERT INTO patients ( name, dob, gender, medical_history, outstanding_bills)
        VALUES (p_name, p_dob, p_gender, p_medical_history, 0);
        COMMIT;
    exception
            when dup_val_on_index then
            dbms_output.put_line('Error: Duplicate value');
            log_errors('Register Patient',sqlcode, sqlerrm);
            rollback;
            
            when no_data_found then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Register Patient',sqlcode, sqlerrm);
            rollback;
            
            when others then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Register Patient',sqlcode, sqlerrm);
            rollback;
            raise;
    end;
    
    PROCEDURE update_patient(
    p_patient_id patients.patient_id%type,
    p_name patients.name%type,
    p_dob patients.dob%type,
    p_gender patients.gender%type,
    p_medical_history patients.medical_history%type
   
    ) is 
    v_patient_id patients.patient_id%type;
    begin
    select patient_id into v_patient_id from patients where patient_id=v_patient_id;

    UPDATE patients
        SET 
            name = NVL(p_name, name),
            dob = NVL(p_dob, dob),
            gender = NVL(p_gender, gender),
            medical_history = NVL(p_medical_history, medical_history)
        WHERE patient_id = p_patient_id;
        COMMIT;
    exception
            when no_data_found then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Update Patient',sqlcode, sqlerrm);
            rollback;
            
            when others then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Update Patient',sqlcode, sqlerrm);
            rollback;
            raise;
    end;
    
    PROCEDURE delete_patient(
        p_patient_id patients.patient_id%TYPE
    ) is
    v_patient_id patients.patient_id%TYPE;
    begin
    select patient_id into v_patient_id from patients where patient_id=p_patient_id;
    delete from patients where patient_id=p_patient_id;
    commit;

    exception
            when no_data_found then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Delete Patient',sqlcode, sqlerrm);
            rollback;
            
            when others then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Delete Patient',sqlcode, sqlerrm);
            rollback;
            raise;
    end;
END;





set serveroutput on;
EXEC pkg_patients.update_patient(103,'Jannie',null,null,null);

set serveroutput on;
exec pkg_patients.register_patient('aaa',TO_DATE('1994-05-15', 'YYYY-MM-DD'),'Female','Previous surgeries include appendectomy in 2005.');

set serveroutput on;
exec pkg_patients.delete_patient(103);

select * from patients;
