with 

source as (

    select * from {{ source('google_drive', 'player_award_shares') }}

),

renamed as (

    select
        _LINE::integer AS _line,
        season::integer as season,
        award::varchar(40) as award_type,
        player::varchar(120) as player_name,
        age::integer as player_age,
        tm::varchar(3) as team_abbreviation,
        first::integer as first_points,
        pts_won::integer as player_points_won,
        pts_max::integer as max_award_points,
        share::number(4,3) as share_pct,
        winner::boolean as winner,
        seas_id::integer as old_season_id,
        player_id::integer as old_player_id,
        _fivetran_synced AS loaded_at

    from source

)

select * from renamed
