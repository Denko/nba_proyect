with 

source as (

    select * from {{ ref('base_player_totals_seasons') }}

),

renamed as (

    select
        _LINE::integer AS _line,
        seas_id::integer as old_season_id,
        season::integer as season,
        player_id::integer as old_player_id,
        {{dbt_utils.generate_surrogate_key(['player'])}}::varchar(256) AS player_id, 
        player::varchar(120) as player_name,
        DECODE(birth_year,'NA',null,birth_year)::integer as player_birth_year,
        pos::varchar(10) as player_position,
        DECODE(age,'NA',null,age)::integer as player_age,
        experience::integer as player_experience,
        lg::varchar(10) as league,
        tm::varchar(3) as team_abbreviation,
        g::integer as games_played,
        DECODE(gs,'NA',0,gs)::integer as games_started,
        DECODE(mp,'NA',0,mp)::integer as minutes_played,
        fg::integer as field_goals_made,
        fga::integer as field_goals_attempted,
        DECODE(fg_percent,'NA',null,fg_percent)::number(4,3) as field_goals_pct,
        DECODE(x_3_p,'NA',0,x_3_p)::integer as three_points_field_goals_made,
        DECODE(x_3_pa,'NA',0,x_3_pa)::integer as three_points_field_goals_attempted,
        DECODE(x_3_p_percent,'NA',null,x_3_p_percent)::number(4,3) as three_points_field_goals_pct,
        x_2_p::integer as two_points_field_goals_made,
        x_2_pa::integer as two_points_field_goals_attempted,
        DECODE(x_2_p_percent,'NA',null,x_2_p_percent)::number(4,3) as two_points_field_goals_pct,
        DECODE(e_fg_percent,'NA',null,e_fg_percent)::number(4,3) as eficiency_field_goals_pct,
        ft::integer as free_throws_made,
        fta::integer as free_throws_attempted,
        DECODE(ft_percent,'NA',null,ft_percent)::number(4,3) as free_throws_pct,
        DECODE(orb,'NA',0,orb)::integer as offensive_rebounds,
        DECODE(drb,'NA',0,drb)::integer as defensive_rebounds,
        DECODE(trb,'NA',0,trb)::integer as total_rebounds,
        ast::integer as assists,
        DECODE(stl,'NA',0,stl)::integer as steals,
        DECODE(blk,'NA',0,blk)::integer as blocks,
        DECODE(tov,'NA',0,tov)::integer as turnovers,
        pf::integer as persona_fouls,
        pts::integer as points,
        _fivetran_synced

    from source

)

select * from renamed
