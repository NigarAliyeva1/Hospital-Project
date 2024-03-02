--This view offers details about billing and financial aspects related to appointments, including patient ID, bill ID, total amount, paid amount, and outstanding bills.
CREATE OR REPLACE VIEW bill_details AS
select a.patient_id,b.bill_id,b.total_amount, b.paid_amount, p.outstanding_bills 
from patients p
join appointments a on p.patient_id=a.patient_id 
join billing b on a.appointment_id=b.appointment_id;
