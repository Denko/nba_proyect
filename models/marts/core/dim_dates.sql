with

source as (

    select * from {{ ref('stg_dates') }}

),

renamed as (

    select
        date_forecast
        , date_id
        , year_date
        , month_date
        , desc_month
        , year_month_id
        --, day_before
        --, year_week_day
        --, week_date
        

    from source
    

)

select * from renamed