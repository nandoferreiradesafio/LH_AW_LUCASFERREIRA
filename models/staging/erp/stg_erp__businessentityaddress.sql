with
    businessentityaddress as (
        select
            cast(businessentityid as int) as businessentityid
            , cast(addressid as int) as addressid
            , cast(addresstypeid as int) as addresstypeid
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'businessentityaddress') }}
    )
select
    *
from businessentityaddress