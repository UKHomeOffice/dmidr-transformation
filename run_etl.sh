#!/bin/bash

set -euo pipefail

./extract_data.sh

sleep 5

/.venv/bin/python ./extract_data.py

sleep 5

/.venv/bin/dbt run --project-dir ./transformations/ --profiles-dir ./transformations/profiles/
