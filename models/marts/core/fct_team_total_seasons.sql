with 

team_totals_seasons as (

    select * from {{ ref('stg_team_totals_seasons') }}

),
int_teams as (

    select * from {{ ref('int_teams') }}

),
dates as (

    select distinct year_date from {{ ref('stg_dates') }}

),

renamed as (

    select

        season,
        league,
        team_totals_seasons.team_id,
        team_totals_seasons.team_name,
        team_totals_seasons.team_abbreviation,
        is_in_playoffs,
        games_played,
        minutes_played,
        field_goals_made,
        field_goals_attempted,
        field_goals_pct,
        three_points_field_goals_made,
        three_points_field_goals_attempted,
        three_points_field_goals_pct,
        two_points_field_goals_made,
        two_points_field_goals_attempted,
        two_points_field_goals_pct,
        free_throws_made,
        free_throws_attempted,
        free_throws_pct,
        offensive_rebounds,
        defensive_rebounds,
        total_rebounds,
        assists,
        steals,
        blocks,
        turnovers,
        persona_fouls,
        points

    from team_totals_seasons
    inner join int_teams
    on team_totals_seasons.team_id = int_teams.team_id
    inner join
    dates
    on team_totals_seasons.season = dates.year_date

    order by season desc, team_totals_seasons.team_name


)

select * from renamed
