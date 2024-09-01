with
    productcategory as (
        select 
            cast(productcategoryid as int) as pk_categoria_produto
            , case
                when name = 'Bikes' then 'Bicicletas'
                when name = 'Components' then 'Componentes'
                when name = 'Clothing' then 'Roupas'
                when name = 'Accessories' then 'Acessórios'
            end as nome_categoria_produto
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'productcategory') }}
    )
select
    *
from productcategory