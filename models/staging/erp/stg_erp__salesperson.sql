with
    salesperson as (
        select
            cast(businessentityid as int) as businessentityid 
            , cast(territoryid as int) as territoryid
            , cast(salesquota as int) as salesquota
            , cast(bonus as int) as bonus 
            , cast(commissionpct as float) as commissionpct
            , cast(salesytd as float) as salesytd
            , cast(saleslastyear as float) as saleslastyear 
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'salesperson') }}
    )
select
    *
from salesperson