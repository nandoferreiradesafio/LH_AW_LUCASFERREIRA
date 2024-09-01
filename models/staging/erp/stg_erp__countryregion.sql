with
    countryregion as (
        select
            cast(countryregioncode as string) as codigo_regiao_pais
            , case
                when name is null then 'Nome Não Informado'
                when name = 'France' then 'França'
                when name = 'Canada' then 'Canadá'
                when name = 'United States' then 'Estados Unidos'
                when name = 'Germany' then 'Alemanha'
                when name = 'United Kingdom' then 'Reino Unido'
                when name = 'Australia' then 'Austrália'
                else 'Outro País'
            end nome_regiao_pais
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'countryregion') }}
    )
select
    *
from countryregion