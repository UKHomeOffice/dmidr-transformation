-- Create view for performance summary
-- WITH mpam_due_cases_performance_closed AS (
--    SELECT case_deadline as due,
--           case_type as answered,
--           uuid as uuid,
--           business_area,
--           in_time 
-- );
-- FROM {{ ref('flatten') }}
-- WHERE case_type="CASE_CLOSED" GROUP BY business_area; 

-- SELECT * FROM mpam_due_cases_performance_closed;

-- WITH mpam_due_cases_performance_open AS (
--     SELECT case_deadline as due,
--     uuid as uuid,
--     business_area
-- );
-- FROM {{ ref('flatten') }}
-- WHERE case_type!="CASE_CLOSED" AND uuid!=mpam_due_cases_performance_closed.uuid 
-- GROUP BY business_area;


-- Create view for performance summary with answered
CREATE TABLE if NOT EXISTS mpam_due_cases_performance_closed (
    type VARCHAR(500), business_area VARCHAR(500),
    case_deadline VARCHAR(500), business_area VARCHAR(500)
);
INSERT INTO mpam_due_cases_performance_closed (type, business_area) 
SELECT public.flatten.case_uuid, transformation.audit_event.type, 
public.flatten.case_deadline, public.flatten.business_area  
FROM transformation.audit_event 
INNER JOIN public.flatten 
ON public.flatten.case_uuid = transformation.audit_event.case_uuid 
AND transformation.audit_event.type='CASE_CLOSED';

-- Create view for performance summary with unanswered
WITH mpam_due_cases_performance_open AS (
SELECT 
public.flatten.case_uuid, transformation.audit_event.type, 
public.flatten.case_deadline, public.flatten.business_area  
);
FROM transformation.audit_event 
INNER JOIN public.flatten 
ON public.flatten.case_uuid = transformation.audit_event.case_uuid 
AND transformation.audit_event.type='CASE_CLOSED'
AND public.flatten.case_uuid!=;