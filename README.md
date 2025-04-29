# 🛒 Retail Data Pipeline on Google Cloud Platform

A modern, scalable, and fully orchestrated **data pipeline** for retail analytics, leveraging the best of **GCP**, **dbt**, **Apache Airflow (Composer)**, and **Terraform**.

---

## 🚀 Project Overview

This project ingests raw CSV data from a retail marketplace (Olist dataset), processes it, and builds a robust **cloud data warehouse** using a **multi-layer architecture**:

- **Bronze**: Raw data stored in **Google Cloud Storage** (GCS)
- **Silver**: Cleaned, standardized data as **views** in **BigQuery**
- **Gold**: Star-schema dimensional modeling via **dbt**
- **Orchestration**: Automated using **Apache Airflow** via **Cloud Composer**
- **Infra as Code**: Provisioned using **Terraform**

---

## 📦 Tech Stack

| Tool              | Purpose                                  |
|-------------------|-------------------------------------------|
| **Google Cloud Storage** | Raw file storage (CSV)               |
| **BigQuery**      | Cloud Data Warehouse                      |
| **dbt**           | Data modeling & transformations           |
| **Apache Airflow (Composer)** | Pipeline orchestration         |
| **Terraform**     | Infrastructure provisioning               |
| **Python & Pandas** | Data cleaning                           |
| **Looker Studio** | Data visualization (optional)            |

---

## 🧩 Architecture
  <img width="565" alt="schema" src="https://github.com/user-attachments/assets/9b9a959f-b9af-451d-a5ea-5282191d8bea" />


## Data modeling
![raw_model](https://github.com/user-attachments/assets/c23d6339-bf40-4fea-8d2f-86055a83f35b)

=> Star schema Lineag

![image](https://github.com/user-attachments/assets/adb666fa-d954-4b30-9076-812e87e55e08)
## ⚙️ Setup & Execution

> You’ll need:
> - A GCP Project with BigQuery and Composer enabled
> - Terraform installed
> - Python 3.10+ 



  
