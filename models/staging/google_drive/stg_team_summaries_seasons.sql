with 

source as (

    select * from {{ source('google_drive', 'team_summaries_seasons') }}

),

renamed as (

    select
        _LINE::integer AS _line,
        season::integer as season,
        lg::varchar(10) as league,
        team::varchar(40) as team_name,
        abbreviation::varchar(3) as team_abbreviation,
        playoffs::boolean as is_in_playoffs,
        DECODE(age,'NA',null,age)::number(3,1) as average_team_age,
        DECODE(w,'NA',null,w)::integer as wins,
        DECODE(l,'NA',null,l)::integer as loses,
        arena::varchar(120) as arena_name,
        DECODE(attend,'NA',null,attend)::integer as total_attend,
        DECODE(attend_g,'NA',null,attend_g)::integer as average_attend,
        _fivetran_synced AS loaded_at

    from source

)

select * from renamed
