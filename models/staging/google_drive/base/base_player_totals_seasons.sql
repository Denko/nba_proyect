with 

source as (

    select * from {{ source('google_drive', 'player_totals_seasons') }}

),

renamed as (

    select
        _line,
        seas_id,
        season,
        player_id,
        player,
        birth_year,
        pos,
        age,
        experience,
        lg,
        tm,
        g,
        gs,
        mp,
        fg,
        fga,
        replace(fg_percent,',','.') as fg_percent,
        x_3_p,
        x_3_pa,
        replace(x_3_p_percent,',','.') as x_3_p_percent,
        x_2_p,
        x_2_pa,
        replace(x_2_p_percent,',','.') as x_2_p_percent,
        replace(e_fg_percent,',','.') as e_fg_percent,
        ft,
        fta,
        replace(ft_percent,',','.') as ft_percent,
        orb,
        drb,
        trb,
        ast,
        stl,
        blk,
        tov,
        pf,
        pts,
        _fivetran_synced

    from source

)

select * from renamed
