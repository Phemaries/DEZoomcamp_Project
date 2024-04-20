with airline_data (
    select FL_DATE 
    from {{ source("mage_demo", "project_gcs_to_bigquery_load_gcs_bigquery")}}
)

select * from airline_data