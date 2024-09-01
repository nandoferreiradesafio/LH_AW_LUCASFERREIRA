with
    store as (
        select
            cast(businessentityid as int) as fk_entidade_negocio 
            , cast(name as string) as nome_loja
            , cast(salespersonid as int) as fk_vendedor
            , cast(demographics as string) as dados_demograficos
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'store') }}
    )
select
    *
from store