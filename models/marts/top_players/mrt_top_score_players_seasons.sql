WITH ranked_players AS (
  SELECT
    player_id,
    player_name, 
    season, 
    points,
    games_played,
    RANK() OVER (PARTITION BY season ORDER BY points DESC) as rank
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
  points as total_points,
  games_played,
  points/games_played as avg_points
FROM 
  ranked_players
  inner join dates
  on ranked_players.season = dates.year_date
WHERE 
  rank <= 5
  ORDER BY season DESC