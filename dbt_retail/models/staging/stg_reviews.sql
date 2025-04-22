{{ config(materialized='view') }}

SELECT
  review_id,
  order_id,
  SAFE_CAST(review_score AS INT64) AS review_score,
  SAFE.PARSE_DATE('%Y-%m-%d', review_creation_date) AS review_creation_date,
  SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', review_answer_timestamp) AS review_answer_timestamp
FROM {{ source('bronze', 'reviews') }}
