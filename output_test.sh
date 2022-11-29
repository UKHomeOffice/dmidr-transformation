#!/bin/bash

set -euo pipefail

PGPASSWORD=${transformation_db_password} psql -h${transformation_db_host} -p${transformation_db_port} -d${transformation_db_name} -U${transformation_db_username} << EOF
select * from public.mpam_due_cases;
EOF