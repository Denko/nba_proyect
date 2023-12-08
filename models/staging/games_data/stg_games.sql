WITH games AS (
    SELECT *
    FROM {{ ref('base_games') }}
),

renamed_casted AS (
    SELECT

        _LINE::integer AS _line,
        date(game_date_est,'DD/MM/YYYY') as game_date_est, 
        OLD_GAME_ID::number(38,0) as old_game_id,
        GAME_ID::varchar(256) as game_id, 
        GAME_STATUS_TEXT::varchar(40) as game_status, 
        {{dbt_utils.generate_surrogate_key(['HOME_TEAM_ID'])}}::varchar(256) as home_team_id, 
        {{dbt_utils.generate_surrogate_key(['VISITOR_TEAM_ID'])}}::varchar(256) as visitor_team_id, 
        SEASON::integer as season,  
        PTS_HOME::integer as home_points, 
        replace(FG_PCT_HOME,',','.')::number(4,3) as home_field_goals_pct, 
        replace(FT_PCT_HOME,',','.')::number(4,3) as home_free_throws_pct, 
        replace(FG_3_PCT_HOME,',','.')::number(4,3) as home_3point_field_goals_pct, 
        AST_HOME::integer as home_assists, 
        REB_HOME::integer as home_rebounds, 
        PTS_AWAY::integer as away_points, 
        replace(FG_PCT_AWAY,',','.')::number(4,3) as away_field_goals_pct, 
        replace(FT_PCT_AWAY,',','.')::number(4,3) as away_free_throws_pct, 
        replace(FG_3_PCT_AWAY,',','.')::number(4,3) as away_3point_field_goals_pct, 
        AST_AWAY::integer as away_assists, 
        REB_AWAY::integer as away_rebounds, 
        HOME_TEAM_WINS::boolean as home_team_wins, 
        _FIVETRAN_SYNCED as loaded_at

    FROM games
)

SELECT * FROM renamed_casted