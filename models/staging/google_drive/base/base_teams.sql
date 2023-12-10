WITH teams AS (
    SELECT *
    FROM {{ source('google_drive','teams') }}
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
        YEARFOUNDED, 
        CITY, 
        ARENA, 
        ARENACAPACITY, 
        OWNER, 
        GENERALMANAGER, 
        HEADCOACH, 
        DLEAGUEAFFILIATION, 
        _FIVETRAN_SYNCED
    FROM teams
)

SELECT * FROM renamed_casted