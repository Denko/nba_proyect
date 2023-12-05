WITH games_details AS (
    SELECT *
    FROM {{ ref('base_games_details') }}
),

renamed_casted AS (
    SELECT
        
        _LINE::integer AS _line, 
        GAME_DETAIL_ID::varchar(256) as game_detail_id,
        {{dbt_utils.generate_surrogate_key(['GAME_ID'])}}::varchar(256) as game_id, 
        {{dbt_utils.generate_surrogate_key(['TEAM_ID'])}}::varchar(256) as team_id, 
        TEAM_ABBREVIATION::varchar(3) as team_abbreviation, 
        TEAM_CITY::varchar(40) as team_city, 
        {{dbt_utils.generate_surrogate_key(['PLAYER_ID'])}}::varchar(256) as player_id, 
        PLAYER_NAME::varchar(120) as player_name,
        NICKNAME::varchar(40) as player_nickname, 
        DECODE(START_POSITION,null,'bench',START_POSITION)::varchar(5) as start_position, 
        DECODE(COMMENT,null,'nc',COMMENT)::varchar(40) as comment, 
        DECODE(MINUTES,null,'00:00',left(MINUTES,5))::varchar(5) as minutes, 
        DECODE(FGM,null,'0',FGM)::integer as field_goals_made, 
        DECODE(FGA,null,'0',FGA)::integer as field_goals_attempted, 
        replace(FG_PCT,',','.')::number(4,3) as field_goals_pct, -- Contiene nulos al ser porcentaje
        DECODE(FG_3_M,null,'0',FG_3_M)::integer as three_points_field_goals_made, 
        DECODE(FG_3_A,null,'0',FG_3_A)::integer as three_points_field_goals_attempted, 
        replace(FG_3_PCT,',','.')::number(4,3) as three_points_field_goals_pct, -- Contiene nulos al ser porcentaje
        DECODE(FTM,null,'0',FTM)::integer as free_throws_made, 
        DECODE(FTA,null,'0',FTA)::integer as free_throws_attempted, 
        replace(FT_PCT,',','.')::number(4,3) as free_throws_pct, -- Contiene nulos al ser porcentaje
        DECODE(OREB,null,'0',OREB)::integer as offensive_rebounds, 
        DECODE(DREB,null,'0',DREB)::integer as defensive_rebounds, 
        DECODE(REB,null,'0',REB)::integer as total_rebounds, 
        DECODE(AST,null,'0',AST)::integer as assists, 
        DECODE(STL,null,'0',STL)::integer as steals, 
        DECODE(BLK,null,'0',BLK)::integer as blocks, 
        DECODE(TURNOVERS,null,'0',TURNOVERS)::integer as turnovers, 
        DECODE(PF,null,'0',PF)::integer as personal_fouls, 
        DECODE(PTS,null,'0',PTS)::integer as points, 
        DECODE(PLUS_MINUS,null,'0',PLUS_MINUS)::integer as plus_minus, 
        _FIVETRAN_SYNCED as loaded_at

    FROM games_details
)

SELECT * FROM renamed_casted
