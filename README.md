# Hospital Database

Video overview: <https://youtu.be/9H1FseEMpak>

This repository is my final project for the CS50 SQL course, and it acts as a design document for a SQL database that oversees the operations of a medical facility. The database is intended to track patients' doctor appointments, including patient information, doctor details, medical centers, departments, cabinets, appointments, reports, and bills.


## Overview of the Course
The CS50 SQL course introduced me to SQL (Structured Query Language) and essential database administration concepts. It covered topics ranging from database design to querying and optimization. The final project was a culmination of the skills I had acquired throughout the course, showcasing my ability to work with databases and apply SQL for practical solutions. This course provided me with a solid foundation in SQL and a deeper understanding of how to manage and query databases effectively.


## Design Document

The [DESIGN.md](DESIGN.md) file contains the design document for the Hospital database project. This document describes the SQL database designed for the medical facility's scope, functional requirements, representation, relationships, optimizations, and restrictions.


## Contents of the Repository

The following files and SQL scripts are included in this repository:

- [schema.sql](schema.sql): This file defines the hospital database's schema. It has tables for patients, doctors, medical centers, departments, cabinets, appointments, reports, and bills.
  
- [queries.sql](queries.sql): This file contains a collection of SQL queries that demonstrate the hospital database's capability. It provides queries for locating appointments, reports, bills, doctor locations, patient-doctor relationships, and other information. These queries demonstrate the database's practical application.

- [medical.db](medical.db): The hospital database is represented by this SQLite database file, which is constructed based on the schema given in schema.sql. It features actual data, allowing you to examine and engage with patient and appointment information from the hospital.

These files are critical for understanding the structure and functionality of the hospital database, which makes working with and exploring the data easier.


## Course URL

To learn about CS50 SQL course, go to the official course website on the edX platform: [CS50's Introduction to Databases with SQL](https://www.edx.org/learn/sql/harvard-university-cs50-s-introduction-to-databases-with-sql).


## Permission

This repository is provided for educational and reference purposes under the MIT License.
