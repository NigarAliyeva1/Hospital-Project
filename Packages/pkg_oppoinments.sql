create or replace package pkg_appointments as
    PROCEDURE book_appointment(
    p_doctor_id appointments.doctor_id%type,
    p_patient_id appointments.patient_id%type,
    p_appointment_time appointments.appointment_time%type
    );
    
    PROCEDURE update_appointment(
    p_appointment_id appointments.appointment_id%type,
    p_doctor_id appointments.doctor_id%type,
    p_patient_id appointments.patient_id%type,
    p_appointment_time appointments.appointment_time%type
    );
    
    PROCEDURE delete_appointment(
    p_appointment_id appointments.appointment_id%type
    );

end;

create or replace package body pkg_appointments as
    PROCEDURE book_appointment(
    p_doctor_id appointments.doctor_id%type,
    p_patient_id appointments.patient_id%type,
    p_appointment_time appointments.appointment_time%type
) IS

BEGIN
    INSERT INTO appointments (doctor_id, patient_id, appointment_time)
    VALUES (p_doctor_id, p_patient_id, p_appointment_time);
    COMMIT;
 exception
        when dup_val_on_index then
            dbms_output.put_line('Error: Duplicate value');
            log_errors('Book Appointment',sqlcode, sqlerrm);
            rollback;
            
            when no_data_found then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Book Appointment',sqlcode, sqlerrm);
            rollback;
            
            when others then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Book Appointment',sqlcode, sqlerrm);
            rollback;
            raise;
    end;

    PROCEDURE update_appointment(
    p_appointment_id appointments.appointment_id%type,
    p_doctor_id appointments.doctor_id%type,
    p_patient_id appointments.patient_id%type,
    p_appointment_time appointments.appointment_time%type
    ) IS
    v_appointment_id appointments.appointment_id%type;
    BEGIN
    select appointment_id into v_appointment_id from appointments where appointment_id=p_appointment_id;
    UPDATE appointments
        SET 
            doctor_id = NVL(p_doctor_id, doctor_id),
            patient_id = NVL(p_patient_id, patient_id),
            appointment_time = NVL(p_appointment_time, appointment_time)
        WHERE appointment_id = p_appointment_id;
        COMMIT;
    exception
        when no_data_found then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Update Appointment',sqlcode, sqlerrm);
            rollback;
            
            when others then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Update Appointment',sqlcode, sqlerrm);
            rollback;
            raise;
    END;
    
    PROCEDURE delete_appointment(
    p_appointment_id appointments.appointment_id%type
    ) is
    v_appointment_id appointments.appointment_id%type;
    begin
    select appointment_id into v_appointment_id from appointments where appointment_id=p_appointment_id;
    delete from appointments where appointment_id=p_appointment_id;
    commit;
    exception
            when no_data_found then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Delete Appointment',sqlcode, sqlerrm);
            rollback;
            
            when others then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Delete Appointment',sqlcode, sqlerrm);
            rollback;
            raise;
    end;
END;

set serveroutput on;
exec pkg_appointments.book_appointment(24, 21,to_date('2023-09-10 10:00:00', 'yyyy.mm.dd hh24:mi:ss'));


set serveroutput on;
exec pkg_appointments.update_appointment(202,100, null,null);


set serveroutput on;
exec pkg_appointments.delete_appointment(201);

select * from appointments;

select * from patients;