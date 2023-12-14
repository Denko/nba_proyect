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
        int_teams.d_league_affiliation

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