with
    customer as (
        select
            cast(customerid as int) as customerid
            , cast(personid as int) as personid
            , cast(storeid as int) as storeid
            , cast(territoryid as int) as territoryid
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'customer') }}
    )
select
    *
from customer