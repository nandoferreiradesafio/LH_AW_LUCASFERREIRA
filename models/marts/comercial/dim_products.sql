with
    stg_erp__salesorderheader as (
        select
            *
        from {{ ref('stg_erp__salesorderheader') }}
    )

    , stg_erp__salesorderdetail as (
        select
            *
        from {{ ref('stg_erp__salesorderdetail') }}
    )

    , stg_erp__product as (
        select
            *
        from {{ ref('stg_erp__product') }}
    )

    , stg_erp__productcategory as (
        select
            *
        from {{ ref('stg_erp__productcategory') }}
    )

    , stg_erp__productsubcategory as (
        select
            *
        from {{ ref('stg_erp__productsubcategory') }}
    )

    , transformed_data_products as (
        select 
            distinct(stg_erp__salesorderdetail.fk_produto)
            , stg_erp__product.fk_subcategoria_produto
            , stg_erp__product.nome_produto
            , stg_erp__productcategory.nome_categoria_produto
            , stg_erp__productsubcategory.nome_subcategoria
            , {{ 
                dbt_utils.generate_surrogate_key([
                    'stg_erp__salesorderdetail.fk_produto',
                    'stg_erp__product.nome_produto'
                ]) 
            }} as sk_products
        from stg_erp__salesorderdetail
        left join stg_erp__product
            on stg_erp__salesorderdetail.fk_produto = stg_erp__product.pk_produto
        left join stg_erp__productsubcategory
            on stg_erp__productsubcategory.pk_subcategoria_produto = stg_erp__product.fk_subcategoria_produto
        left join stg_erp__productcategory
            on stg_erp__productcategory.pk_categoria_produto = stg_erp__productsubcategory.fk_categoria_produto
    )

select
    *
from transformed_data_products
