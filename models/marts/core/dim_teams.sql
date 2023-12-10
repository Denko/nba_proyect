WITH teams AS (
    SELECT *
    FROM {{ ref('stg_teams') }}
),
teams_totals AS (
    SELECT *
    FROM {{ ref('stg_team_totals_seasons') }}
    WHERE season > 2002
),

renamed_casted AS (
    SELECT distinct

        teams_totals.team_id,
        -- games_team_id, -- para matchear con fct_games y fct_games_details
        nickname,
        full_name,
        first_participation_year,
        abbreviation,
        fundation_year,
        city,
        arena_id,
        owner,
        general_manager,
        headcoach,
        d_league_affiliation,
        -- AÑADIR LAS ESTADÍSTICAS TOTALES SUMADAS DE LAS TEMPORADAS QUE HAY, DE 2004 A 2021 DE STG_TEAM_TOTALS_SEASONS
        sum(teams_totals.minutes_played) as total_minutes_played,
        sum(teams_totals.games_played) as total_games_played
        -- O HACER EN AGREGADOS DESPUÉS DE LAS DIMENSIONES

    FROM teams
    left join
    teams_totals
    on teams.team_id = teams_totals.team_id
    group by
        teams_totals.team_id,
        nickname,
        full_name,
        first_participation_year,
        current_year,
        abbreviation,
        fundation_year,
        city,
        arena_id,
        owner,
        general_manager,
        headcoach,
        d_league_affiliation
)

SELECT * FROM renamed_casted