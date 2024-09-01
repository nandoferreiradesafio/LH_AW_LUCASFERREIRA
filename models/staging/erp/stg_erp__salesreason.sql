with
    salesreason as (
        select
            cast(salesreasonid as int) as pk_motivo_venda 
            , cast(name as string) as nome_motivo
            , cast(reasontype as string) as tipo_motivo
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'salesreason') }}
    )
select
    *
from salesreason