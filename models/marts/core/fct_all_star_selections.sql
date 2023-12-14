with 

all_star_selections as (

    select * from {{ ref('stg_all_star_selections') }}

),
stg_players as (

    select * from {{ ref('stg_players') }}

),
player_totals_seasons as (

    select distinct 
        player_id,
        player_name 
    from {{ ref('stg_player_totals_seasons') }}

),
dates AS (
    SELECT distinct year_date
    FROM {{ ref('stg_dates') }}
),

renamed as (

    select distinct

        all_star_selections.player_id,
        all_star_selections.player_name,
        all_star_selections.team_name,
        all_star_selections.league_name,
        all_star_selections.season,
        all_star_selections.is_replaced

    from all_star_selections
    left join
    player_totals_seasons
    on all_star_selections.player_id = player_totals_seasons.player_id
    inner join 
    dates on all_star_selections.season = dates.year_date

    order by all_star_selections.season asc, all_star_selections.team_name

)

select * from renamed