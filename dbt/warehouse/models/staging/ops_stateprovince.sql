{{
    config(
        materialized="table"
    )
}}

select
    stateprovinceid,
    countryregioncode,
    modifieddate,
    rowguid,
    name,
    territoryid,
    isonlystateprovinceflag,
    stateprovincecode
from {{ source('bike_business', 'ops_stateprovince') }}
