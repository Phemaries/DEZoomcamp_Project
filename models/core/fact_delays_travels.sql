{{ config(materialized='table') }}

with delay_travel as (
    select
        travel_id as delay_id,
        cast(carried_delay_minutes as numeric) as carrier_delay_minutes,
        cast(weather_delay_minutes as numeric) as weather_delay_minutes,
        cast(nas_delay_minutes as numeric) as nas_delay_minutes,
        cast(security_delay_minutes as numeric) as security_delay_minutes,
        cast(late_aircraft_delay_minutes as numeric) as late_aircraft_delay_minutes
    from {{ref('stg_delay')}}
),
travels as (
    select
        travel_id as date_id,
        month as travel_month,
        day as travel_day
    from {{ref('stg_travel_data')}}
),
origin_airport as (
    select
        travel_id as origin_id,
        origin_city,
        origin_state
    from {{ref('stg_origin_airport')}}
),
destination_airport as (
    select
        travel_id as destination_id,
        destination_city,
        destination_state
    from {{ref('stg_destination_airport')}}
),
destination_performance as (
    select
        travel_id as departure_perf_id,
        cast(COALESCE(departure_delay_minutes, 0) as numeric) as departure_delay_minutes,
        cast(COALESCE(taxi_out_minutes, 0) as numeric) as taxi_out_minutes
    from {{ref('stg_departure_performance')}}
),
arrival_performance as (
    select
        travel_id as arrival_perf_id,
        cast(COALESCE(arrival_delay_minutes, 0) as numeric) as arrival_delay_minutes,
        cast(COALESCE(taxi_in_minutes, 0) as numeric) as taxi_in_minutes
    from {{ref('stg_arrival_performance')}}
),
carrier as (
    select
        travel_id as carrier_id,
        unique_carrier
    from {{ref('stg_airline_carrier')}}
),
combined_data as (
    select
        delay_travel.delay_id,
        delay_travel.carrier_delay_minutes,
        delay_travel.weather_delay_minutes,
        delay_travel.nas_delay_minutes,
        delay_travel.security_delay_minutes,
        delay_travel.late_aircraft_delay_minutes,
        travels.travel_month,
        travels.travel_day,
        origin_airport.origin_city,
        origin_airport.origin_state,
        destination_airport.destination_city,
        destination_airport.destination_state,
        destination_performance.departure_delay_minutes,
        destination_performance.taxi_out_minutes,
        arrival_performance.arrival_delay_minutes,
        arrival_performance.taxi_in_minutes,
        carrier.unique_carrier
    from delay_travel
    inner join travels 
        on travels.date_id = delay_travel.delay_id
    inner join origin_airport
        on origin_airport.origin_id = travels.date_id
    inner join destination_airport
        on destination_airport.destination_id = origin_airport.origin_id
    inner join destination_performance
        on destination_performance.departure_perf_id = delay_travel.delay_id
    inner join arrival_performance
        on arrival_performance.arrival_perf_id = delay_travel.delay_id
    inner join carrier
        on carrier.carrier_id = delay_travel.delay_id
),
unique_source as (
    select *,
        row_number() over (partition by delay_id, unique_carrier order by delay_id) as rn
    from combined_data
)
select 
    {{ dbt_utils.generate_surrogate_key(['delay_id', 'unique_carrier']) }} as unique_id,
    delay_id,
    carrier_delay_minutes,
    weather_delay_minutes,
    nas_delay_minutes,
    security_delay_minutes,
    late_aircraft_delay_minutes,
    travel_month,
    travel_day,
    origin_city,
    origin_state,
    destination_city,
    destination_state,
    departure_delay_minutes,
    taxi_out_minutes,
    arrival_delay_minutes,
    taxi_in_minutes,
    unique_carrier
from unique_source
where rn = 1
