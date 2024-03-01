create or replace package pkg_doctors as
    PROCEDURE register_doctor(
    p_name doctors.name%type,
    p_specialization doctors.specialization%type,
    p_schedule doctors.schedule%type
    );
    
    PROCEDURE update_doctor(
    p_doctor_id doctors.doctor_id%type,
    p_name doctors.name%type,
    p_specialization doctors.specialization%type,
    p_schedule doctors.schedule%type
    );
    
    PROCEDURE delete_doctor(
    p_doctor_id doctors.doctor_id%TYPE
    );
end;

create or replace package body pkg_doctors as
    PROCEDURE register_doctor(
    p_name doctors.name%type,
    p_specialization doctors.specialization%type,
    p_schedule doctors.schedule%type
    ) IS  
    BEGIN
        INSERT INTO doctors (name, specialization, schedule)
        VALUES (p_name, p_specialization, p_schedule);
        COMMIT;
    exception
        when dup_val_on_index then
            dbms_output.put_line('Error: Duplicate value');
            log_errors('Register Doctor',sqlcode, sqlerrm);
            rollback;
            
        when no_data_found then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Register Doctor',sqlcode, sqlerrm);
            rollback;
            
        when others then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Register Doctor',sqlcode, sqlerrm);
            rollback;
            raise;
    END;
    
    PROCEDURE update_doctor(
    p_doctor_id doctors.doctor_id%type,
    p_name doctors.name%type,
    p_specialization doctors.specialization%type,
    p_schedule doctors.schedule%type
    ) IS
    v_doctor_id doctors.doctor_id%type;
    BEGIN
    select doctor_id into v_doctor_id from doctors where doctor_id=p_doctor_id;
    UPDATE doctors
        SET 
            name = NVL(p_name, name),
            specialization = NVL(p_specialization, specialization),
            schedule = NVL(p_schedule, schedule)
        WHERE doctor_id = p_doctor_id;
        COMMIT;
    exception
        when no_data_found then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Update Doctor',sqlcode, sqlerrm);
            rollback;
            
        when others then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Update Doctor',sqlcode, sqlerrm);
            rollback;
            raise;
    END;
    
    PROCEDURE delete_doctor(
        p_doctor_id doctors.doctor_id%TYPE
    ) is
    v_doctor_id doctors.doctor_id%TYPE;
    begin
    select doctor_id into v_doctor_id from doctors where doctor_id=p_doctor_id;
    delete from doctors where doctor_id=p_doctor_id;
    commit;
    exception
        when no_data_found then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Delete Doctor',sqlcode, sqlerrm);
            rollback;
            
        when others then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Delete Doctor',sqlcode, sqlerrm);
            rollback;
            raise;
    end;
END;

set serveroutput on;
exec pkg_doctors.register_doctor('Dr. Brown', 'Dentist', '10 am - 5 pm');

set serveroutput on;
exec pkg_doctors.update_doctor(102,'Dr. Smit', 'Cardiologis', '7 am - 5 pm');

set serveroutput on;
exec pkg_doctors.delete_doctor(102);


select * from doctors;
