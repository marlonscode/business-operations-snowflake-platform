{{
    config(
        materialized="table"
    )
}}

select
    cardnumber,
    cardtype,
    creditcardid,
    expmonth,
    expyear,
    modifieddate
from {{ source('bike_business', 'ops_credit_card') }}
