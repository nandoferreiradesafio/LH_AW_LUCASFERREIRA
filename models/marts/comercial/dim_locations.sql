with
    stg_erp__countryregion as (
        select 
            *
        from {{ ref('stg_erp__countryregion') }}
    )

    , stg_erp__businessentityaddress as(
        select
            *
        from {{ ref('stg_erp__businessentityaddress') }}
    )

    , stg_erp__address as (
        select
            *
        from {{ ref('stg_erp__address') }}
    )

    , stg_erp__salesterritory as (
        select
            *
        from {{ ref('stg_erp__salesterritory') }}
    )

    , stg_erp__stateprovince as (
        select
            *
        from {{ ref('stg_erp__stateprovince') }}
    )

    , stg_erp__salesorderheader as (
        select
            *
        from {{ ref('stg_erp__salesorderheader') }}
    )

    ,  transformed_data_locations as (
        select
            distinct(stg_erp__salesorderheader.fk_endereco_faturamento)
            , stg_erp__salesorderheader.fk_territorio
            , stg_erp__countryregion.codigo_regiao_pais
            , stg_erp__countryregion.nome_regiao_pais
            , stg_erp__businessentityaddress.fk_entidade_negocio
            , stg_erp__businessentityaddress.fk_endereco
            , stg_erp__businessentityaddress.fk_tipo_endereco
            , stg_erp__address.pk_endereco
            , stg_erp__address.fk_estado_provincia
            , stg_erp__address.endereco_primeiro
            , stg_erp__address.nome_cidade
            , stg_erp__salesterritory.pk_territorio_venda
            , stg_erp__salesterritory.nome_territorio
            , stg_erp__stateprovince.pk_estado_provincia
            , stg_erp__stateprovince.codigo_estado_provincia
            , stg_erp__stateprovince.nome_estado_provincia 
            , {{ 
                dbt_utils.generate_surrogate_key([
                    'stg_erp__businessentityaddress.fk_entidade_negocio', 
                    'stg_erp__salesorderheader.fk_endereco_faturamento',
                    'stg_erp__address.pk_endereco'
                ]) 
            }} as sk_location
        from stg_erp__salesorderheader
        left join stg_erp__address
            on stg_erp__salesorderheader.fk_endereco_envio = stg_erp__address.pk_endereco
        left join stg_erp__stateprovince
            on stg_erp__stateprovince.pk_estado_provincia = stg_erp__address.fk_estado_provincia
        left join stg_erp__salesterritory
            on stg_erp__salesterritory.pk_territorio_venda = stg_erp__salesorderheader.fk_territorio
        left join stg_erp__countryregion
            on stg_erp__countryregion.codigo_regiao_pais = stg_erp__stateprovince.codigo_regiao_pais
        left join stg_erp__businessentityaddress
            on stg_erp__businessentityaddress.fk_endereco = stg_erp__address.pk_endereco
    )

select
    *
from transformed_data_locations