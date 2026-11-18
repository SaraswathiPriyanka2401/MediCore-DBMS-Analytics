# MediCore Healthcare: Hospital Patient & Appointment Analytics

## Overview
Hybrid relational (MySQL 8.0) and document-oriented (MongoDB Atlas) analytics platform built to track hospital patient load, doctor utilization, waiting times, revenue, and clinical lab reports.

## Architecture
- **MySQL (`medicore`):** 3NF normalized schema (`departments`, `doctors`, `patients`, `appointments`, `prescriptions`, `bills`) with `CHECK` constraints and a `BEFORE INSERT` trigger (`preventdoublebooking`) to block overlapping doctor slots.
- **Python DB-API & Pandas:** Connects to MySQL via `mysql-connector-python` to compute waiting-time intervals (`TIMESTAMPDIFF`) and visualize department load trends (`department_trends.png`).
- **MongoDB Atlas (`medicore_nosql`):** Stores semi-structured clinical notes and variable lab test arrays in `clinical_records`, indexed on `patient_id`, and aggregated by department and month via `pymongo`.

## Files Included
- `schema.sql` — DDL tables, constraints, and double-booking trigger
- `data.sql` — Sample dataset and DML booking/rescheduling/cancellation workflows
- `queries.sql` — Analytical SQL queries (peak hours, doctor utilization, no-show rates, revenue, top diagnoses)
- `medicore_analytics.ipynb` — End-to-end Python notebook for SQL visualization and MongoDB CRUD/Aggregation