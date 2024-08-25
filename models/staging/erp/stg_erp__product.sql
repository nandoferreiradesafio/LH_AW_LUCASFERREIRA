with
    product as (
        select 
            cast(productid as int) as productid
            , cast(name as string) as name
            , cast(productnumber as string) as productnumber
            , cast(makeflag as boolean) as makeflag
            , cast(finishedgoodsflag as boolean) as finishedgoodsflag
            , cast(color as string) as color
            , cast(safetystocklevel as int) as safetystocklevel
            , cast(reorderpoint as int) as reorderpoint
            , cast(standardcost as float) as standardcost
            , cast(listprice as float) as listprice
            , cast(size as varchar) as size
            , cast(sizeunitmeasurecode as string) as sizeunitmeasurecode
            , cast(weightunitmeasurecode as string) as weightunitmeasurecode
            , cast(weight as float) as weight
            , cast(daystomanufacture as float) as daystomanufacture
            , cast(productline as string) as productline
            , cast(class as varchar) as class
            , cast(style as varchar) as style
            , cast(productsubcategoryid as int) as productsubcategoryid
            , cast(productmodelid as int) as productmodelid
            , cast(sellstartdate as date) as sellstartdate
            , cast(sellenddate as date) as sellenddate
            , cast(discontinueddate as string) as discontinueddate
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'product') }}
    )
select
    *
from product