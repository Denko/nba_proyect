WITH teams1 AS (
    SELECT *
    FROM {{ ref('stg_teams') }}
),
teams2 AS (
    SELECT distinct
        arena_id,
        team_id,
        arena_name,
        total_attend,
        average_attend,
        city,
        season
    FROM {{ ref('stg_team_summaries_seasons') }}

),
dates AS (
    SELECT distinct year_date
    FROM {{ ref('stg_dates') }}
),

renamed_casted AS (
    SELECT distinct

        teams2.arena_id,
        teams2.team_id,
        teams2.arena_name,
        DECODE(teams1.arena_capacity,0,null,teams1.arena_capacity)::integer as arena_capacity,
        teams2.total_attend,
        teams2.average_attend,
        teams2.city,
        teams2.season
    FROM teams1
    right join
    teams2
    on teams1.arena_id = teams2.arena_id
    inner join 
    dates on teams2.season = dates.year_date
    order by teams2.season desc
)

SELECT * FROM renamed_casted