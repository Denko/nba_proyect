WITH teams AS (
    SELECT *
    FROM {{ ref('stg_teams') }}
),

renamed_casted AS (
    SELECT

        team_id,
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
        -- AÑADIR LAS ESTADÍSTICAS TOTALES SUMADAS DE LAS TEMPORADAS QUE HAY, DE 2004 A 2021 DE STG_TEAM_TOTALS_SEASONS
        -- O HACER EN AGREGADOS DESPUÉS DE LAS DIMENSIONES

    FROM teams
)

SELECT * FROM renamed_casted