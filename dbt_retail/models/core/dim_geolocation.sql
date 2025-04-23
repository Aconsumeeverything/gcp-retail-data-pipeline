{{ config(materialized='table') }}

SELECT
  zip_code_prefix,
  lat,
  lng,
  city,
  state
FROM {{ ref('stg_geolocation') }}
