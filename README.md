# Data Warehousing for Business Intelligence Specialization (Coursera)

[Data Warehousing for Business Intelligence Specialization](https://www.coursera.org/specializations/data-warehousing) offered by University of Colorado through Coursera.

## Courses:
* [Course 1](https://www.coursera.org/learn/database-management) - Database Management Essentials - **Done**
* [Course 2](https://www.coursera.org/learn/dwdesign) - Data Warehouse Concepts, Design, and Data Integration - **Done**
* [Course 3](https://www.coursera.org/learn/dwrelational) - Relational Database Support for Data Warehouses - **Done**
* [Course 4](https://www.coursera.org/learn/business-intelligence-tools) - Business Intelligence Concepts, Tools, and Applications - **Done**
* [Course 5](https://www.coursera.org/learn/data-warehouse-bi-building) - Design and Build a Data Warehouse for Business Intelligence Implementation - **Done**


## Topics

### 1. Database Management Essentials
- Module 1: Course Introduction
- Module 2: Introduction to Databases and DBMSs
- Module 3: Relational Data Model and the CREATE TABLE statement
- Module 4: Basic Query Formulation with SQL
- Module 5: Extended Query Formulation with SQL
- Module 6: Notation for Entity Relationship Diagrams
- Module 7: ERD Rules and Problem Solving
- Module 8: Developing Business Data Models
- Module 9: Data Modelling Problems and Completion of an ERD
- Module 10: Schema Conversion
- Module 11: Normalization Concepts and Practice

### 2. Data Warehouse Concepts, Design, and Data Integration
- Module 1: Data Warehouse Concepts and Architectures
- Module 2: Multidimensional Data Representation and Manipulation
- Module 3: Data Warehouse Design Practices and Methodologies
- Module 4: Data Integration Concepts, Processes, and Techniques
- Module 5: Architectures, Features, and Details of Data Integration Tools

### 3. Relational Database Support for Data Warehouses
- Module 1: DBMS Extensions and Example Data Warehouses
- Module 2: SQL Subtotal Operators
- Module 3: SQL Analytic Functions
- Module 4: Materialized View Processing and Design
- Module 5: Physical Design and Governance

### 4. Business Intelligence Concepts, Tools, and Applications
- Module 1: Decision Making and Decision Support Systems
- Module 2: Business Intelligence Concepts and Platform Capabilities
- Module 3: Data Visualization and Dashboard Design
- Module 4: Business Performance Management System
- Module 5: BI Maturity, Strategy, and Summative Project

### 5. Design and Build a Data Warehouse for Business Intelligence Implementation
- Module 1: Course Overview
- Module 2: Data Warehouse Design
- Module 3: Data Inegration
- Module 4: Analytical Queries and Summary Data Management
- Module 5: Data Visualization and Dashboard Design Requirements
- Module 6: Wrap Up and Project Submission


## Tools
- Generic DBMS (MySQL, PostgresSQL, Oracle etc)
- WebPivotTable
- Pentaho Data Integration
- MicroStrategy Workstation

## Installation
### PostgresSQL
`sudo apt install postgresql postgresql-contrib`

### MySQL
[APT Setup](https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#apt-repo-setup)

### MicroStrategy Workstation
[Link](https://www.dropbox.com/s/p4kd5nwtaeulcw0/MicroStrategy%20Workstation%2011.3.3.zip?dl=0)

## Start-up
### Services (terminal)
`systemctl status mysql` or `systemctl status postgresql`
`systemctl start mysql` or `systemctl start postgresql`
`systemctl stop mysql` or `systemctl start postgresql`

### Postgres login and create DB (terminal)
`sudo -u postgres psql`
`CREATE DATABASE UnivDB;`
`GRANT ALL PRIVILEGES ON DATABASE UnivDB to wxooi15;`
`\q`


