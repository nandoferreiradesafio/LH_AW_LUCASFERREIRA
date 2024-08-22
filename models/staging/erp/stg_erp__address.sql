with
    address as (
        select
            cast(addressid as int) as addressid
            , cast(addressline1 as string) as addressline1
            , cast(addressline2 as string) as addressline2
            , cast(city as string) as city
            , cast(stateprovinceid as int) as stateprovinceid
            , cast(postalcode as string) as postalcode
            , cast(spatiallocation as string) as spatiallocation
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'address') }}
    )
select
    *
from address