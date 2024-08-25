with
    productsubcategory as (
        select
            cast(productsubcategoryid as int) as productsubcategoryid
            , cast(productcategoryid as int) as productcategoryid
            , cast(name as string) as name
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'productsubcategory') }}
    )
select
    *
from productsubcategory