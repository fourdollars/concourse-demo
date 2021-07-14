#!/usr/bin/env bash

set -u

vars_file=$(mktemp /tmp/setup-pipeline.XXXXXX)

cleanup() {
    rm -rf vars_file
}

# make sure expected variables are set, before we do anything
CONCOURSE_FQDN="localhost"
CONCOURSE_USER="test"
CONCOURSE_PASSWORD="test"
DOCKER_REPO=registry:5000

PIPELINE_NAME='simple-http-resource'

trap cleanup INT TERM QUIT EXIT

cat <<EOF > ${vars_file}
docker_repo: ${DOCKER_REPO}
EOF

../fly --target=demo login \
    --concourse-url="http://${CONCOURSE_FQDN}:8080" \
    --username=${CONCOURSE_USER} \
    --password=${CONCOURSE_PASSWORD} \
    --team-name=main

../fly --target=demo set-pipeline \
    --non-interactive \
    --pipeline=${PIPELINE_NAME} \
    --load-vars-from=${vars_file} \
    --config=pipeline.yml

../fly --target=demo unpause-pipeline -p ${PIPELINE_NAME}
