with 

player_awards as (

    select * from {{ ref('stg_player_award_shares') }}

),
dates AS (
    SELECT distinct year_date
    FROM {{ ref('stg_dates') }}
),
int_teams AS (
    SELECT *
    FROM {{ ref('int_teams') }}
),

renamed as (

    select
    
        season,
        award_type,
        winner,
        player_id,
        player_name,
        player_age,
        int_teams.team_name as team_name,
        first_points,
        player_points_won,
        max_award_points,
        share_pct     

    from player_awards
    inner join 
    dates on player_awards.season = dates.year_date
    inner join
    int_teams on player_awards.team_abbreviation = int_teams.team_abbreviation

    order by season desc, award_type, player_points_won desc

)

select * from renamed