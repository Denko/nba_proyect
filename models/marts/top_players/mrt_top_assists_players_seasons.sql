WITH ranked_players AS (
  SELECT
    player_id,
    player_name, 
    season, 
    assists,
    games_played,
    RANK() OVER (PARTITION BY season ORDER BY assists DESC) as rank
  FROM 
    {{ ref('stg_player_totals_seasons') }}
),
dates AS (
    SELECT distinct year_date
    FROM {{ ref('stg_dates') }}
)

SELECT 
  player_name, 
  season, 
  assists as total_assists,
  games_played,
  assists/games_played as avg_assists
FROM 
  ranked_players
  inner join dates
  on ranked_players.season = dates.year_date
WHERE 
  rank <= 5
ORDER BY season DESC