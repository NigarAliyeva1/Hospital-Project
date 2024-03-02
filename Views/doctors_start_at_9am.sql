--It lists doctors who start their appointments at 9:00 AM, helpful for scheduling and resource allocation.
CREATE OR REPLACE VIEW doctors_start_at_9am AS
SELECT
    doctor_id,
    name AS doctor_name,
    specialization
FROM
    doctors
WHERE
    schedule LIKE '%9:00 AM%';
