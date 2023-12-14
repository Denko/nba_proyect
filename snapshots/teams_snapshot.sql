{% snapshot teams_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='TEAM_ID',
      strategy='check',
      check_cols=['OWNER','GENERALMANAGER','HEADCOACH','DLEAGUEAFFILIATION','ARENA','ARENACAPACITY'],
      invalid_hard_delete=True 
    )
}}
-- Invalid hard delete hace un borrado lógico pero no se borran. se usa para mantener los datos en el histórico aunque no lleguen al snapshot 
select * from {{ source('google_drive','teams') }}



{% endsnapshot %}