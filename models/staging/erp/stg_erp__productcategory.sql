with
    productcategory as (
        select 
            cast(productcategoryid as int) as productcategoryid
            , cast(name as string) as name
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'productcategory') }}
    )
select
    *
from productcategory