#!/bin/bash

set -euo pipefail

./extract_data.sh

cd transformations
/.venv/bin/dbt run --profiles-dir profiles

cd ../
./output_test.sh
