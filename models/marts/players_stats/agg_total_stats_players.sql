WITH

player_totals AS (
    SELECT *
    FROM {{ ref('stg_player_totals_seasons') }}

),

int_players AS (
    SELECT *
    FROM {{ ref('int_players') }}
),

all_star_selections AS (
    SELECT
        player_id,
        player_name,
        count(*) AS times_all_star_selected
    FROM {{ ref('stg_all_star_selections') }}
    GROUP BY
        player_id,
        player_name
    ORDER BY
        times_all_star_selected DESC
),

players_awards AS (
    SELECT
        player_id,
        player_name,
        count(*) AS player_awards_counter
    FROM {{ ref('stg_player_award_shares') }}
    GROUP BY
        player_id,
        player_name
    ORDER BY
        player_awards_counter DESC
),



renamed AS (

    SELECT

        player_totals.player_id,
        player_totals.player_name,
        -- NÚMERO DE PARTICIPACIONES EN EL ALL-STAR, SI LOS TIENE
        decode(
            times_all_star_selected, null, '0', times_all_star_selected
        )::integer AS times_all_star_selected,
        -- PREMIOS, SI LOS TIENE
        decode(player_awards_counter, null, '0', player_awards_counter)::integer AS player_awards_counter,
        -- Estadísticas totales del jugador
        sum(games_played) AS total_games_played,
        sum(games_started) AS total_games_started,
        sum(minutes_played) AS total_minutes_played,
        sum(points) AS total_points,
        sum(field_goals_made) AS total_field_goals_made,
        sum(field_goals_attempted) AS total_field_goals_attempted,
        avg(field_goals_pct) AS field_goals_pct,
        sum(three_points_field_goals_made)
            AS total_three_points_field_goals_made,
        sum(three_points_field_goals_attempted)
            AS total_three_points_field_goals_attempted,
        avg(three_points_field_goals_pct) AS three_points_field_goals_pct,
        sum(two_points_field_goals_made) AS total_two_points_field_goals_made,
        sum(two_points_field_goals_attempted)
            AS total_two_points_field_goals_attempted,
        avg(two_points_field_goals_pct) AS two_points_field_goals_pct,
        avg(eficiency_field_goals_pct) AS eficiency_field_goals_pct,
        sum(free_throws_made) AS total_free_throws_made,
        sum(free_throws_attempted) AS total_free_throws_attempted,
        avg(free_throws_pct) AS free_throws_pct,
        sum(offensive_rebounds) AS total_offensive_rebounds,
        sum(defensive_rebounds) AS total_defensive_rebounds,
        sum(total_rebounds) AS total_rebounds,
        sum(assists) AS total_assists,
        sum(steals) AS total_steals,
        sum(blocks) AS total_blocks,
        sum(turnovers) AS total_turnovers,
        sum(persona_fouls) AS total_persona_fouls_made

    FROM
        player_totals
    FULL JOIN
        int_players
        ON player_totals.player_id = int_players.player_id
    LEFT JOIN
        all_star_selections
        ON player_totals.player_id = all_star_selections.player_id
    LEFT JOIN
        players_awards
        ON player_totals.player_id = players_awards.player_id

    GROUP BY
        player_totals.player_id,
        player_totals.player_name,
        times_all_star_selected,
        player_awards_counter

    ORDER BY
        total_points DESC

)

SELECT * FROM renamed
