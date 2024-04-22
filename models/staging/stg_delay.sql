{{ config(materialized='table') }}

with delay as (
    select 
        travel_id,
        {{get_carrier_name('mkt_unique_carrier')}} as unique_carrier,
        {{get_travel_month('month')}} as month,
        {{get_travel_day('day_of_week')}} as day, 
        carrier_delay as carried_delay_minutes,
        security_delay as security_delay_minutes,
        weather_delay as weather_delay_minutes,
        nas_delay as nas_delay_minutes,
        late_aircraft_delay as late_aircraft_delay_minutes

    from {{ ref('airline_data')}}
    where travel_id is not null
)

select * from delay
