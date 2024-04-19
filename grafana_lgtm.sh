#!/bin/bash


podman run \
    --rm \
    -p 3000:3000 \
    -p 4317:4317 \
    -p 4318:4318 \
    -ti \
    docker.io/grafana/otel-lgtm
