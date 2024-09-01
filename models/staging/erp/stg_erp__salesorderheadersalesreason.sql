with
    salesorderheadersalesreason as (
        select
            cast(salesorderid as int) as fk_pedido_venda 
            , cast(salesreasonid as int) as fk_motivo_venda
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'salesorderheadersalesreason') }}
    )
select
    *
from salesorderheadersalesreason