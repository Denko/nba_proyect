WITH int_players AS (
    SELECT *
    FROM {{ ref('int_players') }}
),
int_teams AS (
    SELECT *
    FROM {{ ref('int_teams') }}
),
dates AS (
    SELECT distinct year_date
    FROM {{ ref('stg_dates') }}
),
player_totals_seasons AS (
    SELECT 
        player_id,
        team_abbreviation,
        season
    FROM {{ ref('stg_player_totals_seasons') }}
),



renamed_casted AS (
    SELECT distinct

        player_totals_seasons.player_id, 
        int_teams.team_id, 
        player_totals_seasons.season
        
    FROM
        player_totals_seasons
    inner join
        int_players
    on player_totals_seasons.player_id = int_players.player_id
    inner join
        dates
    on player_totals_seasons.season = dates.year_date
    inner join
        int_teams
    on player_totals_seasons.team_abbreviation = int_teams.team_abbreviation
    

    order by season desc, team_id

)

SELECT * FROM renamed_casted