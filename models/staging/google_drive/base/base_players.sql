WITH players AS (
    SELECT *
    FROM {{ source('google_drive','players') }}
),

renamed_casted AS (
    SELECT
        _LINE, 
        PLAYER_NAME, 
        TEAM_ID, 
        PLAYER_ID AS OLD_PLAYER_ID,
        {{dbt_utils.generate_surrogate_key(['PLAYER_NAME'])}}::varchar(256) as PLAYER_ID, 
        SEASON, 
        _FIVETRAN_SYNCED
    FROM players
)

SELECT * FROM renamed_casted
