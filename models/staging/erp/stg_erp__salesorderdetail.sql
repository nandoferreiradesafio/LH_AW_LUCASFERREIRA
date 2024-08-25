with
    salesorderdetail as (
        select
            cast(salesorderid as int) as salesorderid 
            , cast(salesorderdetailid as int) as salesorderdetailid
            , cast(carriertrackingnumber as string) as carriertrackingnumber
            , cast(orderqty as int) as orderqty
            , cast(productid as int) as productid
            , cast(specialofferid as int) as specialofferid
            , cast(unitprice as int) as unitprice
            , cast(unitpricediscount as int) as unitpricediscount
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'salesorderdetail') }}
    )
select
    *
from salesorderdetail