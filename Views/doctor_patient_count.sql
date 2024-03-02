--It gives the count of patients for each doctor, aiding in understanding the distribution of patient workload among doctors.
CREATE OR REPLACE VIEW doctor_patient_count AS
SELECT distinct
    d.doctor_id,
    d.name AS doctor_name,
    d.specialization,
    COUNT(a.patient_id) OVER (PARTITION BY d.doctor_id) AS patient_count
FROM 
    doctors d
LEFT JOIN
    appointments a
ON 
    d.doctor_id = a.doctor_id;
