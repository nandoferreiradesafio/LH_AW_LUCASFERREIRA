with
    salesterritory as (
        select
            cast(territoryid as int) as territoryid 
            , cast(name as string) as name
            , cast(countryregioncode as string) as countryregioncode
            , cast(_group as string) as _group
            , cast(salesytd as float) as salesytd
            , cast(saleslastyear as float) as saleslastyear
            , cast(costytd as int) as costytd
            , cast(costlastyear as int) as costlastyear
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'salesterritory') }}
    )
select
    *
from salesterritory