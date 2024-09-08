/*
    Este teste garente que as vendas estão
    corretas com o valor auditado da contabilidade.  

    soma total = 306279068.9285
*/

with
    tst_total_vendas as (
        select
            sum(total_pagar) as total_vendas
        from {{ ref('fact_sales') }}
    )
    
select
    total_vendas
from tst_total_vendas
where total_vendas not between 306279068.9275 and 306279068.9295
