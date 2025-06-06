{{ config(materialized='table') }}

-- Dimension table for products, joined with translated category names

SELECT
  p.product_id,
  p.product_category_name,
  t.product_category_name_english,
  p.product_name_length,
  p.product_description_length,
  p.product_photos_qty,
  p.product_weight_g,
  p.product_length_cm,
  p.product_height_cm,
  p.product_width_cm

FROM {{ ref('stg_products') }} p
LEFT JOIN {{ ref('stg_product_category_translation') }} t
  ON p.product_category_name = t.product_category_name
