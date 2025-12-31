{{
    config(
        materialized="table"
    )
}}

with base_table as (
    select
        time_published,
        date_trunc('day', time_published)::date as date,
        news_source,
        news_headline,
        news_summary,
        source_url,
        sentiment_score,
        sentiment_label
    from {{ ref('stg_sentiment') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['date']) }} as sentiment_key,
    date,
    round(avg(sentiment_score), 3) as sentiment_score,
    case
        when avg(sentiment_score) > 0.5 then 'Very Positive'
        when avg(sentiment_score) > 0.1 then 'Positive'
        when avg(sentiment_score) > 0.05 then 'Neutral'
        else 'Negative'
    end as sentiment_label
from base_table
group by date
