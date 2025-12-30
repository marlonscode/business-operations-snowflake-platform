{{
    config(
        materialized="table"
    )
}}

select
    {{ dbt_utils.generate_surrogate_key(['creditcardid']) }} as creditcard_key,
    creditcardid as creditcard_id,
    cardnumber as card_number,
    cardtype as card_type,
    expmonth as exp_month,
    expyear as exp_year
from {{ ref('ops_credit_card') }}