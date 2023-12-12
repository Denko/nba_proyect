WITH games AS (
    SELECT *
    FROM {{ ref('stg_games') }}
),
teams AS (
    SELECT *
    FROM {{ ref('stg_teams') }}
),

renamed_casted AS (
    SELECT

        game_id, 
        game_status, 
        game_home_team_id, 
        game_visitor_team_id, 
        home_team_wins

    FROM games
    left join teams
    on games.game_home_team_id = teams.team_id or games.game_visitor_team_id = teams.team_id

)

SELECT * FROM renamed_casted