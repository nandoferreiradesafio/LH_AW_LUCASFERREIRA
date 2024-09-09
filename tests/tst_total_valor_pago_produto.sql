/*
    Este teste garente que o valor total pago pelos produtos estão
    corretas com o valor auditado da contabilidade.  

    soma total = 110361630
*/

with
    tst_total_valor_pago_produto as (
        select
            sum(valor_pago_produto) as total_valor_pago
        from {{ ref('fact_sales') }}
    )
    
select
    total_valor_pago
from tst_total_valor_pago_produto
where total_valor_pago not between 110361620 and 110361640
