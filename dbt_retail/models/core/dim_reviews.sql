{{ config(materialized='table') }}

-- One row per order_id, containing review metadata

SELECT
  order_id,  -- acts as the primary key (FK from fact_orders)
  review_id,
  review_score,
  review_creation_date,
  review_answer_timestamp
FROM {{ ref('stg_reviews') }}
