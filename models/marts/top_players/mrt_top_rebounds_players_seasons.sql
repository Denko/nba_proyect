WITH ranked_players AS (
  SELECT
    player_id,
    player_name, 
    season, 
    total_rebounds,
    games_played,
    RANK() OVER (PARTITION BY season ORDER BY total_rebounds DESC) as rank
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
  total_rebounds,
  games_played,
  total_rebounds/games_played as avg_rebounds
FROM 
  ranked_players
  inner join dates
  on ranked_players.season = dates.year_date
WHERE 
  rank <= 5
  ORDER BY season DESC