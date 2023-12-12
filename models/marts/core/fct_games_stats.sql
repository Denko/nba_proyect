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

        game_id as game_stats_id,
        game_date_est,  
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
        away_rebounds

    FROM games
    left join teams
    on games.game_home_team_id = teams.team_id or games.game_visitor_team_id = teams.team_id
    inner join dates
    on games.game_date_est = dates.date_forecast
)

SELECT * FROM renamed_casted