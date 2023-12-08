WITH games AS (
    SELECT *
    FROM {{ ref('stg_games') }}
),
teams AS (
    SELECT *
    FROM {{ ref('stg_teams') }}
),
dates AS (
    SELECT *
    FROM {{ ref('stg_dates') }}
),
 -- CREAR UNIONES 
renamed_casted AS (
    SELECT

        game_date_est, 
        game_id, 
        game_status, 
        home_team_id, 
        visitor_team_id, 
        season,  
        home_points, 
        home_field_goals_pct, 
        home_free_throws_pct, 
        home_3point_field_goals_pct, 
        home_assists, 
        home_rebounds, 
        away_points, 
        away_field_goals_pct, 
        away_free_throws_pct, 
        away_3point_field_goals_pct, 
        away_assists, 
        away_rebounds, 
        home_team_wins

    FROM games
)

SELECT * FROM renamed_casted