with 

source as (

    select * from {{ source('google_drive', 'player_award_shares') }}

),

renamed as (

    select
        _LINE,
        season,
        award,
        player,
        age,
        tm,
        "FIRST" AS first_points,
        pts_won,
        pts_max,
        share,
        winner,
        seas_id,
        player_id,
        _fivetran_synced

    from source

)

select * from renamed
