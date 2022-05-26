#!/usr/bin/env bash
PROJECT_LOCAL_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_NAME="$(basename "$PROJECT_LOCAL_PATH")"

docker run  --rm \
            --interactive \
            --tty \
            --privileged \
            --mount type=bind,source="$PROJECT_LOCAL_PATH",target="/home/nxtuser/projects/$PROJECT_NAME" \
            --workdir "/home/nxtuser/projects/$PROJECT_NAME" \
            nxtosek:latest \
            "$@" 