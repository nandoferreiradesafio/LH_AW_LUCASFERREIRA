with
    person as (
        select 
            cast(businessentityid as int) as businessentityid
            , cast(persontype as varchar) as persontype
            , cast(namestyle as boolean) as namestyle
            , cast(title as string) as title
            , cast(firstname as string) as firstname
            , cast(middlename as string) as middlename
            , cast(lastname as string) as lastname
            , cast(suffix as string) as suffix
            , cast(emailpromotion as int) as emailpromotion
            , cast(additionalcontactinfo as string)  as additionalcontactinfo
            , cast(demographics as string) as demographics
            , cast(modifieddate as date) as modifieddate
        from {{ source('erp', 'person') }}
    )
select
    *
from person