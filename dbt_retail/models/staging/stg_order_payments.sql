{{ config(materialized='view') }}

SELECT
  order_id,
  SUM(SAFE_CAST(payment_value AS FLOAT64)) AS total_payment,
  ARRAY_AGG(DISTINCT payment_type)[OFFSET(0)] AS payment_type
FROM {{ source('bronze', 'payments') }}
GROUP BY order_id
