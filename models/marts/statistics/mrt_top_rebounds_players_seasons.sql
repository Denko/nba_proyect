WITH ranked_players AS (
    SELECT
        player_id,
        player_name, 
        season, 
        total_rebounds,
        games_played,
        RANK() OVER (PARTITION BY season ORDER BY total_rebounds DESC) as ranking
    FROM 
        {{ ref('stg_player_totals_seasons') }}
),
dates AS (
    SELECT distinct year_date
    FROM {{ ref('stg_dates') }}
),
int_players AS (
    SELECT *
    FROM {{ ref('int_players') }}
)

SELECT 
    ranked_players.player_id,
    ranked_players.player_name, 
    season, 
    total_rebounds,
    games_played,
    total_rebounds/games_played as avg_rebounds
FROM 
    ranked_players
    inner join dates
    on ranked_players.season = dates.year_date
    inner join int_players
    on ranked_players.player_id = int_players.player_id

WHERE 
    ranking <= 5
ORDER BY season DESC