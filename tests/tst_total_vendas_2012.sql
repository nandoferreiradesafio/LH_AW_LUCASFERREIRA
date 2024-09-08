/*
    Este teste garente que as vendas de 2012 estão
    corretas com o valor auditado da contabilidade.  

    soma total 2012 = 1135495333.9728
*/

with
    tst_total_vendas_2012 as (
        select
            sum(total_pagar) as total_vendas
        from {{ ref('fact_sales') }}
        where data_pedido between '2012-01-01' and '2012-12-31'
    )
    
select
    total_vendas
from tst_total_vendas_2012
where total_vendas not between 135495333.9718 and 135495333.9738
