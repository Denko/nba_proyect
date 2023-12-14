WITH 

teams_totals AS (
    SELECT *
    FROM {{ ref('stg_team_totals_seasons') }}

),

int_teams AS (
    SELECT *
    FROM {{ ref('int_teams') }}
),


renamed_casted AS (
    SELECT 

        teams_totals.team_id,
        teams_totals.team_name,
        -- ESTADÍSTICAS TOTALES SUMADAS DE LAS TEMPORADAS QUE HAY
        sum(teams_totals.games_played) as total_games_played,
        sum(teams_totals.minutes_played) as total_minutes_played,
        sum(teams_totals.points) as total_points,
        sum(teams_totals.field_goals_made) as total_field_goals_made,
        sum(teams_totals.field_goals_attempted) as total_field_goals_attempted,
        avg(teams_totals.field_goals_pct) as field_goals_pct,
        sum(teams_totals.three_points_field_goals_made) as total_three_points_field_goals_made,
        sum(teams_totals.three_points_field_goals_attempted) as total_three_points_field_goals_attempted,
        avg(teams_totals.three_points_field_goals_pct) as three_points_field_goals_pct,
        sum(teams_totals.two_points_field_goals_made) as total_two_points_field_goals_made,
        sum(teams_totals.two_points_field_goals_attempted) as total_two_points_field_goals_attempted,
        avg(teams_totals.two_points_field_goals_pct) as two_points_field_goals_pct,
        sum(teams_totals.free_throws_made) as total_free_throws_made,
        sum(teams_totals.free_throws_attempted) as total_free_throws_attempted,
        avg(teams_totals.free_throws_pct) as free_throws_pct,
        sum(teams_totals.offensive_rebounds) as total_offensive_rebounds,
        sum(teams_totals.defensive_rebounds) as total_defensive_rebounds,
        sum(teams_totals.total_rebounds) as total_total_rebounds,
        sum(teams_totals.assists) as total_assists,
        sum(teams_totals.steals) as total_steals,
        sum(teams_totals.blocks) as total_blocks,
        sum(teams_totals.persona_fouls) as total_persona_fouls

    FROM teams_totals
    full join
    int_teams
    on teams_totals.team_id = int_teams.team_id

    group by
        teams_totals.team_id, teams_totals.team_name
    order by total_points desc
)

SELECT * FROM renamed_casted