{{ config(materialized='table') }}

-- Dimension table for sellers

SELECT
  seller_id,
  seller_zip_code_prefix,
  seller_city,
  seller_state
FROM {{ ref('stg_sellers') }}
