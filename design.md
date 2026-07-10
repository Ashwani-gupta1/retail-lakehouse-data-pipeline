# Retail Lakehouse Data Engineering Platform
## Design Document

---

# 1. Project Overview

## Objective

The objective of this project is to build an end-to-end modern Data Engineering pipeline using Apache Airflow, Databricks, Apache Spark, dbt, Delta Lake, and AWS S3.

The solution demonstrates how raw transactional retail data can be transformed into analytics-ready datasets using the Medallion Architecture (Bronze → Silver → Gold).

---

# 2. Business Problem

Retail organizations generate transactional data from multiple operational systems.

Challenges include:

- Raw data arriving from multiple source tables
- Duplicate and inconsistent records
- Lack of historical tracking
- Difficult reporting across multiple entities
- No centralized analytics layer

This project solves these challenges by implementing a scalable Lakehouse architecture.

---

# 3. Solution Overview

The solution performs:

- Metadata Driven Ingestion
- Incremental Data Loading
- Data Cleaning
- Business Transformations
- SCD Type 2 Implementation
- Star Schema Creation
- Data Quality Validation
- Workflow Orchestration

---

# 4. High-Level Architecture

```text
                              Retail Lakehouse Data Engineering Platform

                                  Source OLTP Database
        +----------------------------------------------------------------+
        | Customers | Orders | Products | Stores | Employees | OrderItems |
        +------------------------------+---------------------------------+
                                       |
                                       |
                               Metadata Driven Ingestion
                                       |
                                       ▼
                      +-----------------------------------------+
                      | Apache Airflow                          |
                      | • Schedule DAGs                         |
                      | • Trigger Databricks Jobs               |
                      | • Retry Failed Tasks                    |
                      | • Monitor Pipeline                      |
                      +-------------------+---------------------+
                                          |
                                          ▼
                      +-----------------------------------------+
                      | Databricks + Apache Spark               |
                      | • Incremental ETL                       |
                      | • PySpark Transformations               |
                      | • Delta Lake Processing                 |
                      +-------------------+---------------------+
                                          |
                                          ▼
                +------------------------------------------------------------+
                | Bronze Layer (Raw Delta Tables)                            |
                | customers | orders | products | stores | employees | items |
                +-----------------------------+------------------------------+
                                              |
                                              ▼
                +------------------------------------------------------------+
                | Silver Technical Layer                                     |
                | Cleaning • Validation • Standardization • Deduplication    |
                +-----------------------------+------------------------------+
                                              |
                                              ▼
                +------------------------------------------------------------+
                | Silver Business Layer                                      |
                | Operational Business Table (OBT)                           |
                +-----------------------------+------------------------------+
                                              |
                           +------------------+------------------+
                           |                                     |
                           ▼                                     ▼
                SCD Type 2 Snapshots                 dbt Data Quality Tests
                           |                                     |
                           +------------------+------------------+
                                              |
                                              ▼
                +------------------------------------------------------------+
                | Gold Layer                                                 |
                | Fact Orders                                                |
                | Dim Customer                                               |
                | Dim Product                                                |
                | Dim Employee                                               |
                | Dim Store                                                  |
                | Dim Orders                                                 |
                +-----------------------------+------------------------------+
                                              |
                                              ▼
                                  STAR Schema & Analytics
                                              |
                                              ▼
                                   AWS S3 / BI Dashboards
```

---

# 5. Technology Stack

| Technology | Purpose |
|------------|---------|
| Apache Airflow | Workflow Orchestration |
| Databricks | Data Processing Platform |
| Apache Spark | Distributed Processing |
| dbt | Data Transformation |
| Delta Lake | ACID Storage |
| AWS S3 | Data Lake Storage |
| SQL | Data Modeling |
| Docker | Local Development |
| GitHub | Version Control |

---

# 6. Medallion Architecture

## Bronze Layer

Purpose

- Raw Data Ingestion
- Preserve Source Data
- Audit Columns
- Incremental Loading

---

## Silver Technical Layer

Purpose

- Remove Duplicates
- Standardize Data
- Data Cleaning
- Null Handling
- Incremental Merge

---

## Silver Business Layer

Purpose

Create a unified Operational Business Table (OBT).

Business joins are performed across:

- Customers
- Orders
- Products
- Employees
- Stores
- Order Items

---

## Gold Layer

Analytics-ready datasets.

### Dimension Tables

- Dim Customer
- Dim Product
- Dim Store
- Dim Employee
- Dim Orders

### Fact Table

- Fact Orders

---

# 7. Data Flow

Step 1

Extract data from Retail OLTP Database.

↓

Step 2

Airflow schedules the pipeline.

↓

Step 3

Databricks executes PySpark ETL jobs.

↓

Step 4

Load raw Delta tables into Bronze.

↓

Step 5

Transform into Silver Technical.

↓

Step 6

Create Business OBT.

↓

Step 7

Generate Gold Dimensions & Fact.

↓

Step 8

Run dbt Data Quality Tests.

↓

Step 9

Publish Analytics Dataset.

---

# 8. Incremental Loading

The project uses Incremental Models in dbt.

Benefits

- Process only changed records
- Faster execution
- Reduced compute cost
- Scalable architecture

---

# 9. Slowly Changing Dimension (SCD Type 2)

Snapshots are used to maintain historical records.

Process

Old Record

↓

Close Existing Record

↓

Insert Updated Record

↓

Maintain Complete History

---

# 10. Data Quality

Implemented using dbt.

Checks include

- Not Null
- Unique
- Relationship Tests
- Custom SQL Validation
- Incremental Validation

---

# 11. Folder Structure

```text
dags/
models/
    bronze/
    silver_t/
    silver_b/
    gold/
snapshots/
tests/
macros/
docs/
```

---

# 12. Key Features

- End-to-End Data Engineering Pipeline
- Apache Airflow Orchestration
- Databricks ETL
- PySpark Processing
- dbt Transformations
- Delta Lake
- Medallion Architecture
- Incremental Loading
- SCD Type 2
- Star Schema
- Data Quality Testing
- AWS S3 Integration

---

# 13. Future Enhancements

- CI/CD using GitHub Actions
- Infrastructure as Code (Terraform)
- Great Expectations
- Monitoring Dashboard
- Slack Alerts
- Data Lineage
- Unit Testing
- Performance Optimization

---

# 14. Repository Structure

```text
Retail_Lakehouse_Project/
│
├── dags/
├── models/
│   ├── bronze/
│   ├── silver_t/
│   ├── silver_b/
│   └── gold/
│
├── snapshots/
├── tests/
├── macros/
├── seeds/
├── docs/
├── docker-compose.yml
├── Dockerfile
├── dbt_project.yml
├── README.md
└── DESIGN_DOCUMENT.md
```

---

# 15. Conclusion

This project demonstrates a production-oriented Retail Lakehouse implementation using modern Data Engineering tools and best practices. It showcases orchestration, distributed processing, dimensional modeling, historical data management, data quality validation, and analytics-ready data modeling suitable for enterprise-scale workloads.

---

# Acknowledgement

This repository was developed as a hands-on learning implementation inspired by publicly available educational content and enhanced with additional design improvements, documentation, and production-oriented practices.
