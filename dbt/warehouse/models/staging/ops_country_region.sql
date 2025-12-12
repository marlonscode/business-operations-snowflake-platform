{{
    config(
        materialized="table"
    )
}}

select
    countryregioncode,
    modifieddate,
    name
from {{ source('bike_business', 'ops_country_region') }}
