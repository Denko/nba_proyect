with 

player_awards as (

    select * from {{ ref('stg_player_award_shares') }}

),
dates AS (
    SELECT distinct year_date
    FROM {{ ref('stg_dates') }}
),

renamed as (

    select
    
        season,
        award_type,
        player_id,
        player_name,
        player_age,
        team_abbreviation, -- FALTA HACER JOIN CON EL EQUIPO Y METER EL NOMBRE DEL EQUIPO
        -- NOMBRE COMPLETO DEL EQUIPO DESDE EL JOIN CON TEAM TOTAL SEASONS POR team_abbreviation
        first_points,
        player_points_won,
        max_award_points,
        share_pct,
        winner,
        old_season_id,
        old_player_id

    from player_awards
    inner join 
    dates on player_awards.season = dates.year_date

)

select * from renamed