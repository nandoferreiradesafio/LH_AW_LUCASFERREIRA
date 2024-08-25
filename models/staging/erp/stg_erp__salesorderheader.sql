with
    salesorderheader as (
        select
            cast(salesorderid as int) as salesorderid
            , cast(revisionnumber as int) as revisionnumber
            , cast(orderdate as date) as orderdate
            , cast(duedate as date) as duedate
            , cast(shipdate as date) as shipdate
            , cast(onlineorderflag as boolean) as onlineorderflag
            , cast(purchaseordernumber as string) as purchaseordernumber
            , cast(accountnumber as string) as accountnumber
            , cast(customerid as int) as customerid
            , cast(salespersonid as int) as salespersonid
            , cast(territoryid as int) as territoryid
            , cast(billtoaddressid as int) as billtoaddressid
            , cast(shiptoaddressid as int) as shiptoaddressid
            , cast(shipmethodid as int) as shipmethodid
            , cast(creditcardid as int) as creditcardid
            , cast(creditcardapprovalcode as string) as creditcardapprovalcode
            , cast(currencyrateid as int) as currencyrateid
            , cast(subtotal as float) as subtotal
            , cast(taxamt as float) as taxamt
            , cast(freight as float) as freight
            , cast(totaldue as float) as totaldue
            , cast(comment as string) as comment
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'salesorderheader') }}
    )
select
    *
from salesorderheader