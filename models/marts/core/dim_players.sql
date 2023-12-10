WITH players AS (
    SELECT *
    FROM {{ ref('stg_players') }}
),

renamed_casted AS (
    SELECT distinct

        player_id, 
        player_name
        -- AÑADIR LAS ESTADÍSTICAS TOTALES SUMADAS DE LAS TEMPORADAS QUE HAY, DE 2004 A 2021 DE STG_PLAYER_TOTAL_SEASONS
        -- AÑADIR NÚMERO DE PARTICIPACIONES EN EL ALL-STAR DE STG_ALL STAR_SELECTIONS
        -- AÑADIR PREMIOS, SI LOS TIENE DE STG_PLAYER_AWARD_SHARES
        -- O HACER EN AGREGADOS DESPUÉS DE LAS DIMENSIONES
        
    FROM players

    order by player_name
)

SELECT * FROM renamed_casted
