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
    modifieddate,
    postalcode,
    rowguid,
    spatiallocation,
    stateprovinceid,
    valid_from,
    valid_to
from {{ source('bike_business', 'ops_address_history') }}
