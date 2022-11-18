select distinct 
    case_uuid 
from 
    {{ source('transformation', 'audit_event') }}
where
    type = 'CASE_CREATED'