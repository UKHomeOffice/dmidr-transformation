# Create dotenv file
```sh
cp ./.env.example ./.env
```
Then add credentials for the RDS instances.

# Run transformations

## Using docker
```sh
docker compose up run-transformations
```

## Using DBT CLI
### 1. Install dbt via homebrew
```sh
brew install dbt-postgres
```
### 2. Run transformations
```sh
cd transformations
dbt run --profiles-dir ./profiles
```

# Run unit tests
```sh
docker compose up test-transformations
```