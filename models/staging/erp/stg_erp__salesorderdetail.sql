with
    salesorderdetail as (
        select
            cast(salesorderdetailid as int) as pk_detalhe_pedido_venda
            , cast(salesorderid as int) as fk_pedido_venda 
            , cast(productid as int) as fk_produto
            , cast(specialofferid as int) as fk_oferta_especial
            , cast(carriertrackingnumber as string) as numero_rastreio_transportadora
            , cast(orderqty as int) as quantidade_pedido
            , cast(unitprice as int) as preco_unitario
            , cast(unitpricediscount as int) as desconto_preco_unitario
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'salesorderdetail') }}
    )
select
    *
from salesorderdetail