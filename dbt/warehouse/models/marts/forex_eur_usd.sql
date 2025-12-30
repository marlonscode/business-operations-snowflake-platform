{{
    config(
        materialized="table"
    )
}}

select
    {{ dbt_utils.generate_surrogate_key(['base_currency', 'quote_currency', 'timestamp']) }} as forex_eur_usd_key,
    base_currency,
    quote_currency,
    exchange_rate,
    timestamp
from {{ ref('stg_forex_eur_usd') }}