with
    customer as (
        select
            cast(customerid as int) as pk_cliente
            , cast(personid as int) as fk_pessoa
            , cast(storeid as int) as fk_loja
            , cast(territoryid as int) as fk_territorio
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'customer') }}
    )
select
    *
from customer