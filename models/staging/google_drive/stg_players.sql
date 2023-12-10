WITH players AS (
    SELECT *
    FROM {{ ref('base_players') }}
),

renamed_casted AS (
    SELECT
        _LINE::integer AS _line, 
        PLAYER_NAME::varchar(120) as player_name, 
        {{dbt_utils.generate_surrogate_key(['TEAM_ID'])}}::varchar(256)as team_id, 
        OLD_PLAYER_ID::integer as old_player_id,
        PLAYER_ID::varchar(256) as player_id, 
        SEASON::integer as season, 
        _FIVETRAN_SYNCED as loaded_at
    FROM players
)

SELECT * FROM renamed_casted
