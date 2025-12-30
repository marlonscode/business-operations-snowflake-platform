{{
    config(
        materialized="table"
    )
}}

select
    addressid,
    addressline1,
    addressline2,
    city,
    stateprovinceid,
    postalcode,
    spatiallocation,
    rowguid,
    modifieddate
from {{ source('bike_business', 'ops_address') }}
