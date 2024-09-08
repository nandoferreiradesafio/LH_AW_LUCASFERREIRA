with
    stg_erp__salesorderheader as (
        select
            pk_pedido_venda
            , fk_vendedor
            , fk_territorio
            , total_pagar
        from {{ ref('stg_erp__salesorderheader') }}
    )

    , stg_erp__salesorderdetail as (
        select
            fk_pedido_venda
            , quantidade_pedido * (preco_unitario - desconto_preco_unitario) as valor_pago_produto
        from {{ ref('stg_erp__salesorderdetail') }}
    )

    , stg_erp__person as (
        select
            fk_entidade_negocio
            , case
                when nome_do_meio is null then (nome_primeiro || ' ' || nome_ultimo)
                else (nome_primeiro || ' ' || nome_do_meio || ' ' || nome_ultimo) 
            end as nome_completo
        from {{ ref('stg_erp__person') }}
    )

    , stg_erp__employee as (
        select
            fk_entidade_negocio
            , titulo_trabalho
            , case
                when indicador_ativo = True then 'Ativo'
                else 'Inativo'
            end as indicador_ativo
        from {{ ref('stg_erp__employee') }}
    )

    , stg_erp__salesterritory as (
        select
            pk_territorio_venda
            , codigo_regiao_pais
        from {{ ref('stg_erp__salesterritory') }}
    )

    , stg_erp__countryregion as (
        select
            codigo_regiao_pais
            , nome_regiao_pais
        from {{ ref('stg_erp__countryregion') }}
    )

    , transformed_data as (
        select 
            stg_erp__salesorderheader.pk_pedido_venda
            , stg_erp__salesorderheader.total_pagar
            , stg_erp__salesorderdetail.valor_pago_produto
            , stg_erp__person.nome_completo
            , stg_erp__employee.titulo_trabalho
            , stg_erp__employee.indicador_ativo
            , stg_erp__countryregion.nome_regiao_pais
        from stg_erp__salesorderheader
        left join stg_erp__salesorderdetail
            on  stg_erp__salesorderdetail.fk_pedido_venda = stg_erp__salesorderheader.pk_pedido_venda
        left join stg_erp__person
            on stg_erp__person.fk_entidade_negocio = stg_erp__salesorderheader.fk_vendedor
        left join stg_erp__employee
            on stg_erp__employee.fk_entidade_negocio = stg_erp__person.fk_entidade_negocio
        left join stg_erp__salesterritory
            on stg_erp__salesterritory.pk_territorio_venda = stg_erp__salesorderheader.fk_territorio
        left join stg_erp__countryregion
            on stg_erp__countryregion.codigo_regiao_pais = stg_erp__salesterritory.codigo_regiao_pais
    )

    , transformed_data_aggregated as (
        select
            nome_regiao_pais
            , nome_completo
            , titulo_trabalho
            , indicador_ativo
            , count(pk_pedido_venda) as total_vendas
            , round(sum(total_pagar), 2) as total_receita_bruta
            , sum(valor_pago_produto) as total_receita
        from transformed_data
        group by
            nome_regiao_pais
            , nome_completo
            , titulo_trabalho
            , indicador_ativo
        order by
            total_vendas desc
    )

select
    *
from transformed_data_aggregated