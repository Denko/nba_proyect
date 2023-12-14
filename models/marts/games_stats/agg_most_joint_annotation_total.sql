WITH 
team_points AS (
    SELECT 
        game_id,
        team_id,
        sum(points) as total_points  

    FROM {{ ref('fct_games_details') }}

    group by 
            game_id,
            team_id

    order by game_id

),

game_points AS (
  SELECT 
  t1.game_id, t1.team_id AS team1_id, 
  t1.total_points AS team1_points, 
  t2.team_id AS team2_id, 
  t2.total_points AS team2_points

  FROM 
    team_points t1
  JOIN 
    team_points t2
  ON t1.game_id = t2.game_id AND t1.team_id < t2.team_id
)

SELECT 
    game_id, 
    team1_id, 
    team2_id, 
    ABS(team1_points + team2_points) AS total_game_points

FROM game_points

ORDER BY total_game_points desc