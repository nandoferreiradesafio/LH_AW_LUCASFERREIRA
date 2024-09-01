with
    creditcard as (
        select
            cast(creditcardid as int) as pk_cartao_credito
            , cast(cardtype as string) as tipo_cartao
            , cast(cardnumber as int) as numero_cartao
            , cast(expmonth as int) as mes_expiracao
            , cast(expyear as int) as ano_expiracao
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'creditcard') }}
    )
select
    *
from creditcard