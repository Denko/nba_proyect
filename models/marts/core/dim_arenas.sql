WITH teams1 AS (
    SELECT *
    FROM {{ ref('stg_teams') }}
),
teams2 AS (
    SELECT *
    FROM {{ ref('stg_team_summaries_seasons') }}
    WHERE season > 2002
),

renamed_casted AS (
    SELECT distinct

        teams2.arena_id,
        teams2.arena_name,
        teams1.arena_capacity,
        teams2.city

    FROM teams1
    right join
    teams2
    on teams1.arena_id = teams2.arena_id
)

SELECT * FROM renamed_casted
