WITH int_players AS (
    SELECT *
    FROM {{ ref('int_players') }}

),

renamed_casted AS (
    SELECT distinct

        int_players.player_id, 
        int_players.player_name
        
    FROM
        int_players

    order by player_name
)

SELECT * FROM renamed_casted
