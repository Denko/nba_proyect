with 

player_awards as (

    select * from {{ ref('stg_player_award_shares') }}

),

renamed as (

    select
    
        season,
        award_type,
        player_id,
        player_name,
        player_age,
        team_abbreviation,
        first_points,
        player_points_won,
        max_award_points,
        share_pct,
        winner,
        old_season_id,
        old_player_id

    from player_awards

)

select * from renamed