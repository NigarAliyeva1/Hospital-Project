--This view provides information about appointments, including the appointment ID, time, doctor's name, and patient's name.
CREATE OR REPLACE VIEW doctor_appointments AS
SELECT a.appointment_id, a.appointment_time, d.name AS doctor_name, p.name AS patient_name
FROM appointments a
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN patients p ON a.patient_id = p.patient_id;
