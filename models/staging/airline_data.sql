{{ config(materialized='table') }}

WITH airline_data AS (
    SELECT *
    FROM {{ source('staging', 'airline_transport_2020') }}
)

SELECT * from airline_data