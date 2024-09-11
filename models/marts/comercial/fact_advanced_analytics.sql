with
    dim_creditcards as (
        select
            sk_creditcard
            , tipo_cartao
            , fk_cartao_credito
        from {{ ref('dim_creditcards') }}
    )

    , dim_customers as (
        select
            sk_cliente
            , nome_completo
            , fk_cliente
        from {{ ref('dim_customers') }}
    )

    ,  dim_locations as (
        select
            sk_location
            , nome_regiao_pais
            , nome_estado_provincia
            , nome_cidade
            , fk_endereco_faturamento
        from {{ ref('dim_locations') }}
    )

    , dim_products as (
        select
            sk_products
            , nome_produto
            , nome_categoria_produto
            , nome_subcategoria
            , fk_produto
        from {{ ref('dim_products') }}
    )

    , dim_salesreasons as (
        select
            fk_pedido_venda
            , nome_motivo_agregado
        from {{ ref('dim_salesreasons') }}
    )

    , stg_erp__salesorderdetail as (
        select 
            fk_pedido_venda
            , fk_produto
            , quantidade_pedido
            , preco_unitario
            , desconto_preco_unitario
            , quantidade_pedido * (preco_unitario - desconto_preco_unitario) as valor_pago_produto
        from {{ ref('stg_erp__salesorderdetail') }}
    )

    , stg_erp__salesorderheader as (
        select
            pk_pedido_venda
            , fk_cliente
            , fk_vendedor
            , fk_territorio
            , fk_endereco_faturamento
            , fk_cartao_credito
            , status_pedido
            , case
                when indicador_pedido_online = True then  'Online'
                else 'Presencial'
            end as indicador_pedido_online
            , subtotal
            , valor_imposto
            , frete
            , total_pagar
            , data_pedido
            , data_envio
        from {{ ref('stg_erp__salesorderheader') }}
    )

    , join_stg_erp__salesorderdetail as (
        select
            stg_erp__salesorderdetail.fk_pedido_venda
            , stg_erp__salesorderdetail.fk_produto
            , dim_products.nome_produto
            , dim_products.nome_categoria_produto
            , dim_products.nome_subcategoria
            , dim_salesreasons.nome_motivo_agregado
            , stg_erp__salesorderdetail.quantidade_pedido
            , stg_erp__salesorderdetail.preco_unitario
            , stg_erp__salesorderdetail.desconto_preco_unitario
            , stg_erp__salesorderdetail.valor_pago_produto
            , ifnull(dim_salesreasons.nome_motivo_agregado, 'Sem informacao') as motivo_agregado
        from stg_erp__salesorderdetail
        left join dim_products
            on dim_products.fk_produto = stg_erp__salesorderdetail.fk_produto
        left join dim_salesreasons
            on dim_salesreasons.fk_pedido_venda = stg_erp__salesorderdetail.fk_pedido_venda
    )

    , join_stg_erp__salesorderheader as (
        select
            stg_erp__salesorderheader.pk_pedido_venda
            , stg_erp__salesorderheader.fk_cliente
            , stg_erp__salesorderheader.fk_vendedor
            , stg_erp__salesorderheader.fk_territorio
            , stg_erp__salesorderheader.fk_endereco_faturamento
            , stg_erp__salesorderheader.fk_cartao_credito
            , dim_customers.nome_completo
            , dim_creditcards.tipo_cartao
            , dim_locations.nome_regiao_pais
            , dim_locations.nome_estado_provincia
            , dim_locations.nome_cidade
            , stg_erp__salesorderheader.status_pedido
            , stg_erp__salesorderheader.indicador_pedido_online
            , stg_erp__salesorderheader.subtotal
            , stg_erp__salesorderheader.valor_imposto
            , stg_erp__salesorderheader.frete
            , stg_erp__salesorderheader.total_pagar
            , stg_erp__salesorderheader.data_pedido
            , stg_erp__salesorderheader.data_envio
        from stg_erp__salesorderheader
        left join dim_customers
            on dim_customers.fk_cliente = stg_erp__salesorderheader.fk_cliente
        left join dim_creditcards
            on dim_creditcards.fk_cartao_credito = stg_erp__salesorderheader.fk_cartao_credito
        left join dim_locations
            on dim_locations.fk_endereco_faturamento = stg_erp__salesorderheader.fk_endereco_faturamento
    )

    , transformed_advanced_analytics as (
        select
            join_stg_erp__salesorderdetail.fk_pedido_venda
            , join_stg_erp__salesorderdetail.fk_produto
            , join_stg_erp__salesorderheader.fk_cliente
            , join_stg_erp__salesorderheader.fk_vendedor
            , join_stg_erp__salesorderheader.fk_territorio
            , join_stg_erp__salesorderheader.fk_endereco_faturamento
            , join_stg_erp__salesorderheader.fk_cartao_credito
            , join_stg_erp__salesorderdetail.nome_produto
            , join_stg_erp__salesorderdetail.nome_categoria_produto
            , join_stg_erp__salesorderdetail.nome_subcategoria
            , join_stg_erp__salesorderdetail.nome_motivo_agregado
            , join_stg_erp__salesorderheader.nome_completo
            , join_stg_erp__salesorderheader.tipo_cartao
            , join_stg_erp__salesorderheader.nome_regiao_pais
            , join_stg_erp__salesorderheader.nome_estado_provincia
            , join_stg_erp__salesorderheader.nome_cidade
            , join_stg_erp__salesorderdetail.quantidade_pedido
            , join_stg_erp__salesorderdetail.preco_unitario
            , join_stg_erp__salesorderdetail.desconto_preco_unitario
            , join_stg_erp__salesorderdetail.valor_pago_produto
            , join_stg_erp__salesorderdetail.motivo_agregado
            , join_stg_erp__salesorderheader.status_pedido
            , join_stg_erp__salesorderheader.indicador_pedido_online
            , join_stg_erp__salesorderheader.subtotal
            , join_stg_erp__salesorderheader.valor_imposto
            , join_stg_erp__salesorderheader.frete
            , join_stg_erp__salesorderheader.total_pagar
            , join_stg_erp__salesorderheader.data_pedido
            , join_stg_erp__salesorderheader.data_envio
            , {{ dbt_utils.generate_surrogate_key([
                    'join_stg_erp__salesorderdetail.fk_pedido_venda'
                    , 'join_stg_erp__salesorderdetail.fk_produto'
                    , 'join_stg_erp__salesorderheader.fk_cliente'
                    , 'join_stg_erp__salesorderheader.fk_endereco_faturamento'
                    , 'join_stg_erp__salesorderheader.fk_cartao_credito'
                    , 'join_stg_erp__salesorderheader.data_pedido'
                ]) 
            }} as sk_factsales
        from join_stg_erp__salesorderdetail
        left join join_stg_erp__salesorderheader
            on join_stg_erp__salesorderheader.pk_pedido_venda = join_stg_erp__salesorderdetail.fk_pedido_venda
    )

select 
    *
from transformed_advanced_analytics