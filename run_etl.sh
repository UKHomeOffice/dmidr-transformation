#!/bin/bash

set -euo pipefail

./extract_data.sh

# probably can do a return in bash to make sure we are finished extracting data here
sleep 10

cd transformations
/.venv/bin/dbt run --profiles-dir profiles

sleep 10
cd ../
./output_test.sh