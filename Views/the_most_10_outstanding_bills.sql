--This view prioritizes patients based on outstanding bills, listing the top 10 patients with the highest outstanding bills.
CREATE OR REPLACE VIEW the_most_10_outstanding_bills AS
SELECT
    patient_id,
    name AS patient_name,
    outstanding_bills
FROM
    patients
ORDER BY
    outstanding_bills DESC
FETCH FIRST 10 ROWS ONLY;
