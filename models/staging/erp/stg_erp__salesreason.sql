with
    salesreason as (
        select
            cast(salesreasonid as int) as salesreasonid 
            , cast(name as string) as name
            , cast(reasontype as string) as reasontype
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'salesreason') }}
    )
select
    *
from salesreason