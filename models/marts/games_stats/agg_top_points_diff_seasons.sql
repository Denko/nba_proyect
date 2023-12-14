WITH 
team_points AS (
    SELECT 
        game_id, 
        team_id, 
        season, 
        SUM(points) AS total_points
    FROM {{ ref('fct_games_details') }}
    GROUP BY 
        game_id, 
        team_id, 
        season
),

game_points AS (
    SELECT 
        t1.game_id, 
        t1.team_id AS team1_id, 
        t1.total_points AS team1_points,
        t2.team_id AS team2_id, 
        t2.total_points AS team2_points, 
        t1.season
    FROM team_points t1
    JOIN team_points t2
    ON t1.game_id = t2.game_id AND t1.team_id < t2.team_id
),

points_difference AS (
  SELECT 
    game_id, 
    team1_id, 
    team2_id, 
    team1_points - team2_points AS points_difference, 
    season, 
    RANK() OVER (PARTITION BY season ORDER BY ABS(team1_points - team2_points) DESC) AS ranking
  FROM game_points
)

SELECT 
    game_id, 
    team1_id, 
    team2_id, 
    ABS(points_difference) as points_difference, 
    season
FROM points_difference
WHERE ranking <= 5
order by season desc
