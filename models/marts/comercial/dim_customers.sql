with
    stg_erp__salesorderheader as(
        select
            *
        from {{ ref('stg_erp__salesorderheader') }}
    )

    , stg_erp__customer as(
        select
            *
        from {{ ref('stg_erp__customer') }}
    )

    , stg_erp__store as(
        select
            *
        from {{ ref('stg_erp__store') }}
    )

    , stg_erp__person as(
        select
            *
        from {{ ref('stg_erp__person') }}
    ) 
    
    , transformed_data_customers as(
        select
            distinct (stg_erp__salesorderheader.fk_cliente)
            , stg_erp__customer.fk_pessoa
            , stg_erp__customer.fk_loja
            , stg_erp__person.fk_entidade_negocio
            , case
                when stg_erp__person.nome_do_meio is null then (
                    stg_erp__person.nome_primeiro || ' ' || stg_erp__person.nome_ultimo
                )
                else (
                    stg_erp__person.nome_primeiro || ' ' || stg_erp__person.nome_do_meio || ' ' || stg_erp__person.nome_ultimo
                ) 
            end as nome_completo
            , stg_erp__store.nome_loja
            , {{
                dbt_utils.generate_surrogate_key([
                    'stg_erp__salesorderheader.fk_cliente',
                    'stg_erp__customer.fk_pessoa',
                    'stg_erp__customer.fk_loja',
                    'stg_erp__person.fk_entidade_negocio'
                ])
            }} as sk_cliente
        from stg_erp__salesorderheader
        left join stg_erp__customer
            on stg_erp__salesorderheader.fk_cliente = stg_erp__customer.pk_cliente
        left join stg_erp__store
            on stg_erp__customer.fk_loja = stg_erp__store.fk_entidade_negocio
        left join stg_erp__person
            on stg_erp__customer.fk_pessoa = stg_erp__person.fk_entidade_negocio
    )

select
    *
from transformed_data_customers