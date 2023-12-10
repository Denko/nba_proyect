WITH games AS (
    SELECT *
    FROM {{ source('google_drive','games') }}
),

renamed_casted AS (
    SELECT

        _LINE,
        GAME_DATE_EST, 
        GAME_ID as OLD_GAME_ID,
        {{dbt_utils.generate_surrogate_key(['GAME_ID'])}}::varchar(256) as GAME_ID, 
        GAME_STATUS_TEXT, 
        HOME_TEAM_ID, 
        VISITOR_TEAM_ID, 
        SEASON, 
        TEAM_ID_HOME, 
        PTS_HOME, 
        FG_PCT_HOME, 
        FT_PCT_HOME, 
        FG_3_PCT_HOME, 
        AST_HOME, 
        REB_HOME, 
        TEAM_ID_AWAY, 
        PTS_AWAY, 
        FG_PCT_AWAY, 
        FT_PCT_AWAY, 
        FG_3_PCT_AWAY, 
        AST_AWAY, 
        REB_AWAY, 
        HOME_TEAM_WINS, 
        _FIVETRAN_SYNCED

    FROM games
)

SELECT * FROM renamed_casted

