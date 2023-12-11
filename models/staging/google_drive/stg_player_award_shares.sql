with 

source as (

    select * from {{ ref('base_player_award_shares') }}

),

renamed as (

    select
        _LINE::integer AS _line,
        season::integer as season,
        award::varchar(40) as award_type,
        {{dbt_utils.generate_surrogate_key(['player'])}}::varchar(256) as player_id,
        player::varchar(120) as player_name,
        age::integer as player_age,
        tm::varchar(3) as team_abbreviation,
        DECODE(first_points,'NA',0,first_points)::integer as first_points,
        DECODE(pts_won,'NA',0,pts_won)::integer as player_points_won,
        DECODE(pts_max,'NA',0,pts_max)::integer as max_award_points,
        DECODE(share,'NA',null,share)::number(4,3) as share_pct,
        DECODE(winner,'NA',false,winner)::boolean as winner,
        seas_id::integer as old_season_id,
        player_id::integer as old_player_id,
        _fivetran_synced AS loaded_at

    from source

)

select * from renamed
