with 

source as (

    select * from {{ source('google_drive', 'all_star_selections') }}

),

renamed as (

    select
        _LINE::integer AS _line,
        player::varchar(120) as player_name,
        team::varchar(40) as team_name,
        lg::varchar(10) as league_name,
        season::integer as season,
        replaced::boolean as is_replaced,
        _fivetran_synced AS loaded_at

    from source

)

select * from renamed
