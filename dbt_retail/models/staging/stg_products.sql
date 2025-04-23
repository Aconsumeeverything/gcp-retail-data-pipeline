{{ config(materialized='view') }}

SELECT
  product_id,
  product_category_name,
  SAFE_CAST(product_name_length AS INT64) AS product_name_length,
  SAFE_CAST(product_description_length AS INT64) AS product_description_length,
  SAFE_CAST(product_photos_qty AS INT64) AS product_photos_qty,
  SAFE_CAST(product_weight_g AS FLOAT64) AS product_weight_g,
  SAFE_CAST(product_length_cm AS FLOAT64) AS product_length_cm,
  SAFE_CAST(product_height_cm AS FLOAT64) AS product_height_cm,
  SAFE_CAST(product_width_cm AS FLOAT64) AS product_width_cm
FROM {{ source('bronze', 'products') }}
