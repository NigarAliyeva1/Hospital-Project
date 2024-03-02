--It lists doctors who work on Mondays and Fridays, assisting in scheduling appointments on specific days.
CREATE OR REPLACE VIEW doctors_work_monday AS
SELECT
    doctor_id,
    name AS doctor_name,
    specialization
FROM
    doctors
WHERE
    schedule LIKE '%Monday%'
    AND schedule LIKE '%Friday%';
