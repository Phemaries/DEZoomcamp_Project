{{ config(materialized='table') }}

with departure_performance as (
    select 
        travel_id,
        {{get_carrier_name('mkt_unique_carrier')}} as unique_carrier,
        dep_delay_new as departure_delay_minutes,
        taxi_out as taxi_out_minutes
    from {{ ref('airline_data')}}
    where travel_id is not null
)

select * from departure_performance
