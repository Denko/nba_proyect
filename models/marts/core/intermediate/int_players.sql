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
-- LIST OF ALL PLAYERS IN HISTORY WITH HIS PLAYER_ID
renamed_casted AS (
    SELECT DISTINCT

        players_totals.player_id,
        players_totals.player_name,
        players_games.old_player_id as games_player_id


    FROM
        players_totals
    LEFT JOIN
        players_games
        ON players_totals.player_id = players_games.player_id
    LEFT JOIN
        players_awards
        ON players_totals.player_id = players_awards.player_id
    LEFT JOIN
        players_all_stars
        ON players_totals.player_id = players_all_stars.player_id

    ORDER BY player_name
)

SELECT * FROM renamed_casted
