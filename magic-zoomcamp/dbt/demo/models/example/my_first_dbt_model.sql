
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='view') }}



SELECT CAST(QUARTER as numeric) as year_date, 
fl_date
-- row_number() over(partition by year, fl_date) as rn
from {{ source('mage_demo', 'project_bigquery_to_dbt_load_gcs_bigquery')}}



/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
