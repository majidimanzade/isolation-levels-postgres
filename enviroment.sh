#!/bin/bash

# Define variables
POSTGRES_IMAGE="bitnami/postgresql:latest"
POSTGRES_CONTAINER_NAME="postgres_container"
POSTGRES_PASSWORD="mysecretpassword"
POSTGRES_DB="mydatabase"
POSTGRES_USER="postgres"
TABLE_NAME="accounts"
DB_PORT=5432

# Pull the latest PostgreSQL image from Docker Hub
echo "Pulling PostgreSQL Docker image: $POSTGRES_IMAGE"
docker pull $POSTGRES_IMAGE

# Run the PostgreSQL container
echo "Starting PostgreSQL container..."
docker run -d \
  --name $POSTGRES_CONTAINER_NAME \
  -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  -e POSTGRES_DB=$POSTGRES_DB \
  -p $DB_PORT:5432 \
  $POSTGRES_IMAGE

# Wait for the PostgreSQL container to start
echo "Waiting for PostgreSQL to start..."
sleep 5  # You can increase the wait time if needed

# Connect to PostgreSQL and create a table with default values
echo "Creating database and table with default values..."

docker exec -i $POSTGRES_CONTAINER_NAME psql -U $POSTGRES_USER -d $POSTGRES_DB <<EOF
CREATE TABLE IF NOT EXISTS $TABLE_NAME (
    id SERIAL PRIMARY KEY,
    balance DECIMAL(10, 2) NOT NULL
);

INSERT INTO $TABLE_NAME (balance) VALUES
(100.50),
(200.75),
(150.00),
(50.25),
(300.80),
(500.00),
(250.00),
(120.50),
(75.10),
(180.90);

SELECT * FROM $TABLE_NAME;
EOF

echo "Database and table created successfully with default values!"

# Show success message
echo "Script completed."

