with 

source as (

    select * from {{ source('google_drive', 'team_totals_seasons') }}

),

renamed as (

    select
        _LINE::integer AS _line,
        season::integer as season,
        lg::varchar(10) as league,
        {{dbt_utils.generate_surrogate_key(['team'])}}::varchar(256) as team_id,
        team::varchar(40) as team_name,
        abbreviation::varchar(3) as team_abbreviation,
        playoffs::boolean as is_in_playoffs,
        DECODE(g,'NA',0,g)::integer as games_played,
        DECODE(mp,'NA',0,mp)::integer as minutes_played,
        DECODE(fg,'NA',0,fg)::integer as field_goals_made,
        DECODE(fga,'NA',0,fga)::integer as field_goals_attempted,
        DECODE(fg_percent,'NA',null,fg_percent)::number(4,3) as field_goals_pct,
        DECODE(x_3_p,'NA',0,x_3_p)::integer as three_points_field_goals_made,
        DECODE(x_3_pa,'NA',0,x_3_pa)::integer as three_points_field_goals_attempted,
        DECODE(x_3_p_percent,'NA',null,x_3_p_percent)::number(4,3) as three_points_field_goals_pct,
        DECODE(x_2_p,'NA',0,x_2_p)::integer as two_points_field_goals_made,
        DECODE(x_2_pa,'NA',0,x_2_pa)::integer as two_points_field_goals_attempted,
        DECODE(x_2_p_percent,'NA',null,x_2_p_percent)::number(4,3) as two_points_field_goals_pct,
        DECODE(ft,'NA',0,ft)::integer as free_throws_made,
        DECODE(fta,'NA',0,fta)::integer as free_throws_attempted,
        DECODE(ft_percent,'NA',null,ft_percent)::number(4,3) as free_throws_pct,
        DECODE(orb,'NA',0,orb)::integer as offensive_rebounds,
        DECODE(drb,'NA',0,drb)::integer as defensive_rebounds,
        DECODE(trb,'NA',0,trb)::integer as total_rebounds,
        DECODE(ast,'NA',0,ast)::integer as assists,
        DECODE(stl,'NA',0,stl)::integer as steals,
        DECODE(blk,'NA',0,blk)::integer as blocks,
        DECODE(tov,'NA',0,tov)::integer as turnovers,
        DECODE(pf,'NA',0,pf)::integer as persona_fouls,
        DECODE(pts,'NA',0,pts)::integer as points,
        _fivetran_synced AS loaded_at

    from source

)

select * from renamed
