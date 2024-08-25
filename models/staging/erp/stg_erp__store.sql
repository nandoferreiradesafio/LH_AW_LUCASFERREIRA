with
    store as (
        select
            cast(businessentityid as int) as businessentityid 
            , cast(name as string) as name
            , cast(salespersonid as int) as salespersonid
            , cast(demographics as string) as demographics
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'store') }}
    )
select
    *
from store