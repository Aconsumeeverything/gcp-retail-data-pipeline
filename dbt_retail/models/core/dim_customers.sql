{{ config(materialized='table') }}


-- Dimension table for customers
-- One row per unique customer (customer_unique_id), with location info

SELECT
  customer_unique_id,
  ANY_VALUE(customer_id) AS representative_customer_id, 
  ANY_VALUE(customer_zip_code_prefix) AS zip_code_prefix,
  ANY_VALUE(customer_city) AS city,
  ANY_VALUE(customer_state) AS state
FROM {{ ref('stg_customers') }}

GROUP BY customer_unique_id
