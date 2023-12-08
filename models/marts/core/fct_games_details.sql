WITH games_details AS (
    SELECT *
    FROM {{ ref('stg_games_details') }}
),
teams AS (
    SELECT *
    FROM {{ ref("stg_teams") }}
),
players AS (
    SELECT *
    FROM {{ ref("dim_players") }}
),
games AS (
    SELECT *
    FROM {{ ref("stg_games") }}
),

renamed_casted AS (
    SELECT
        
        game_detail_id,
        games.game_id, 
        teams.team_id, 
        games_details.player_id, 
        start_position, 
        comment, 
        minutes, -- ARREGLAR en el stage para que sea de tipo TIME y poder usarlo para métricas
        field_goals_made, 
        field_goals_attempted, 
        field_goals_pct, -- Contiene nulos al ser porcentaje
        three_points_field_goals_made, 
        three_points_field_goals_attempted, 
        three_points_field_goals_pct, -- Contiene nulos al ser porcentaje
        free_throws_made, 
        free_throws_attempted, 
        free_throws_pct, -- Contiene nulos al ser porcentaje
        offensive_rebounds, 
        defensive_rebounds, 
        total_rebounds, 
        assists, 
        steals, 
        blocks, 
        turnovers, 
        personal_fouls, 
        points, 
        plus_minus

    FROM games_details
    left join
    teams on games_details.team_id = teams.team_id
    left join
    games on games_details.game_id = games.game_id
    left join
    players on games_details.player_id = players.player_id

    order by games.game_id, teams.team_id

)

SELECT * FROM renamed_casted