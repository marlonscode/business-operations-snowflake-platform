{{
    config(
        materialized="table"
    )
}}

select
    countryregioncode,
    isonlystateprovinceflag,
    modifieddate,
    name,
    rowguid,
    stateprovincecode,
    stateprovinceid,
    territoryid
from {{ source('bike_business', 'ops_stateprovince') }}
