with
    employee as (
        select
            cast(businessentityid as int) as businessentityid
            , cast(nationalidnumber as int) as nationalidnumber
            , cast(loginid as string) as loginid
            , cast(jobtitle as string) as string
            , cast(birthdate as date) as birthdate
            , cast(maritalstatus as varchar) as maritalstatus
            , cast(gender as varchar) as gender
            , cast(hiredate as date) as hiredate
            , cast(salariedflag as boolean) as salariedflag
            , cast(vacationhours as int) as vacationhours
            , cast(sickleavehours as int) as sickleavehours
            , cast(currentflag as boolean) as currentflag
            , cast(modifieddate as date) as modifieddate
            , cast(organizationnode as string) as organizationnode            
        from {{ source('erp', 'employee') }}
    )
select
    *
from employee