# Enterprise Analytics Snowflake Platform ❄️🔮

I wanted to model a real-world enterprise analytics platform, so I built one using Snowflake! The platform represents the operations of a fictional bicycle manufacturing enterprise. Various types of data are ingested into the platform:

- Daily public sentiment data about the company, based on recent news headlines
- Hourly foreign exchange data for selected markets
- Daily business operations data
<br>

## Goal

The goal of this platform is to answer the following business questions:

- What is the revenue/profit over the last month?
- What is the current exhange rate of our largest market (USA)?
- How do people feel about our company (public sentiment)?
- Which products have the best profit margin?
- What types of products do we sell the most?
- What US states do we get the most revenue from?
<br>

## End Result

The end result is the following dashboard, which answers these questions

<img src="images/preset1.png" alt="Description" width="700" />
Figure: Dashboard page 1
<br>
<br>

<img src="images/preset2.png" alt="Description" width="700" />
Figure: Dashboard page 2
<br>
<br>


## Solution Architecture

<img src="images/concept_diagram.png" alt="Description" width="700" />
Figure: Simplified architecture
<br>
<br>

<img src="images/arch_diagram.png" alt="Description" width="700" />
Figure: Detailed architecture
<br>
<br>


## Features

| **Feature** | **Details** |
|-------------|-------------|
| **ELT & Streaming Pipelines** | • Airbyte pipelines extract and load data from API, S3, and RDBMS<br>• Extraction patterns: incremental, full<br>• Load patterns: upsert, append, overwrite<br>• Pipelines orchestrated with Dagster on a schedule |
| **Cloud & Infrastructure** | • Deployed on AWS using Terraform<br>• Services: Lambda, ECS, ECR, EC2, S3, RDS, SQS, SNS, EventBridge, IAM |
| **Data Modeling & Warehousing** | • Kimball & OBT modeling with medallion architecture (raw → staging → marts)<br>• 2 fact tables, 6 dimension tables, 2 OBT tables<br>• SCD2 table for historical tracking<br>• Clustering applied on OBT tables to improve dashboard performance |
| **Analytics Engineering** | • SQL transformations using dbt<br>• SQL techniques: joins, aggregations, window functions, calculations, CTEs<br>• dbt features: macros, generic/custom tests, snapshots, profiles/targets, packages, incremental models |
| **Python & Orchestration** | • 3 Lambda functions written in Python<br>• Unit testing with pytest<br>• Orchestration handled via Dagster<br>• Dagster code written in Python |
| **Pipeline Observability & Reliability** | • Dagster retry policy for failed pipelines<br>• Dagster Slack alerting to notify pipeline success/failure<br>• dbt Source freshness warnings to notify of stale data |
| **FinOps** | • S3 Lifecycle policies to archive/delete old data<br>• Serverless services used wherever possible/appropriate (e.g., Dagster Cloud) |
| **CI/CD & Git** | • GitHub Actions for CI/CD<br>• Pipelines include linting, testing, Docker container builds, and deployments<br>• Branch protection rules enforce PR-based workflow |
| **Dashboarding & Semantic Layer** | • Preset dashboard to answer business questions<br>• Semantic layer techniques: calculated metrics and columns |
<br>

<!--
- **ELT & Streaming Pipelines**
  - Airbyte pipelines extract and load data from 3 different: API, S3, and RDBMS
  - Extraction patterns: incremental, full
  - Load patterns: upsert, append, overwrite
  - Pipelines orchestrated with Dagster on a schedule

- **Cloud & Infrastructure**
  - Deployed on AWS using Terraform
  - Services: Lambda, ECS, ECR, EC2, S3, RDS, SQS, SNS, EventBridge, IAM

- **Data Modeling & Warehousing**
  - Kimball & OBT modeling with medallion architecture (raw → staging → marts)
  - 2 fact tables, 6 dimension tables, 2 OBT tables
  - SCD2 table
  - Clustering applied on OBT tables to improve dashboard performance

- **Analytics Engineering**
  - SQL transformations using dbt
  - SQL techniques: joins, aggregations, window functions, calculations, CTEs
  - dbt features: macros, generic/custom tests, snapshots, profiles/targets, packages, incremental models

- **Python & Orchestration**
  - 3 Lambda functions written in Python
  - Unit testing with pytest
  - Orchestration handled via Dagster
  - Dagster code written in Python

- **Pipeline Observability & Reliability**
  - Dagster retry policy for failed pipelines
  - Dagster Slack alerting to notify pipeline success/failure
  - dbt Source freshness warnings to notify of stale data

- **FinOps**
  - S3 Lifecycle policies to archive/delete old data
  - Servereless services used wherever possible/appropriate (e.g. Dagster Cloud)

- **CI/CD & Git**
  - GitHub Actions for CI/CD
  - CI/CD pipelines include linting, testing, Docker container builds, and deployments
  - Branch protection rules to enforce PR-based workflow

- **Dashboarding & Semantic Layer**
  - Preset dashboard to answer business questions
-->

## Screenshots

<img src="images/dbt.png" alt="Description" width="700" />
Figure: dbt DAG
<br>
<br>

<img src="images/erd.png" alt="Description" width="700" />
Figure: Kimball models created using dbt
<br>
<br>

<img src="images/airbyte.png" alt="Description" width="700" />
Figure: Airbye connections
<br>
<br>

<img src="images/db.png" alt="Description" width="700" />
Figure: Snowflake compute cluster monitoring
<br>
<br>

<img src="images/dagster.png" alt="Description" width="700" />
Figure: Dagster pipeline successful run
<br>
<br>

<img src="images/gha.png" alt="Description" width="700" />
Figure: Github Actions workflow runs
<br>
<br>

<img src="images/cicd.png" alt="Description" width="700" />
Figure: CI/CD flow diagram
<br>
<br>

