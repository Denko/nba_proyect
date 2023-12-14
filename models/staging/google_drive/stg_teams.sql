WITH teams AS (
    SELECT *
    FROM {{ ref('base_teams') }}
),

renamed_casted AS (
    SELECT
        _line::integer AS _line,
        league_id::integer AS league_id,
        old_team_id::number(38, 0) AS old_team_id,
        team_id::varchar(256) AS games_team_id,
        {{dbt_utils.generate_surrogate_key(['full_name'])}}::varchar(256) as team_id,
        min_year::integer AS first_participation_year,
        max_year::integer AS current_year,
        abbreviation::varchar(3) AS abbreviation,
        nickname::varchar(40) AS nickname,
        yearfounded::integer AS fundation_year,
        city::varchar(40) AS city,
        full_name::varchar(128) AS full_name,
        {{dbt_utils.generate_surrogate_key(['arena'])}}::varchar(256) as arena_id,
        arena::varchar(40) AS arena_name,
        arenacapacity::integer AS arena_capacity,
        owner::varchar(120) AS owner,
        generalmanager::varchar(120) AS general_manager,
        headcoach::varchar(120) AS headcoach,
        dleagueaffiliation::varchar(120) AS d_league_affiliation,
        _fivetran_synced AS loaded_at,
        DBT_UPDATED_AT, 
        DBT_VALID_FROM, 
        DBT_VALID_TO
    FROM teams
)

SELECT * FROM renamed_casted
