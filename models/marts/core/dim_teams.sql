WITH teams AS (
    SELECT *
    FROM {{ ref('stg_teams') }}
),
teams_totals AS (
    SELECT *
    FROM {{ ref('stg_team_totals_seasons') }}

),

int_teams AS (
    SELECT *
    FROM {{ ref('int_teams') }}
),


renamed_casted AS (
    SELECT distinct

        teams_totals.team_id,
        -- games_team_id, -- para matchear con fct_games y fct_games_details
        int_teams.nickname,
        teams_totals.team_name,
        int_teams.first_participation_year,
        int_teams.team_abbreviation,
        int_teams.fundation_year,
        int_teams.city,
        int_teams.owner,
        int_teams.general_manager,
        int_teams.headcoach,
        int_teams.d_league_affiliation,
        -- AÑADIR LAS ESTADÍSTICAS TOTALES SUMADAS DE LAS TEMPORADAS QUE HAY, DE 2004 A 2021 DE STG_TEAM_TOTALS_SEASONS
        sum(teams_totals.minutes_played) as total_minutes_played,
        sum(teams_totals.games_played) as total_games_played
        -- O HACER EN AGREGADOS DESPUÉS DE LAS DIMENSIONES

    FROM teams_totals
    left join
    teams
    on teams_totals.team_id = teams.team_id
    full join
    int_teams
    on teams_totals.team_id = int_teams.team_id

    group by
        teams_totals.team_id,
        int_teams.nickname,
        teams_totals.team_name,
        int_teams.first_participation_year,
        int_teams.team_abbreviation,
        int_teams.fundation_year,
        int_teams.city,
        int_teams.owner,
        int_teams.general_manager,
        int_teams.headcoach,
        int_teams.d_league_affiliation
)

SELECT * FROM renamed_casted