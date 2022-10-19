select
    "timestamp",
    "event",
    "reference",
    "deadline",
    "DateReceived"
from {{ source('decs_raw', 'case_data') }}
where
    "event" = 'CASE_CREATED' or "event" = 'CASE_COMPLETED'