--This view identifies doctors who currently have no appointments, aiding in management and scheduling tasks
CREATE OR REPLACE VIEW doctors_without_appointments AS
SELECT
    d.doctor_id,
    d.name AS doctor_name,
    d.specialization
FROM
    doctors d
WHERE
    NOT EXISTS (
        SELECT 1
        FROM appointments a
        WHERE a.doctor_id = d.doctor_id
