<p align="center">
  <img src="https://cdn.imperfectandcompany.com/assets/diagrams/imperfect_data_logo.png" width="100" />
</p>
<p align="center">
    <h1 align="center">IMPERFECT DATA MEDALLION
</h1>
</p>
<p align="center">
    <em>https://imperfectandcompany.com/</em>
</p>


<div align="center">
  
![Imperfect and Company Data Diagrams](https://cdn.imperfectandcompany.com/assets/diagrams/github_graphic.png)
</div>


## Introduction
The Imperfect Data Medallion repository is dedicated to creating a comprehensive data handling and analytical framework for Imperfect and Company. By leveraging the Medallion architecture, we aim to streamline our data workflows from raw data ingestion to refined analytical insights.

## Project Structure
The project adheres to the following Medallion architecture principles:
- **Data Lakehouse:** Centralized repository for raw and cleaned data.
- **Data Lake:** Storage for raw data from various sources.
- **Data Warehouse:** Refined and structured data storage for efficient querying and analysis.
- **Dataflows:** Processes to clean, transform, and move data between different layers.

## Infrastructure
We are using Azure Fabric with an F64 capacity to handle our data processing needs. Our data sources are divided into two primary locations:
1. **Archived Data Sources**: Located on our dev database server in Atlanta, Georgia.
2. **Active Data Sources**: Located on our production database server in Vint Hill, Virginia.

The live database server specifications:
- 1 Gbit/s unmetered connection
- Two 512GB SSD NVMe drives (one for usage, one for 1:1 copy for data protection and integrity as soft RAID)
- 128GB memory
- Equipped with a processor designed for analyzing big data, capable of handling millions of records.

## Data Sources
We will use Azure Fabric to consolidate data from all sources.

Our data comes from various sources, including:
- MySQL databases (using phpMyAdmin)
- CSV files (survey data, expense reports)
- Other active and archived data sources


## Purpose and Design Considerations

### Purpose
The Imperfect Data Medallion project aims to centralize and optimize our data management to support business objectives, improve data quality, and provide valuable insights for decision-making.

### Need for Scale and Performance
Our data architecture is designed to handle large volumes of data, ensuring scalability and high performance. The infrastructure supports high-speed data transfer and robust data storage solutions, essential for processing and analyzing millions of records efficiently.

### Data Deduplication, Validation, and Integrity
To maintain data quality, we implement processes for data deduplication, validation, and integrity:
- **Deduplication:** Remove redundant data entries to ensure a clean and accurate dataset.
- **Data Validation:** Implement rules and checks to validate data accuracy and consistency.
- **Data Integrity:** Ensure that data remains accurate and consistent over its lifecycle.

### Comprehensive Documentation
We maintain detailed documentation of our data models and processes to:
- Enhance understanding and collaboration among team members.
- Provide clear guidelines for data handling and transformations.
- Ensure transparency and reproducibility of data workflows.

### Source Data Schema Improvements
We continuously review and improve our source data schemas to enhance data quality and compatibility. This involves:
- Standardizing data formats and structures.
- Decoupling schemas to support a broader organizational structure (parent-child relationships).

### Decoupling for Broader Organization
Our data model supports a decoupled structure that aligns with the broader organization, allowing us to manage data for parent and child entities effectively. This structure enables:
- Flexible data integration across different business units.
- Scalable data management practices.

### Analytics for Stakeholders
We utilize advanced analytics to generate insights for investors, accelerators, and stakeholders. Key aspects include:
- **Power BI Analysis:** Create detailed dashboards and reports for comprehensive data analysis.
- **Exploration and Drill-Down Capabilities:** Allow stakeholders to explore data at various levels, from high-level summaries to detailed records.
- **Stakeholder Presentations:** Prepare data-driven presentations to communicate key metrics and trends effectively.

### Business Objectives
The Imperfect Data Medallion supports our business objectives by:
- Providing centralized, scalable, and efficient data management.
- Enabling in-depth exploration of projects, time periods, and user activities.
- Highlighting key metrics and trends for informed decision-making.

## Initial Procedure
The initial commit includes a basic stored procedure to generate a combined view of our data across multiple databases. These stored procedures run on our external MySQL server to clean and transform the data before exporting the intermediate views/tables to our data lake for further processing.

### Specific Workflow for Archived Databases
- **Archived Databases:** We are primarily working on archived databases using stored procedures to clean and transform data.
- **Live Database for Schema Validation:** One live database is used mainly to get the schema and format right before connecting to the live/production database server.
- **Minimizing Ingestion Queries:** By using stored procedures, we aim to minimize the need for multiple MySQL-to-lakehouse ingestion queries for each table. This approach consolidates the data transformation process, reducing the number of queries and improving efficiency.

## Future Plans
- **Ingestion Pipelines:** Automate the ingestion of data from multiple live  sources into the data lake.
- **Data Cleaning:** Implement cleaning processes to ensure data quality. 
- **Transformation:** Develop transformations to structure and refine data.
- **Analytics:** Enable advanced analytics and reporting using Power BI.

## External Help
We have onboarded a data analyst for contract work to assist in consultation regarding business intelligence and statistical models/metrics. His work will begin once the foundation is finished and ready for his analysis. He will use Power BI to engage in the process. He has already been onboarded and given the right role/permissions. His email is arslan_nisar@imperfectandcompany.com, and he has been given a Power BI Pro license for the work. We are also pausing the F64 capacity whenever not in use and switching to a Pro license for the workspace when not required.
