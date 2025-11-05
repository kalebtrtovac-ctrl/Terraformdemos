#!/bin/bash
# script to build and push Docker image to Artifact Registry
# runs as part of apply.sh
# read gar.output to get repo info and make sure docker tag and push use correct path

set -eou pipefail


## define keyfile
KEYFILE="./kaleb-demo-project1-d0679db7957c.json"

PROJECT=$(jq -r '.project_id' "$KEYFILE")
LOCATION="northamerica-northeast1"
REPO_NAME="Kalebs-repository"
IMAGE_NAME="tetris" ## change image name to whatever I want to run
TAG="latest"

gcloud auth activate-service-account --key-file="$KEYFILE"
gcloud config set project "$PROJECT"

# Configure Docker auth for Artifact Registry
gcloud auth configure-docker ${LOCATION}-docker.pkg.dev -q

# Build and push
cd Docker_files/tetris
docker build -t ${IMAGE_NAME}:${TAG} .
docker tag ${IMAGE_NAME}:${TAG} ${LOCATION}-docker.pkg.dev/${PROJECT}/${REPO_NAME}/${IMAGE_NAME}:${TAG}
docker push ${LOCATION}-docker.pkg.dev/${PROJECT}/${REPO_NAME}/${IMAGE_NAME}:${TAG}

echo "Pushed: ${LOCATION}-docker.pkg.dev/${PROJECT}/${REPO_NAME}/${IMAGE_NAME}:${TAG}"

cd ../..