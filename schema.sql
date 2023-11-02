-- Represent patients who's being cured
CREATE TABLE "patients" (
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "gender" TEXT NOT NULL CHECK ("gender" IN ('masculine', 'feminine', 'unknown')),
    "phone" TEXT NOT NULL UNIQUE,
    "address" TEXT NOT NULL
);

-- Represent doctors who cures
CREATE TABLE "doctors" (
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "gender" TEXT NOT NULL CHECK ("gender" IN ('masculine', 'feminine', 'unknown')),
    "phone" TEXT NOT NULL UNIQUE,
    "specialization" TEXT NOT NULL
);

-- Represent medical centers
CREATE TABLE "centers" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL UNIQUE, 
    "phone" TEXT NOT NULL UNIQUE,
    "address" TEXT NOT NULL UNIQUE
);

-- Represent departments in centers
CREATE TABLE "departments" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL UNIQUE, 
    "specialization" TEXT NOT NULL,
    "phone" TEXT NOT NULL UNIQUE,
    "center_id" INTEGER,
    FOREIGN KEY("center_id") REFERENCES "centers"("id")
); 

-- Represent cabinets in departments
CREATE TABLE "cabinets" (
    "id" INTEGER PRIMARY KEY,
    "number" TEXT NOT NULL UNIQUE, 
    "floor" INTEGER NOT NULL,
    "department_id" INTEGER,
    FOREIGN KEY("department_id") REFERENCES "departments"("id")
);

-- Represent cabinets where doctors work
CREATE TABLE "doctor_cabinet" (
    "id " INTEGER PRIMARY KEY,
    "doctor_id" INTEGER,
    "cabinet_id" INTEGER,
    FOREIGN KEY("doctor_id") REFERENCES "doctors"("id"),
    FOREIGN KEY("cabinet_id") REFERENCES "cabinet"("id")
);

-- Represent doctor's appointment
CREATE TABLE "appointments" (
    "id" INTEGER PRIMARY KEY,
    "datetime" TEXT NOT NULL,
    "doctor_id" INTEGER,
    "patient_id" INTEGER,
    "cabinet_id" INTEGER,
    FOREIGN KEY("patient_id") REFERENCES "patients"("id"),
    FOREIGN KEY("doctor_id") REFERENCES "doctors"("id"),
    FOREIGN KEY("cabinet_id") REFERENCES "cabinets"("id")
);

-- Represent patient's report
CREATE TABLE "reports" (
    "id" INTEGER PRIMARY KEY,
    "datetime" TEXT NOT NULL,
    "diagnosis" TEXT NOT NULL,
    "treatment" TEXT NOT NULL,
    "doctor_id" INTEGER,
    "patient_id" INTEGER,
    "appointment_id" INTEGER,
    FOREIGN KEY("doctor_id") REFERENCES "doctors"("id"),
    FOREIGN KEY("patient_id") REFERENCES "patients"("id"),
    FOREIGN KEY("appointment_id") REFERENCES "appointments"("id")
);

-- Represent patient's bills
CREATE TABLE "bills" (
    "id" INTEGER PRIMARY KEY,
    "datetime" TEXT NOT NULL,
    "amount" NUMERIC NOT NULL CHECK ("amount" >= 0),
    "patient_id" INTEGER,
    "appointment_id" INTEGER,
    FOREIGN KEY("patient_id") REFERENCES "patients"("id"),
    FOREIGN KEY("appointment_id") REFERENCES "appointments"("id")
);


-- Create indexes to speed common searches
CREATE INDEX "index_appointments_patient_id" ON "appointments" ("patient_id");
CREATE INDEX "index_appointments_doctor_id" ON "appointments" ("doctor_id");
CREATE INDEX "index_appointments_cabinet_id" ON "appointments" ("cabinet_id");

CREATE INDEX "index_reports_doctor_id" ON "reports" ("doctor_id");
CREATE INDEX "index_reports_patient_id" ON "reports" ("patient_id");
CREATE INDEX "index_reports_appointment_id" ON "reports" ("appointment_id");

CREATE INDEX "index_bills_patient_id" ON "bills" ("patient_id");
CREATE INDEX "index_bills_appointment_id" ON "bills" ("appointment_id");

CREATE INDEX "index_doctor_cabinet_doctor_id" ON "doctor_cabinet" ("doctor_id");
CREATE INDEX "index_doctor_cabinet_cabinet_id" ON "doctor_cabinet" ("cabinet_id");


-- View what represent doctors location
CREATE VIEW "doctor_location" AS
SELECT "doctors"."id" AS "doctor_id", "first_name", "last_name", "doctors"."specialization", "number" AS "cabinet_number", "floor", 
"departments"."name" AS "department", "centers"."name" AS "center", "centers"."address" FROM "doctor_cabinet"
JOIN "doctors" ON "doctor_cabinet"."doctor_id" = "doctors"."id"
JOIN "cabinets" ON "doctor_cabinet"."cabinet_id" = "cabinets"."id"
JOIN "departments" ON "cabinets"."department_id" = "departments"."id"
JOIN "centers" ON "departments"."center_id" = "centers"."id";
