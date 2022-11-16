#!/bin/sh

/.venv/bin/python extract_data.py

sleep 10

cd transformations
/.venv/bin/dbt run --profiles-dir profiles