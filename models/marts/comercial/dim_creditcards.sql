with
    stg_erp__salesorderheader as (
        select
            *
        from {{ ref('stg_erp__salesorderheader') }}
    )

    , stg_erp__creditcard as (
        select
            *
        from {{ ref('stg_erp__creditcard') }}
    )

    , transformed_data_creditcard as (
        select
            distinct (stg_erp__salesorderheader.fk_cartao_credito)
            , stg_erp__creditcard.tipo_cartao
            , stg_erp__creditcard.numero_cartao
            , stg_erp__creditcard.mes_expiracao
            , stg_erp__creditcard.ano_expiracao
            , {{ 
                dbt_utils.generate_surrogate_key([
                    'stg_erp__salesorderheader.fk_cartao_credito'
                    , 'stg_erp__creditcard.numero_cartao'
                ]) 
            }} as sk_creditcard
        from stg_erp__salesorderheader
        left join stg_erp__creditcard
            on stg_erp__salesorderheader.fk_cartao_credito = stg_erp__creditcard.pk_cartao_credito
        where fk_cartao_credito is not null
    )

select
    *
from transformed_data_creditcard