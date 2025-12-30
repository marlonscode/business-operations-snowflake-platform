{{
    config(
        materialized="table"
    )
}}

select
    countryregioncode,
    name,
    modifieddate
from {{ source('bike_business', 'ops_country_region') }}
