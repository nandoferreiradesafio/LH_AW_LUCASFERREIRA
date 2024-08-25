with
    salesorderheadersalesreason as (
        select
            cast(salesorderid as int) as salesorderid 
            , cast(salesreasonid as int) as salesreasonid
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'salesorderheadersalesreason') }}
    )
select
    *
from salesorderheadersalesreason