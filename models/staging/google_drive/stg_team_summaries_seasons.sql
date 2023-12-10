with 

source as (

    select * from {{ source('google_drive', 'team_summaries_seasons') }}

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
        DECODE(age,'NA',null,age)::number(3,1) as average_team_age,
        DECODE(w,'NA',null,w)::integer as wins,
        DECODE(l,'NA',null,l)::integer as loses,
        SUBSTR(team, 0, len(team)-len(SPLIT(team,' ')[array_size(SPLIT(team,' '))-1]))::varchar(100) as city, -- Saca el substring de la ciudad empezando de la pos 0 con longitud de team_name menos la última parte (el nombre del equipo)
        {{dbt_utils.generate_surrogate_key(['arena'])}}::varchar(256) as arena_id,
        arena::varchar(120) as arena_name,
        DECODE(attend,'NA',null,attend)::integer as total_attend,
        DECODE(attend_g,'NA',null,attend_g)::integer as average_attend,
        _fivetran_synced AS loaded_at

    from source

)

select * from renamed
