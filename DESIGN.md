# Design Document

By Artem Nizhyvenko

## Scope
The CS50 SQL database has everything required to make the medical facility's operations easier by keeping track of patients' appointments with doctors. Thus, the following are covered by the database's scope:

* Patients, with necessary personal information.
* Doctors, with necessary identifying information.
* Centers, which provide the locations of medical centers as well as basic information.
* Departments, which list departments' fundamental details and divide centers according to their areas of specialization.
* Cabinets, include information about cabinets where doctors accept appointments.
* Appointments, which include the start time of the meeting and details about the patient, doctor, and cabinet where the appointment is held.
* Reports, conclude with information about the patient and the appointment in addition to the diagnosis and recommended course of therapy.
* Bills, include the cost of the patient's care at the appointment.

Pharmacy, analysis, surgery, medications, additional staff, and other superfluous items are outside the purview of this scope.

## Functional Requirements

This database will enable:

* CRUD functions pertaining to appointments, doctors, and patients. 
* Track diagnosis, course of treatment, appointment times, payment information, and location of the medical center, department, or office.

The many patients in one appointment with one doctor and the one appointment with several doctors are not supported by this database.

## Representation

The following schema is used in SQLite tables to store entities.

### Entities

The following entities are present in the database:

### Patients

The `patients` table includes:

* `id`: An `INTEGER` column, serving as the unique ID for each patient. It's marked as the `PRIMARY KEY` to ensure uniqueness.
* `first_name`: A `TEXT` column for the patient's first name, marked as `NOT NULL` to ensure the data is always provided.
* `last_name`: A `TEXT` column for the patient's last name, also marked as `NOT NULL`.
* `gender`: A `TEXT` column representing the patient's gender, with a `CHECK` constraint to allow only 'masculine,' 'feminine,' or 'unknown' values.
* `phone`: A `TEXT` column for the patient's phone number, marked as `NOT NULL` and having a `UNIQUE` constraint to ensure phone numbers are unique.
* `address`: A `TEXT` column for the patient's address, marked as `NOT NULL` to ensure completeness.

### Doctors

The `doctors` table includes:

* `id`: An `INTEGER` column, serving as the unique ID for each doctor. It's marked as the `PRIMARY KEY` to ensure uniqueness.
* `first_name`: A `TEXT` column for the doctor's first name, marked as `NOT NULL`.
* `last_name`: A `TEXT` column for the doctor's last name, also marked as `NOT NULL`.
* `gender`: A `TEXT` column representing the doctor's gender, with a `CHECK` constraint to allow only 'masculine,' 'feminine,' or 'unknown' values.
* `phone`: A `TEXT` column for the doctor's phone number, marked as `NOT NULL` and having a `UNIQUE` constraint to ensure phone numbers are unique.
* `specialization`: A `TEXT` column specifying the medical specialization of the doctor, marked as `NOT NULL`.

### Doctor_Cabinet

The `doctor_cabinet` table includes:

* `id`: An `INTEGER` column, serving as the unique ID for each doctor-cabinet association. It's marked as the `PRIMARY KEY` to ensure uniqueness.
* `doctor_id`: An `INTEGER` column serving as a `FOREIGN KEY`, referencing the `id` column of the `doctors` table, establishing a relationship between `doctors` and their assignments to `cabinets`.
* `cabinet_id`: An `INTEGER` column serving as a `FOREIGN KEY`, referencing the `id` column of the `cabinets` table, establishing a relationship between `doctors` and `cabinets`.

### Centers

The `centers` table includes:

* `id`: An `INTEGER` column, serving as the unique ID for each medical center. It's marked as the `PRIMARY KEY` to ensure uniqueness.
* `name`: A `TEXT` column representing the name of the medical center, marked as `NOT NULL` and having a `UNIQUE` constraint to ensure each center has a unique name.
* `phone`: A `TEXT` column for the phone number of the medical center, marked as `NOT NULL` and having a `UNIQUE` constraint to ensure each center has a unique phone number.
* `address`: A `TEXT` column specifying the address of the medical center, marked as `NOT NULL` and having a `UNIQUE` constraint to ensure each center has a unique address.

### Departments

The `departments` table includes:

* `id`: An `INTEGER` column, serving as the unique ID for each department. It's marked as the `PRIMARY KEY` to ensure uniqueness.
* `name`: A `TEXT` column representing the name of the department, marked as `NOT NULL` and having a `UNIQUE` constraint to ensure each department has a unique name.
* `specialization`: A `TEXT` column specifying the specialization of the department, marked as `NOT NULL`.
* `phone`: A `TEXT` column for the phone number of the department, marked as `NOT NULL` and having a `UNIQUE` constraint to ensure each department has a unique phone number.
* `center_id`: An `INTEGER` column serving as a `FOREIGN KEY`, referencing the `id` column of the `centers` table, establishing a relationship between `departments` and `centers`.

### Cabinets

The `cabinets` table includes:

* `id`: An `INTEGER` column, serving as the unique ID for each cabinet. It's marked as the `PRIMARY KEY` to ensure uniqueness.
* `number`: A `TEXT` column representing the cabinet number, marked as `NOT NULL` and having a `UNIQUE` constraint to ensure each cabinet has a unique number.
* `floor`: An `INTEGER` column specifying the floor on which the cabinet is located, marked as `NOT NULL` to ensure completeness.
* `department_id`: An `INTEGER` column serving as a `FOREIGN KEY`, referencing the `id` column of the `departments` table, establishing a relationship between `cabinets` and `departments`.

### Appointments

The `appointments` table includes:

* `id`: An `INTEGER` column, serving as the unique ID for each appointment. It's marked as the `PRIMARY KEY` to ensure uniqueness.
* `datetime`: A `TEXT` column specifying the date and time of the appointment, marked as `NOT NULL` to ensure this information is always provided.
* `doctor_id`: An `INTEGER` column serving as a `FOREIGN KEY`, referencing the `id` column of the `doctors` table, establishing a relationship between `doctors` and  `appointments`.
* `patient_id`: An `INTEGER` column serving as a `FOREIGN KEY`, referencing the `id` column of the `patients` table, establishing a relationship between `patients` and `appointments`.
* `cabinet_id`: An `INTEGER` column serving as a `FOREIGN KEY`, referencing the `id` column of the `cabinets` table, establishing a relationship between `cabinets` and `appointments`.

### Reports

The `reports` table includes:

* `id`: An `INTEGER` column, serving as the unique ID for each report. It's marked as the `PRIMARY KEY` to ensure uniqueness.
* `datetime`: A `TEXT` column specifying the date and time of the report, marked as `NOT NULL` to ensure this information is always provided.
* `diagnosis`: A `TEXT` column representing the diagnosis given to the patient, marked as `NOT NULL`.
* `treatment`: A `TEXT` column specifying the treatment provided to the patient, marked as `NOT NULL`.
* `doctor_id`: An `INTEGER` column serving as a `FOREIGN KEY`, referencing the `id` column of the `doctors` table, establishing a relationship between `doctors` and `reports`.
* `patient_id`: An `INTEGER` column serving as a `FOREIGN KEY`, referencing the `id` column of the `patients` table, establishing a relationship between `patients` and `reports`.
* `appointment_id`: An `INTEGER` column serving as a `FOREIGN KEY`, referencing the `id` column of the `appointments` table, establishing a relationship between `appointments` and `reports`.

### Bills

The `bills` table includes:

* `id`: An `INTEGER` column, serving as the unique ID for each bill. It's marked as the `PRIMARY KEY` to ensure uniqueness.
* `datetime`: A `TEXT` column specifying the date and time of the bill, marked as `NOT NULL`.
* `amount`: A `NUMERIC` column for the bill's amount, marked with a `CHECK` constraint to ensure that the amount is greater than or equal to 0.
* `patient_id`: An `INTEGER` column serving as a `FOREIGN KEY`, referencing the `id` column of the `patients` table, establishing a relationship between `patients` and `bills`.
* `appointment_id`: An `INTEGER` column serving as a `FOREIGN KEY`, referencing the `id` column of the `appointments` table, establishing a relationship between `appointments` and `bills`.

### Relationships

The relationships between the database's entities are shown in the entity relationship diagram below.

![ER Diagram](diagrama.png)

As the diagram makes clear:

* One patient can have 0 to many appointments. A patient can have 0 appointments if they haven't scheduled any appointments, or they can have many appointments if they visit the medical center multiple times. 
* An appointment is made by one and only one patient. Each appointment is associated with a single patient.

* A doctor can have 0 to many appointments. A doctor can have 0 appointments if they haven't scheduled any appointments with patients, or they can have many appointments if they have multiple patients to see. 
* An appointment is associated with one and only one doctor. Each appointment is scheduled with a specific doctor.

* One cabinet can be assigned to 0 to many doctors. A cabinet can be unassigned (0 doctors) if it's not currently in use by any doctor, or it can be assigned to many doctors if multiple doctors share the same cabinet. 
* A doctor can be assigned to 0 to many cabinets at a time. Each doctor is associated with a cabinet for their work.

* One department can have one to many cabinets. This means that a department may have one or more cabinets assigned to it. The number of cabinets associated with a department can vary, and it depends on the size and needs of the department. Some departments may have just one cabinet, while larger departments may have several cabinets to accommodate their activities and services. 
* A cabinet is associated with one and only one department. Each cabinet is specifically assigned to a particular department, and it serves the purposes and functions of that department.

* One medical center can have one to many departments. This means that a medical center may have one or more departments associated with it. The number of departments in a medical center can vary, and it depends on the size and specialization of the medical center. Some smaller medical centers may have only one department, while larger medical centers can have multiple departments catering to various medical specialties and services.
* A department is associated with one and only one medical center. Each department operates within a specific medical center, and it is under the management and affiliation of that medical center.

* An appointment can have exactly one report. This means that for each appointment, there is a one-to-one relationship with a report. Every appointment is associated with a single report that provides information about the medical examination or treatment provided during that appointment.

* A patient can have 0 to many reports. A patient may have no reports if they haven't had any medical examinations, or they can have many reports if they visit the medical center multiple times and receive multiple reports.
* A report is associated with one and only one patient. Each report is linked to a specific patient.

* An appointment can have exactly one bill. This means that for each appointment, there is a one-to-one relationship with a bill. Every appointment is associated with a single bill that represents the financial transaction related to that specific appointment, including the cost of medical services or procedures.
* A bill is associated with one and only one appointment. Each bill corresponds to a specific appointment.

* A patient can have 0 to many bills. A patient may not have any bills if they haven't been billed for any appointments, or they can have many bills if they receive bills for multiple appointments.
* A bill is associated with one and only one patient. Each bill is linked to a specific patient.

## Optimizations

* `index_appointments_patient_id`, `index_appointments_doctor_id`, and `index_appointments_cabinet_id`:
To expedite queries that include filtering appointments by `patient_id`, `doctor_id`, or `cabinet_id`, these indexes are built on the `appointments` table. These indexes will speed up the retrieval process, for instance, if you need to locate all of the appointments for a particular patient or doctor.

* `index_reports_doctor_id`, `index_reports_patient_id`, and `index_reports_appointment_id`:
These indexes on the `reports` table assist in filtering reports according to `doctor_id`, `patient_id`, or `appointment_id`, much like they do on the `appointments` table. For instance, these indexes will optimize the query if you wish to retrieve all reports related to a specific patient.

* `index_bills_patient_id` and `index_bills_appointment_id`:
In order to enhance the efficiency of queries that filter bills based on `patient_id` or `appointment_id`, these indexes are built on the `bills` table. These indexes will speed up your search if you need to locate all of the bills for a particular patient or appointment.

* `index_doctor_cabinet_doctor_id` and `index_doctor_cabinet_cabinet_id`:
The purpose of these indexes is to expedite queries pertaining to the `doctor_cabinet` table. These indexes will aid in streamlining your search whether you're looking for all cabinets connected to a certain doctor or all doctors allocated to a specific cabinet.

* `doctor_location`:
To give information about the locations of doctors, this view aggregates data from multiple tables, such as `doctors`, `doctor_cabinet`, `cabinets`, `departments`, and `centers`. This view might be helpful for displaying and querying the locations of particular doctors.

## Limitations

* The current schema does not support cases where multiple doctors are involved in a single patient's appointment. 
* The schema does not accommodate scenarios where multiple patients share the same appointment with a doctor. In
* The schema primarily focuses on appointments, reports, and bills but does not include support for recording details about medical procedures, tests, or medications administered during appointments. 
