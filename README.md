# Hospital Management System

This repository contains the code for a Hospital Management System implemented in a relational database system using Oracle SQL. It includes triggers, procedures, views, cursors, and packages to manage patients, doctors, appointments, billing, and error logging within the hospital.

## Setup Instructions

1. **Database Setup**: Ensure you have an Oracle SQL database instance set up. You can execute the provided SQL scripts in your database management tool or IDE.

2. **Running SQL Scripts**: Execute the SQL scripts in the following order to create the necessary tables, triggers, procedures, views, cursors, and packages:
   - `create_tables.sql`: Creates the required tables for patients, doctors, appointments, billing, and error logging.
   - `create_triggers.sql`: Defines triggers for various operations such as insert, update, and delete on patients, doctors, appointments, billing, and error logging tables.
   - `create_procedures.sql`: Defines procedures for registering patients and doctors, booking appointments, paying bills, generating bills, and error logging.
   - `create_views.sql`: Defines views for querying appointment details, doctor-patient counts, bill details, and more.
   - `create_cursors.sql`: Defines cursors for fetching specific patient records, allergies rarity, disease counts, and more.
   - `create_packages.sql`: Defines packages containing related procedures and functions for patient registration, doctor registration, appointment booking, bill payment, bill generation, and error logging.
![Relational_1](https://github.com/NigarAliyeva1/Hospital-Project/assets/112957859/d0d5fd68-fa2a-4c6e-a958-ac95bebfe2a8)

3. **Executing Procedures and Using Cursors**: Utilize the provided procedures to register patients and doctors, book appointments, pay bills, generate bills, and log errors. Cursors are used for fetching and processing data in various scenarios. Example procedure executions and cursor usage are provided in the SQL script `example_procedure_executions.sql`.

## Contents

- `create_tables.sql`: SQL script to create database tables.
- `create_triggers.sql`: SQL script to create triggers for database operations.
- `create_procedures.sql`: SQL script to create stored procedures for various operations.
- `create_views.sql`: SQL script to create views for data querying.
- `create_cursors.sql`: SQL script to define cursors for data fetching and processing.
- `create_packages.sql`: SQL script to define packages containing related procedures and functions.
- `example_procedure_executions.sql`: SQL script with examples for executing procedures and using cursors.
- `README.md`: This file providing an overview of the project.

## Packages Overview

1. **pkg_patients**: Contains procedures for registering patients.
2. **pkg_doctors**: Contains procedures for registering doctors.
3. **pkg_appointments**: Contains procedures for booking appointments.
4. **pkg_billing**: Contains procedures for paying bills and generating bills.

### `log_errors` Procedure

The `log_errors` procedure is a standalone procedure used for logging errors encountered during the execution of various operations in the Hospital Management System. It accepts parameters such as the calling program, error code, and error description, and inserts the error details into the `error_log` table for later analysis and debugging.

**Parameters:**
- `p_calling_program`: The name or identifier of the program or procedure where the error occurred.
- `p_error_code`: An integer representing the error code or category.
- `p_error_description`: A string describing the error encountered.

**Usage Example:**
```sql
BEGIN
  log_errors('procedure_name', 1001, 'Error description');
END;
```

## Views Overview

1. **Doctor Appointments**: Provides a list of appointments with associated doctor and patient names.
2. **Doctor Patient Count**: Displays the count of patients assigned to each doctor.
3. **Bill Details**: Presents details of bills including total amount, paid amount, and outstanding bills.
4. **Doctors Start at 9 AM**: Lists doctors with a schedule starting at 9 AM.
5. **Doctors Without Appointments**: Lists doctors who currently do not have any appointments.
6. **Doctors Work Monday**: Lists doctors who work on Mondays.

## Contributing

Contributions to improve or extend the functionality of this Hospital Management System are welcome! Feel free to open an issue or submit a pull request.

