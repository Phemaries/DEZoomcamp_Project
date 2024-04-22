{{ config(materialized='table') }}

with travel_data as (
    select 
        travel_id,
        year,
        {{get_travel_month('month')}} as month,
        {{get_travel_day('day_of_week')}} as day, 
        fl_date,
    from {{ ref('airline_data')}}
    where travel_id is not null
)

select * from travel_data