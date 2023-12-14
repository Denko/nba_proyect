WITH teams AS (
    SELECT *
    FROM {{ ref('teams_snapshot') }}
),

renamed_casted AS (
    SELECT
        _LINE, 
        LEAGUE_ID, 
        TEAM_ID AS OLD_TEAM_ID,
        {{dbt_utils.generate_surrogate_key(['TEAM_ID'])}}::varchar(256) as TEAM_ID, 
        MIN_YEAR, 
        MAX_YEAR, 
        ABBREVIATION, 
        NICKNAME, 
        concat(CITY, ' ', NICKNAME)::varchar(128) AS full_name,
        YEARFOUNDED, 
        CITY, 
        ARENA, 
        ARENACAPACITY, 
        OWNER, 
        GENERALMANAGER, 
        HEADCOACH, 
        DLEAGUEAFFILIATION, 
        _FIVETRAN_SYNCED,
        DBT_UPDATED_AT, 
        DBT_VALID_FROM, 
        DBT_VALID_TO
    FROM teams
)

SELECT * FROM renamed_casted