{{ config(materialized='table') }}

with airline_carrier as (
    select 
        travel_id, 
       {{get_carrier_name('mkt_unique_carrier')}} as unique_carrier
    from {{ ref('airline_data')}}
    where travel_id is not null
)

select * from airline_carrier