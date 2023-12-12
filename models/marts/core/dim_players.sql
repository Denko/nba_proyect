WITH players_games AS (
    SELECT *
    FROM {{ ref('stg_players') }}
),
players_totals AS (
    SELECT *
    FROM {{ ref('stg_player_totals_seasons') }}

),
players_awards AS (
    SELECT *
    FROM {{ ref('stg_player_award_shares') }}

),
players_all_stars AS (
    SELECT *
    FROM {{ ref('stg_all_star_selections') }}

),
int_players AS (
    SELECT *
    FROM {{ ref('int_players') }}

),

renamed_casted AS (
    SELECT distinct

        int_players.player_id, 
        int_players.player_name
        -- AÑADIR LAS ESTADÍSTICAS TOTALES SUMADAS DE LAS TEMPORADAS QUE HAY STG_PLAYER_TOTAL_SEASONS
        -- AÑADIR NÚMERO DE PARTICIPACIONES EN EL ALL-STAR DE STG_ALL STAR_SELECTIONS
        -- AÑADIR PREMIOS, SI LOS TIENE DE STG_PLAYER_AWARD_SHARES
        -- O HACER EN AGREGADOS DESPUÉS DE LAS DIMENSIONES
        
    FROM
        int_players
    left join
        players_totals
    on int_players.player_id = players_totals.player_id
    left join
        players_awards
    on int_players.player_id = players_awards.player_id
    left join
        players_all_stars
    on int_players.player_id = players_all_stars.player_id
    left join 
        players_games
    on int_players.player_id = players_games.player_id

    order by player_name
)

SELECT * FROM renamed_casted
