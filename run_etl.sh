#!/bin/bash

set -euo pipefail

sleep 5
./extract_data.sh

sleep 5
cd transformations
/.venv/bin/dbt run --profiles-dir profiles

cd ../
./output_test.sh
