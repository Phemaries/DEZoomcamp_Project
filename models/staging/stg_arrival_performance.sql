{{ config(materialized='table') }}

with arrival_performance as (
    select 
        travel_id,
        {{get_carrier_name('mkt_unique_carrier')}} as unique_carrier,
        arr_delay_new as arrival_delay_minutes,
        taxi_in as taxi_in_minutes
    from {{ ref('airline_data')}}
    where travel_id is not null
)

select * from arrival_performance
