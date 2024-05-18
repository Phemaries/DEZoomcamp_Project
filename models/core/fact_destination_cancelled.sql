{{ config(materialized='table') }}

with location_cancelled as (
    select 
        travel_id,
        {{get_binary_change('cancelled')}} as cancelled,
        {{get_cancellation_code('cancellation_code')}} as cancellation_code
    from {{ref('airline_data')}}
),
origin as (
    select
        travel_id,
        origin_city,
        origin_state
    from {{ref('stg_origin_airport')}}
),
destination as (
    select
        travel_id,
        destination_city,
        destination_state
    from {{ref('stg_destination_airport')}}
),
combined_data as (
    select
        location_cancelled.travel_id,
        origin.origin_city,
        origin.origin_state,
        destination.destination_city,
        destination.destination_state,
        location_cancelled.cancelled,
        location_cancelled.cancellation_code
    from location_cancelled
    left join origin 
        on origin.travel_id = location_cancelled.travel_id
    left join destination
        on destination.travel_id = location_cancelled.travel_id
),
unique_source as (
    select *,
        row_number() over (partition by travel_id, origin_state order by travel_id) as rn
    from combined_data
)
select 
    {{ dbt_utils.generate_surrogate_key(['travel_id', 'origin_state']) }} as unique_id,
    origin_city,
    origin_state,
    destination_city,
    destination_state,
    cancelled,
    cancellation_code
from unique_source
where rn = 1
