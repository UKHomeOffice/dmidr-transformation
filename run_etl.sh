#!/bin/bash

set -euo pipefail

#./extract_data.sh

#/.venv/bin/python ./extract_data.py

cd transformations
/.venv/bin/dbt run --profiles-dir profiles

cd ../
./output_test.sh

sleep 500
