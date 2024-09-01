with
    salesperson as (
        select
            cast(businessentityid as int) as fk_entidade_negocio 
            , cast(territoryid as int) as fk_territorio
            , cast(salesquota as int) as cota_vendas
            , cast(bonus as int) as bonus 
            , cast(commissionpct as float) as percentual_comissao
            , cast(salesytd as float) as vendas_ano_atual
            , cast(saleslastyear as float) as vendas_ano_anterior 
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'salesperson') }}
    )
select
    *
from salesperson