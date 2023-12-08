WITH players AS (
    SELECT *
    FROM {{ ref('stg_players') }}
),
teams AS (
    SELECT *
    FROM {{ ref('stg_teams') }}
),

renamed_casted AS (
    SELECT

        player_id, 
        teams.team_id, 
        season
        
    FROM players
    left join 
    teams on players.team_id = teams.team_id
)

SELECT * FROM renamed_casted