WITH players AS (
    SELECT *
    FROM {{ ref('stg_players') }}
),

renamed_casted AS (
    SELECT distinct

        player_id, 
        player_name
        
    FROM players

    order by player_name
)

SELECT * FROM renamed_casted
