{{ config(materialized='table') }}

with origin_airport as (
    select 
        travel_id,
        dest as destination_code,
        dest_city_name as destination_city,
        dest_state_nm as destination_state
    from {{ ref('airline_data')}}
    where travel_id is not null
)

select * from origin_airport