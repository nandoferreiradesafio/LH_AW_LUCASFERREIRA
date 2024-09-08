with
    stg_erp__salesreason as (
        select
            *
        from {{ ref('stg_erp__salesreason') }}
    )

    , stg_erp__salesorderheadersalesreason as (
        select
            *
        from {{ ref('stg_erp__salesorderheadersalesreason') }}
    )

    , transformed_data as (
        select
            stg_erp__salesorderheadersalesreason.fk_pedido_venda
            , stg_erp__salesreason.nome_motivo
        from stg_erp__salesorderheadersalesreason
        left join stg_erp__salesreason
            on stg_erp__salesreason.pk_motivo_venda = stg_erp__salesorderheadersalesreason.fk_motivo_venda
    )

    , transformed_data_salesreasons as (
        select
            fk_pedido_venda
            , coalesce(listagg(nome_motivo, ', '), 'Sem Motivo') as nome_motivo_agregado
            , {{
                dbt_utils.generate_surrogate_key([
                    'fk_pedido_venda',
                    'nome_motivo_agregado'
                ])
            }} as sk_salesreasons
        from transformed_data
        group by fk_pedido_venda
    )

select
    *
from transformed_data_salesreasons
