# CS50 SQL Course Repository

This repository is a part of the CS50 SQL course and serves as a design document for a SQL database that manages a medical facility's operations. The database is designed to keep track of patients' appointments with doctors, including patient information, doctor details, medical centers, departments, cabinets, appointments, reports, and bills. This README provides an overview of the course and the database design.

## Course Overview

The CS50 SQL course introduces you to SQL (Structured Query Language) and the fundamentals of database management. It covers various aspects of database design, querying, and optimization. In this repository, we will focus on the design of a SQL database for a medical facility to manage patient appointments and related information.

## Design Document

The design document in this repository outlines the scope, functional requirements, representation, relationships, optimizations, and limitations of the SQL database created for the medical facility. Here's a brief overview of the key components:

### Scope

The database's scope includes the management of patients, doctors, medical centers, departments, cabinets, appointments, reports, and bills. It provides necessary information to facilitate the scheduling of patient appointments, tracking diagnosis, treatment, appointment times, and payment information.

### Functional Requirements

The database supports CRUD (Create, Read, Update, Delete) functions for appointments, doctors, and patients. It also tracks information related to diagnosis, treatment, appointment times, payment, and the location of medical centers, departments, and cabinets.

### Representation

The database design includes tables for Patients, Doctors, Medical Centers (Centers), Departments, Cabinets, Appointments, Reports, and Bills. Each table is described in detail in the design document, including the columns, data types, constraints, and relationships with other tables.

### Relationships

The design document provides an Entity Relationship (ER) diagram that illustrates the relationships between the different entities in the database. It highlights how patients, doctors, cabinets, departments, medical centers, appointments, reports, and bills are connected.

### Optimizations

The document suggests optimizations in the form of index creation to speed up queries for various aspects of the database. Indexes are recommended for tables like Appointments, Reports, Bills, and Doctor-Cabinet relationships to improve query performance.

### Limitations

The design document outlines certain limitations of the current schema, such as the lack of support for cases where multiple doctors are involved in a single patient's appointment and the absence of support for scenarios where multiple patients share the same appointment with a doctor. Additionally, it does not include support for recording details about medical procedures, tests, or medications administered during appointments.

## Video Overview

For a more visual explanation of the database design, you can watch a video overview by [Artem Nizhyvenko](https://youtu.be/9H1FseEMpak).

## Getting Started

To get started with the CS50 SQL course and explore the database design in more detail, refer to the design document in this repository. You can use this document as a reference while working on SQL-related projects or coursework.

Feel free to explore the database design, modify it to meet specific requirements, and use it as a foundation for your own SQL projects.

## License

This repository is provided under the [MIT License](LICENSE) for educational and reference purposes.

Enjoy your journey through the world of SQL and database management!
