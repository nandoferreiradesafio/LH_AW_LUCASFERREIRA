with
    countryregion as (
        select
            cast(countryregioncode as string) as countryregioncode
            , cast(name as string) as name
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'countryregion') }}
    )
select
    *
from countryregion