with
    product as (
        select 
            cast(productid as int) as pk_produto
            , cast(productsubcategoryid as int) as fk_subcategoria_produto
            , cast(productmodelid as int) as fk_modelo_produto
            , cast(makeflag as boolean) as indicador_fabricacao
            , cast(finishedgoodsflag as boolean) as indicador_produto_acabado
            , cast(sizeunitmeasurecode as string) as codigo_unidade_tamanho
            , cast(weightunitmeasurecode as string) as codigo_unidade_peso
            , cast(productnumber as string) as numero_produto
            , cast(name as string) as nome_produto
            , cast(color as string) as cor_produto
            , cast(safetystocklevel as int) as nivel_estoque_seguro
            , cast(reorderpoint as int) as ponto_reposicao
            , cast(standardcost as float) as custo_padrao
            , cast(listprice as float) as preco_lista
            , cast(size as varchar) as tamanho_produto
            , cast(weight as float) as peso_produto
            , cast(productline as string) as linha_produto
            , cast(class as varchar) as classe_produto
            , cast(style as varchar) as estilo_produto
            , cast(daystomanufacture as float) as dias_para_fabricar
            , cast(sellstartdate as date) as data_inicio_venda
            , cast(sellenddate as date) as data_fim_venda
            , cast(discontinueddate as string) as data_descontinuacao
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'product') }}
    )
select
    *
from product