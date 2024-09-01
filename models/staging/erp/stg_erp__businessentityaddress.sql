with
    businessentityaddress as (
        select
            cast(businessentityid as int) as fk_entidade_negocio
            , cast(addressid as int) as fk_endereco
            , cast(addresstypeid as int) as fk_tipo_endereco
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'businessentityaddress') }}
    )
select
    *
from businessentityaddress