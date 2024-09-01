with
    stateprovince as (
        select
            cast(stateprovinceid as int) as pk_estado_provincia 
            , cast(territoryid as int) as fk_territorio
            , cast(stateprovincecode as string) as codigo_estado_provincia
            , cast(countryregioncode as string) as codigo_regiao_pais
            , cast(isonlystateprovinceflag as boolean) as indicador_estado_provincia_unico
            , cast(name as string) as nome_estado_provincia
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'stateprovince') }}
    )
select
    *
from stateprovince