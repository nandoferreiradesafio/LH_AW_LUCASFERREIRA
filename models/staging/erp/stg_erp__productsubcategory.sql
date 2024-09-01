with
    productsubcategory as (
        select
            cast(productsubcategoryid as int) as pk_subcategoria_produto
            , cast(productcategoryid as int) as fk_categoria_produto
            , case
                when name = 'Mountain Bikes' then 'Bicicletas de montanha'
                when name = 'Road Bikes' then 'Bicicletas de estrada'
                when name = 'Touring Bikes' then 'Bicicletas de turismo'
                when name = 'Handlebars' then 'Guidão'
                when name = 'Bottom Brackets' then 'Colchetes Inferiores'
                when name = 'Chains' then 'Correntes'
                when name = 'Cranksets' then 'Pedaleiras'
                when name = 'Derailleurs' then 'Desviadores'
                when name = 'Forks' then 'Garfos'
                when name = 'Mountain Frames' then 'Quadros de montanha'
                when name = 'Pedals' then 'Pedais'
                when name = 'Road Frames' then 'Quadros de estrada'
                when name = 'Saddles' then 'Selas'
                when name = 'Wheels' then 'Rodas'
                when name = 'Caps' then 'Cápsulas'
                when name = 'Gloves' then 'Luvas'
                when name = 'Socks' then 'Meias'
                when name = 'Bike Racks' then 'Bicicletários'
                when name = 'Bike Stands' then 'Suportes para bicicletas'
                when name = 'Helmets' then 'Capacetes'
                when name = 'Lights' then 'Luzes'
                when name = 'Panniers' then 'Cestos'
                when name = 'Tires and Tubes' then 'Pneus e Câmaras de Ar'
                when name = 'Brakes' then 'Freios'
                when name = 'Touring Frames' then 'Quadros de turismo'
                when name = 'Jerseys' then 'Camisas'
                when name = 'Cleaners' then 'Limpadores'
                when name = 'Hydration Packs' then 'Pacotes de hidratação'
                when name = 'Tights' then 'Meia-calça'
                when name = 'Vests' then 'Coletes'
                when name = 'Bottles and Cages' then 'Garrafas e gaiolas'
                when name = 'Fenders' then 'Pára-lamas'
                when name = 'Pumps' then 'Bombas'
                when name = 'Bib-Shorts' then 'Shorts'
                when name = 'Shorts' then 'Shorts'
                when name = 'Locks' then 'Fechaduras'
                when name = 'Headsets' then 'Fones de ouvido'
            end as nome_subcategoria
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'productsubcategory') }}
    )
select
    *
from productsubcategory