{{ config(
    materialized='incremental',
    unique_key = 'game_detail_id'
    ) 
}}

WITH games_details AS (
    SELECT *
    FROM {{ ref('stg_games_details') }}
    {% if is_incremental() %}

        WHERE loaded_at > (SELECT max(loaded_at) FROM {{ this }})

    {% endif %}
),
teams AS (
    SELECT *
    FROM {{ ref("stg_teams") }}
),
players AS (
    SELECT *
    FROM {{ ref("int_players") }}
),
games AS (
    SELECT *
    FROM {{ ref("stg_games") }}
    {% if is_incremental() %}

        WHERE loaded_at > (SELECT max(loaded_at) FROM {{ this }})

    {% endif %}
),
dates AS (
    SELECT *
    FROM {{ ref("stg_dates") }}
),

 -- Arreglar cuando tenga el cambio en los teams
renamed_casted AS (
    SELECT
        
        games.game_date_est,
        games.season,
        game_detail_id,
        games_details.game_id,
        teams.team_id, 
        -- games_details.game_team_id, -- Solo para el match con teams
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
        plus_minus,
        games_details.loaded_at

    FROM games_details
    full join
    teams on games_details.game_team_id = teams.games_team_id
    full join
    games on games_details.game_id = games.game_id
    left join
    players on games_details.player_id = players.player_id

    order by games.game_id, teams.team_id

)

SELECT * FROM renamed_casted