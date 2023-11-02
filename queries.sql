-- Find all appointments by date for a certain doctor
SELECT "patients"."first_name" AS "Patient's first name", 
       "patients"."last_name" AS "Patient's last name",
       "patients"."phone" AS "Patient's phone", "appointments"."datetime" AS "Datetime"
FROM "appointments" 
JOIN "patients"  ON "appointments"."patient_id" = "patients"."id"
WHERE "appointments"."datetime" LIKE '2023-11-03%' 
AND "appointments"."doctor_id" = (
    SELECT "id" FROM "doctors"
    WHERE "first_name" = 'Dr. Sarah' AND "last_name" = 'Williams'
);

-- Find all reports for a certain patient, ordered by datetime 
SELECT "reports"."diagnosis" AS "Diagnosis", 
       "reports"."treatment" AS "Treatment", 
       "doctors"."first_name" AS "Doctor's first name", 
       "doctors"."last_name" AS "Doctor's last name", 
       "reports"."datetime" AS "Datetime"
FROM "reports"
JOIN "doctors" ON "reports"."doctor_id" = "doctors"."id"
WHERE "reports"."patient_id" = (
    SELECT "id" FROM "patients"
    WHERE "first_name" = 'John' 
    AND "last_name" = 'Doe'
)
ORDER BY "reports"."datetime" DESC;

-- Find bill for a specific patient's appointment
SELECT "amount", "datetime"
FROM "bills"
WHERE "patient_id" = (
    SELECT "id" FROM "patients"
    WHERE "first_name" = 'John' 
    AND "last_name" = 'Doe'
) AND "appointment_id" = (
    SELECT "id" FROM "appointments"
    WHERE "patient_id" = (
        SELECT "id" FROM "patients"
        WHERE "first_name" = 'John' 
        AND "last_name" = 'Doe'
    ) AND "doctor_id" = (
        SELECT "id" FROM "doctors"
        WHERE "first_name" = 'Dr. Sarah' 
        AND "last_name" = 'Williams'
    ) AND "datetime" = '2023-11-03 09:00:00'
);

-- Find doctor's location information for a specific doctor
SELECT "doctors"."first_name" AS "Doctor's first name",
       "doctors"."last_name" AS "Doctor's last name",
       "doctors"."specialization" AS "Specialization",
       "cabinets"."number" AS "Cabinet number",
       "cabinets"."floor" AS "Floor",
       "departments"."name" AS "Department",
       "centers"."name" AS "Center",
       "centers"."address" AS "Address"
FROM "doctor_cabinet"
JOIN "doctors" ON "doctor_cabinet"."doctor_id" = "doctors"."id"
JOIN "cabinets" ON "doctor_cabinet"."cabinet_id" = "cabinets"."id"
JOIN "departments" ON "cabinets"."department_id" = "departments"."id"
JOIN "centers" ON "departments"."center_id" = "centers"."id"
WHERE "doctors"."first_name" = 'Dr. Sarah' AND "doctors"."last_name" = 'Williams';

-- Find doctor's location information for a specific doctor
SELECT "first_name" AS "Doctor's first name", 
       "last_name" AS "Doctor's last name", 
       "specialization" AS "Specialization",
       "cabinet_number" AS "Cabinet number", 
       "floor" AS "Floor", 
       "department" AS "Department", 
       "center" AS "Center", 
       "address" AS "Address" 
FROM "doctor_location"
WHERE "doctor_id" = (
     SELECT "id" FROM "doctors"
    WHERE "first_name" = 'Dr. Sarah' AND "last_name" = 'Williams'
);

-- Find a list of patients who have scheduled appointments with specific doctors, including the count of appointments for each patient
SELECT "patients"."first_name" AS "Patient's first name", 
       "patients"."last_name" AS "Patient's last name",
       "doctors"."first_name" AS "Doctor's first name", 
       "doctors"."last_name" AS "Doctor's last name",
       COUNT("appointments"."id") AS "Appointment Count"
FROM "doctors"
RIGHT JOIN "appointments" ON "doctors"."id" = "appointments"."doctor_id"
RIGHT JOIN "patients" ON "appointments"."patient_id" = "patients"."id"
GROUP BY "patients"."first_name", "patients"."last_name", "doctors"."first_name", "doctors"."last_name"
ORDER BY "patients"."first_name", "patients"."last_name", "doctors"."first_name", "doctors"."last_name";

-- Find the doctors with the highest total billing amount
SELECT "doctors"."first_name" AS "Doctor's first name", 
       "doctors"."last_name" AS "Doctor's last name",
       SUM("bills"."amount") AS "Total Billing Amount"
FROM "doctors"
LEFT JOIN "appointments" ON "doctors"."id" = "appointments"."doctor_id"
LEFT JOIN "bills" ON "appointments"."id" = "bills"."appointment_id"
GROUP BY "doctors"."id", "doctors"."first_name", "doctors"."last_name"
ORDER BY "Total Billing Amount" DESC;

-- List the most common medical conditions and their occurrence counts
SELECT "diagnosis" AS "Medical Condition", COUNT("diagnosis") AS "Occurrence Count"
FROM "reports"
GROUP BY "diagnosis"
ORDER BY "Occurrence Count" DESC;


-- Add a new patients
INSERT INTO "patients" ("first_name", "last_name", "gender", "phone", "address") 
VALUES
    ('John', 'Doe', 'masculine', '555-123-4567', '123 Main St'),
    ('Jane', 'Smith', 'feminine', '555-987-6543', '456 Elm St'),
    ('Chris', 'Johnson', 'masculine', '555-789-1234', '789 Oak St');

-- Hire new doctors
INSERT INTO "doctors" ("first_name", "last_name", "gender", "phone", "specialization") 
VALUES
    ('Dr. Sarah', 'Williams', 'feminine', '555-111-2222', 'Cardiologist'),
    ('Dr. Michael', 'Smith', 'masculine', '555-222-3333', 'Pediatrician'),
    ('Dr. Emily', 'Jones', 'feminine', '555-333-4444', 'Orthopedic Surgeon');

-- Create a new appointments
INSERT INTO "appointments" ("datetime", "doctor_id", "patient_id", "cabinet_id") 
VALUES
    ('2023-11-03 09:00:00', 1, 1, 1),
    ('2023-11-04 10:30:00', 2, 2, 2),
    ('2023-11-05 15:45:00', 3, 3, 3);

-- Create a new reports
INSERT INTO "reports" ("datetime", "diagnosis", "treatment", "doctor_id", "patient_id", "appointment_id") 
VALUES
    ('2023-11-03 10:30:00', 'Hypertension', 'Prescribed medication', 1, 1, 1),
    ('2023-11-04 12:15:00', 'Common cold', 'Rest and fluids', 2, 2, 2),
    ('2023-11-05 16:30:00', 'Fractured bone', 'Orthopedic surgery recommended', 3, 3, 3);

-- Create a new bills
INSERT INTO "bills" ("datetime", "amount", "patient_id", "appointment_id") 
VALUES
    ('2023-11-03 11:15:00', 100.00, 1, 1),
    ('2023-11-04 13:45:00', 75.50, 2, 2),
    ('2023-11-05 17:30:00', 500.00, 3, 3);
