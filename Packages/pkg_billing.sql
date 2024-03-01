create or replace package pkg_billing as
    PROCEDURE generate_bill(
    p_appointment_id appointments.appointment_id%type,
    p_total_amount billing.total_amount%type
    );
    
    PROCEDURE update_bill(
    p_bill_id billing.bill_id%type,
    p_total_amount billing.total_amount%type
    );
    
    PROCEDURE pay_bill(
    p_bill_id billing.bill_id%type,
    p_paid_amount billing.paid_amount%type
    );
    
    FUNCTION calculate_outstanding_bills(
    p_patient_id patients.patient_id%type,
    p_paid_amount billing.paid_amount%type,
    p_outstanding_bills patients.outstanding_bills%type
    ) RETURN NUMBER;
end;

create or replace package body pkg_billing as
    PROCEDURE generate_bill(
    p_appointment_id appointments.appointment_id%type,
    p_total_amount billing.total_amount%type
    ) IS
    BEGIN
    
        INSERT INTO billing (appointment_id, total_amount, paid_amount)
        VALUES (p_appointment_id, p_total_amount, 0);
        COMMIT;
    exception
            when dup_val_on_index then
            dbms_output.put_line('Error: Duplicate value');
            log_errors('Generate Bill',sqlcode, sqlerrm);
            rollback;
            
            when no_data_found then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Generate Bill',sqlcode, sqlerrm);
            rollback;
            
            when others then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Generate Bill',sqlcode, sqlerrm);
            rollback;
            raise;
    end;
    
    PROCEDURE update_bill(
    p_bill_id billing.bill_id%type,
    p_total_amount billing.total_amount%type
    ) is
    v_appointment_id appointments.appointment_id%type;
    v_patient_id patients.patient_id%type;
    v_total_amount billing.total_amount%type;
    v_outstanding_bills patients.outstanding_bills%type;
    v_changed_amount number;
    begin
    if p_total_amount is not null then     
    select appointment_id into v_appointment_id from billing where bill_id=p_bill_id;
    select patient_id into v_patient_id from appointments where appointment_id=v_appointment_id;
    select total_amount into v_total_amount from billing where bill_id=p_bill_id;
    v_changed_amount:=p_total_amount-v_total_amount;
    UPDATE patients
        SET 
            outstanding_bills = outstanding_bills+v_changed_amount
        WHERE patient_id = v_patient_id;
        COMMIT;
    end if;
    UPDATE billing
        SET 
            total_amount = NVL(p_total_amount, total_amount)
        WHERE bill_id = p_bill_id;
        COMMIT;
    exception
            when no_data_found then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Update Bill',sqlcode, sqlerrm);
            rollback;
            
            when others then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Update Bill',sqlcode, sqlerrm);
            rollback;
            raise;
    end;
    
    PROCEDURE pay_bill(
    p_bill_id billing.bill_id%type,
    p_paid_amount billing.paid_amount%type
    ) IS
    v_appointment_id appointments.appointment_id%type;
    v_patient_id patients.patient_id%type;
    v_total_amount billing.total_amount%type;
    v_outstanding_bills patients.outstanding_bills%type;
    v_old_bill billing%ROWTYPE;
    begin
    if p_paid_amount is not null then     
    select * into v_old_bill from billing where bill_id=p_bill_id;
    select patient_id into v_patient_id from appointments where appointment_id=v_old_bill.appointment_id;
    --select total_amount into v_total_amount from billing where bill_id=p_bill_id;
    --v_outstanding_bills:=v_old_bill.total_amount-v_old_bill.paid_amount-p_paid_amount;--burada v_paid_amountu da chixmaq lazimdi ki her defe odenile bilsin
    UPDATE patients
        SET 
            outstanding_bills =calculate_outstanding_bills(v_patient_id,p_paid_amount,outstanding_bills)
        WHERE patient_id = v_patient_id;
        COMMIT;
    end if;
    UPDATE billing
        SET 
            paid_amount = NVL(p_paid_amount+v_old_bill.paid_amount, paid_amount)
        WHERE bill_id = p_bill_id;
        COMMIT;
    exception
            when no_data_found then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Pay Bill',sqlcode, sqlerrm);
            rollback;
            
            when others then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Pay Bill',sqlcode, sqlerrm);
            rollback;
            raise;
    END;
    
    FUNCTION calculate_outstanding_bills(
    p_patient_id patients.patient_id%type,
    p_paid_amount billing.paid_amount%type,
    p_outstanding_bills patients.outstanding_bills%type
    ) RETURN NUMBER AS
    v_outstanding_bills patients.outstanding_bills%type;
    BEGIN
        if p_outstanding_bills=0 then
            SELECT SUM(total_amount-p_paid_amount)
            INTO v_outstanding_bills
            FROM billing
            WHERE appointment_id IN (SELECT appointment_id FROM appointments WHERE patient_id = p_patient_id);
        
        else 
            SELECT SUM(p_outstanding_bills-p_paid_amount)
            INTO v_outstanding_bills
            FROM billing
            WHERE appointment_id IN (SELECT appointment_id FROM appointments WHERE patient_id = p_patient_id);
        end if;
        
        RETURN NVL(v_outstanding_bills, 0);
        exception
        when no_data_found then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Calculate Outstanding Bills',sqlcode, sqlerrm);
            rollback;
            
            when others then
            dbms_output.put_line('Error: ' || SQLERRM);
            log_errors('Calculate Outstanding Bills',sqlcode, sqlerrm);
            rollback;
            raise;
    END;

END;

set serveroutput on;
exec pkg_billing.generate_bill(1,7000);

set serveroutput on;
exec pkg_billing.pay_bill(48,100);

select pkg_billing.calculate_outstanding_bills(21) from dual ;

select * from billing;
select * from patients;
