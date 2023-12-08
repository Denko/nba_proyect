WITH games_details AS (
    SELECT *
    FROM {{ source('games_data','games_details') }}
),

renamed_casted AS (
    SELECT
        
        _LINE, 
        {{dbt_utils.generate_surrogate_key(['GAME_ID','PLAYER_ID'])}}::varchar(256) as GAME_DETAIL_ID,
        GAME_ID, 
        TEAM_ID, 
        TEAM_ABBREVIATION, 
        TEAM_CITY, 
        PLAYER_ID, 
        PLAYER_NAME,
        NICKNAME, 
        START_POSITION, 
        COMMENT, 
        "MIN" AS MINUTES, 
        FGM, 
        FGA, 
        FG_PCT, 
        FG_3_M, 
        FG_3_A, 
        FG_3_PCT, 
        FTM, 
        FTA, 
        FT_PCT, 
        OREB, 
        DREB, 
        REB, 
        AST, 
        STL, 
        BLK, 
        "TO" AS TURNOVERS, 
        PF, 
        PTS, 
        PLUS_MINUS, 
        _FIVETRAN_SYNCED

    FROM games_details
)

SELECT * FROM renamed_casted