-- Create TABLE for performance summary with answered
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE if NOT EXISTS mpam_due_cases_performance_closed (
    case_uuid uuid, business_type VARCHAR(500), 
    business_area VARCHAR(500), case_deadline VARCHAR(500) 
);
INSERT INTO public.mpam_due_cases_performance_closed (case_uuid, business_type, 
business_area, case_deadline) 
SELECT DISTINCT 
public.flatten.case_uuid, transformation.audit_event.type, 
public.flatten.business_area, public.flatten.case_deadline  
FROM transformation.audit_event 
INNER JOIN public.flatten 
ON public.flatten.case_uuid = transformation.audit_event.case_uuid 
AND transformation.audit_event.type='CASE_CLOSED';

-- Create TABLE for performance summary with unanswered
CREATE TABLE if NOT EXISTS mpam_due_cases_performance_open (
    case_uuid uuid, business_type VARCHAR(500), 
    business_area VARCHAR(500), case_deadline VARCHAR(500) 
);

INSERT INTO public.mpam_due_cases_performance_open (case_uuid, business_type, 
business_area, case_deadline)
SELECT DISTINCT
public.flatten.case_uuid, transformation.audit_event.type,
public.flatten.business_area, public.flatten.case_deadline  
FROM transformation.audit_event, mpam_due_cases_performance_closed, public.flatten
WHERE public.flatten.case_uuid = transformation.audit_event.case_uuid 
AND transformation.audit_event.type!='CASE_CLOSED'
AND public.flatten.case_uuid!=mpam_due_cases_performance_closed.case_uuid;

-- create view for performance report
SELECT 
public.flatten.business_area as business_area,
(SELECT COUNT(public.mpam_due_cases_performance_closed.case_uuid) FROM mpam_due_cases_performance_closed) AS Answered,
(SELECT COUNT(public.mpam_due_cases_performance_open.case_uuid) FROM mpam_due_cases_performance_open) / 
(SELECT COUNT(public.mpam_due_cases_performance_closed.case_uuid) FROM mpam_due_cases_performance_closed) AS Performance,
(SELECT COUNT(public.mpam_due_cases_performance_open.case_uuid) FROM mpam_due_cases_performance_open) AS Unanswered      
FROM mpam_due_cases_performance_open, mpam_due_cases_performance_closed, public.flatten
WHERE
public.flatten.business_area = public.mpam_due_cases_performance_open.business_area
OR 
public.flatten.business_area = public.mpam_due_cases_performance_closed.business_area
GROUP BY public.flatten.business_area;