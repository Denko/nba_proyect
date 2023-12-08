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

    FROM teams
)

SELECT * FROM renamed_casted