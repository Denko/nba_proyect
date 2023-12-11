WITH players AS (
    SELECT *
    FROM {{ ref('stg_players') }}
),
teams AS (
    SELECT *
    FROM {{ ref('stg_teams') }}
),
dates AS (
    SELECT *
    FROM {{ ref('stg_dates') }}
),



renamed_casted AS (
    SELECT distinct

        player_id, 
        team_id, 
        season
        
    FROM players
    inner join 
    dates on players.season = dates.year_date
    

    order by season asc, team_id

)

SELECT * FROM renamed_casted