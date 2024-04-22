{{ config(materialized='table') }}

with origin_airport as (
    select 
        travel_id,
        origin as origin_code,
        origin_city_name as origin_city,
        origin_state_nm as origin_state
    from {{ ref('airline_data')}}
    where travel_id is not null
)

select * from origin_airport