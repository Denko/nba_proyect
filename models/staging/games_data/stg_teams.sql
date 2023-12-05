WITH teams AS (
    SELECT *
    FROM {{ ref('base_teams') }}
),

renamed_casted AS (
    SELECT
        _line::integer AS _line,
        league_id::integer AS league_id,
        old_team_id::number(38, 0) AS old_team_id,
        team_id::varchar(256) AS team_id,
        min_year::integer AS first_participation_year,
        max_year::integer AS current_year,
        abbreviation::varchar(3) AS abbreviation,
        nickname::varchar(40) AS nickname,
        yearfounded::integer AS fundation_year,
        city::varchar(40) AS city,
        concat(city, ' ', nickname)::varchar(128) AS full_name,
        arena::varchar(40) AS arena,
        arenacapacity::integer AS arena_capacity,
        owner::varchar(120) AS owner,
        generalmanager::varchar(120) AS general_manager,
        headcoach::varchar(120) AS headcoach,
        dleagueaffiliation::varchar(120) AS d_league_affiliation,
        _fivetran_synced AS loaded_at
    FROM teams
)

SELECT * FROM renamed_casted