with
    pais as (
        select 
            codigo_regiao_pais
            , nome_regiao_pais as pais
        from {{ ref('stg_erp__countryregion') }}
    )

    , estado as (
        select
            pk_estado_provincia
            , codigo_regiao_pais
            , nome_estado_provincia as estado
        from {{ ref('stg_erp__stateprovince') }}
    )

    , cidade as (
        select
            pk_endereco
            , fk_estado_provincia
            , nome_cidade as cidade
        from {{ ref('stg_erp__address') }}
    )

    , info_pedidos as (
        select
            fk_endereco_faturamento
            , pk_pedido_venda
            , fk_endereco_envio
            , fk_cliente
            , data_pedido
        from {{ ref('stg_erp__salesorderheader') }}
    )

    , join_enderecos as (
        select
            info_pedidos.fk_endereco_faturamento
            , pais.pais
            , estado.estado
            , cidade.cidade
        from info_pedidos
        left join cidade
            on info_pedidos.fk_endereco_envio = cidade.pk_endereco
        left join estado
            on estado.pk_estado_provincia = cidade.fk_estado_provincia
        left join pais
            on pais.codigo_regiao_pais = estado.codigo_regiao_pais
    )

    , cliente as (
        select
            pk_cliente
            , fk_pessoa
            , fk_loja
        from {{ ref('stg_erp__customer') }}
    )

    , loja as (
        select
            fk_entidade_negocio
            , case
                when nome_loja is null or trim(nome_loja) = '' then 'Nao Informado'
                else nome_loja
            end as nome_loja
        from {{ ref('stg_erp__store') }}
    )

    , pessoa as (
        select
            fk_entidade_negocio
            , case
                when nome_do_meio is null then (
                    nome_primeiro || ' ' || nome_ultimo
                )
                else (
                    nome_primeiro || ' ' || nome_do_meio || ' ' || nome_ultimo
                ) 
            end as nome_completo
        from {{ ref('stg_erp__person') }}
    )

    , join_cliente as (
        select
            cliente.pk_cliente
            , cliente.fk_pessoa
            , cliente.fk_loja
            , loja.fk_entidade_negocio
            , info_pedidos.fk_endereco_faturamento
            , info_pedidos.pk_pedido_venda
            , coalesce(loja.nome_loja, 'Nao Informado') as nome_loja
            , pessoa.nome_completo
            , info_pedidos.data_pedido
        from info_pedidos
        left join cliente
            on cliente.pk_cliente = info_pedidos.fk_cliente
        left join loja
            on loja.fk_entidade_negocio = cliente.fk_loja
        left join pessoa
            on pessoa.fk_entidade_negocio = cliente.fk_pessoa
    )

    , produto as (
        select
            pk_produto
            , fk_subcategoria_produto
            , numero_produto
            , nome_produto as produto
        from {{ ref('stg_erp__product') }}
    )

    , categoria_produto as (
        select
            pk_categoria_produto
            , nome_categoria_produto as categoria_produto
        from {{ ref('stg_erp__productcategory') }}
    )

    , subcategoria_produto as (
        select
            pk_subcategoria_produto
            , fk_categoria_produto
            , nome_subcategoria as subcategoria_produto
        from {{ ref('stg_erp__productsubcategory') }}
    )

    , join_produtos as (
        select
            produto.pk_produto
            , categoria_produto.pk_categoria_produto
            , subcategoria_produto.pk_subcategoria_produto
            , produto.numero_produto
            , produto.produto
            , categoria_produto.categoria_produto
            , subcategoria_produto.subcategoria_produto
        from produto
        left join subcategoria_produto
            on subcategoria_produto.pk_subcategoria_produto = produto.fk_subcategoria_produto
        left join categoria_produto
            on categoria_produto.pk_categoria_produto = subcategoria_produto.fk_categoria_produto
    )

    , detalhes_pedidos as (
        select
            fk_produto
            , pk_detalhe_pedido_venda
            , fk_pedido_venda
            , quantidade_pedido
            , preco_unitario
        from {{ ref('stg_erp__salesorderdetail') }}
    )

	, transformed_data_aggregated as (
        select
            pais
            , estado
            , cidade
            , nome_completo
            , nome_loja
            , produto
            , categoria_produto
            , subcategoria_produto
            , numero_produto
            , quantidade_pedido
            , preco_unitario
            , data_pedido
        from join_cliente
        left join join_enderecos
            on join_enderecos.fk_endereco_faturamento = join_cliente.fk_endereco_faturamento
        left join detalhes_pedidos
            on detalhes_pedidos.fk_pedido_venda = join_cliente.pk_pedido_venda
        left join join_produtos
            on join_produtos.pk_produto = detalhes_pedidos.fk_produto
    )

select
    *
from transformed_data_aggregated