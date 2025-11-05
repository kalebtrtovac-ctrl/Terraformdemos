#!/bin/bash

## run check_api.sh before this script to ensure APIs are enabled

# Apply Terraform in Artifact_repo to create Artifact Registry
cd Artifact_repo
terraform init
terraform apply -auto-approve
cd ..

# Build and push the Docker image
./build-and-push.sh

# Apply Terraform in infra to create Cloud Run service and related resources
cd infra
terraform init
terraform apply -auto-approve
cd ..

