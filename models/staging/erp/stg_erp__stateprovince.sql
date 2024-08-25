with
    stateprovince as (
        select
            cast(stateprovinceid as int) as stateprovinceid 
            , cast(stateprovincecode as string) as stateprovincecode
            , cast(countryregioncode as string) as countryregioncode
            , cast(isonlystateprovinceflag as boolean) as isonlystateprovinceflag
            , cast(name as string) as name
            , cast(territoryid as int) as territoryid
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'stateprovince') }}
    )
select
    *
from stateprovince