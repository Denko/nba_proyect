WITH arenas AS (
    SELECT *
    FROM {{ ref('stg_teams') }}
),

renamed_casted AS (
    SELECT distinct

        arena_id,
        arena_name,
        arena_capacity,
        city

    FROM arenas
)

SELECT * FROM renamed_casted
