with
    employee as (
        select
            cast(businessentityid as int) as fk_entidade_negocio
            , cast(nationalidnumber as int) as numero_identificacao_nacional
            , cast(gender as varchar) as genero
            , cast(loginid as string) as id_login
            , cast(jobtitle as string) as titulo_trabalho
            , cast(maritalstatus as varchar) as estado_civil
            , cast(salariedflag as boolean) as indicador_salario_fixo
            , cast(currentflag as boolean) as indicador_ativo
            , cast(organizationnode as string) as nodo_organizacional   
            , cast(vacationhours as int) as horas_ferias
            , cast(sickleavehours as int) as horas_licenca_medica
            , cast(birthdate as date) as data_nascimento
            , cast(hiredate as date) as data_contratacao
            , cast(modifieddate as date) as data_modificacao
        from {{ source('erp', 'employee') }}
    )
select
    *
from employee