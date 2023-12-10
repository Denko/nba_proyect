WITH players_games AS (
    SELECT *
    FROM {{ ref('stg_players') }}
),
players_totals AS (
    SELECT *
    FROM {{ ref('stg_player_totals_seasons') }}
    WHERE season > 2002
),
players_awards AS (
    SELECT *
    FROM {{ ref('stg_player_award_shares') }}
    WHERE season > 2002
),
players_all_stars AS (
    SELECT *
    FROM {{ ref('stg_all_star_selections') }}
    WHERE season > 2002
),

renamed_casted AS (
    SELECT distinct

        players_totals.player_id, 
        players_totals.player_name
        -- AÑADIR LAS ESTADÍSTICAS TOTALES SUMADAS DE LAS TEMPORADAS QUE HAY, DE 2004 A 2021 DE STG_PLAYER_TOTAL_SEASONS
        -- AÑADIR NÚMERO DE PARTICIPACIONES EN EL ALL-STAR DE STG_ALL STAR_SELECTIONS
        -- AÑADIR PREMIOS, SI LOS TIENE DE STG_PLAYER_AWARD_SHARES
        -- O HACER EN AGREGADOS DESPUÉS DE LAS DIMENSIONES
        
    FROM players_games
    full join
    players_totals
    on players_games.player_id = players_totals.player_id
    full join
    players_awards
    on players_totals.player_id = players_awards.player_id
    full join
    players_all_stars
    on players_totals.player_id = players_all_stars.player_id

    order by player_name
)

SELECT * FROM renamed_casted
