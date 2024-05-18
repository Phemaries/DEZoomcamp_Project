{{ config(materialized='table') }}

with cancelled_trip as (
    select
        travel_id,
        {{get_travel_day('day_of_week')}} as travel_day,
        {{get_travel_month('month')}} as travel_month,
        {{get_binary_change('cancelled')}} as cancelled,
        {{get_cancellation_code('cancellation_code')}} as cancellation_code        
    from {{ref('airline_data')}}
), 
carrier as (
    select
        travel_id,
        unique_carrier
    from {{ref('stg_airline_carrier')}}
),
combined_data as (
    select
        cancelled_trip.travel_id,
        cancelled_trip.travel_day,
        cancelled_trip.travel_month,
        cancelled_trip.cancelled,
        cancelled_trip.cancellation_code,
        carrier.unique_carrier
    from cancelled_trip
    left join carrier 
        on cancelled_trip.travel_id = carrier.travel_id
),
unique_source as (
    select *,
        row_number() over (partition by travel_id, unique_carrier order by travel_id) as rn
    from combined_data
)
select 
    {{ dbt_utils.generate_surrogate_key(['travel_id', 'unique_carrier']) }} as unique_id,
    travel_id,
    travel_day,
    travel_month,
    cancelled,
    cancellation_code,
    unique_carrier
from unique_source
where rn = 1
