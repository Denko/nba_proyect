WITH teams_games AS (
    SELECT *
    FROM {{ ref('stg_teams') }}
),
teams_totals AS (
    SELECT *
    FROM {{ ref('stg_team_totals_seasons') }}
),
teams_summaries AS (
    SELECT *
    FROM {{ ref('stg_team_summaries_seasons') }}
),

renamed_casted AS (
    SELECT distinct

        teams_totals.team_id,
        games_team_id, -- para matchear con fct_games y fct_games_details
        CASE -- Si existe el nickname lo coge, si no lo crea a partir del team_name cogiendo la última palabra
            WHEN nickname IS NULL THEN SPLIT(teams_totals.team_name,' ')[array_size(SPLIT(teams_totals.team_name,' '))-1]::varchar(60)
            ELSE nickname
        END AS nickname,
        teams_totals.team_name,
        first_participation_year,
        teams_totals.team_abbreviation,
        fundation_year,
        teams_summaries.city,
        owner,
        general_manager,
        headcoach,
        d_league_affiliation

    FROM teams_totals
    left join
    teams_games
    on teams_totals.team_id = teams_games.team_id
    left join
    teams_summaries
    on teams_totals.team_id = teams_summaries.team_id

    -- where games_team_id is not null -- FILTRA LAS CIUDADES DONDE YA NO HAY EQUIPOS

    group by
        teams_totals.team_id,
        games_team_id,
        teams_totals.team_name,
        nickname,
        first_participation_year,
        current_year,
        teams_totals.team_abbreviation,
        fundation_year,
        teams_summaries.city,
        owner,
        general_manager,
        headcoach,
        d_league_affiliation
)

SELECT * FROM renamed_casted