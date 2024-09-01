with
    address as (
        select
            cast(addressid as int) as pk_endereco
            , cast(stateprovinceid as int) as fk_estado_provincia
            , cast(addressline1 as string) as endereco_primeiro
            , cast(addressline2 as string) as endereco_segundo
            , cast(city as string) as nome_cidade
            , cast(postalcode as string) as codigo_postal
            , cast(spatiallocation as string) as coordenada_geografica
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'address') }}
    )
select
    *
from address