{{
    config(
        materialized="table"
    )
}}

select
    creditcardid,
    cardtype,
    expyear,
    expmonth,
    cardnumber,
    modifieddate
from {{ source('bike_business', 'ops_credit_card') }}
