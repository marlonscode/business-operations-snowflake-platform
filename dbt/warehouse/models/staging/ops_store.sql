{{
    config(
        materialized="table"
    )
}}

select
    businessentityid,
    modifieddate,
    salespersonid,
    storename
from {{ source('bike_business', 'ops_store') }}
