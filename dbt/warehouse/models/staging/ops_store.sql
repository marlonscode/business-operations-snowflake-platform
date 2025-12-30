{{
    config(
        materialized="table"
    )
}}

select
    businessentityid,
    storename,
    salespersonid,
    modifieddate
from {{ source('bike_business', 'ops_store') }}
