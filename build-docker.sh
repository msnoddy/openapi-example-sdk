#! /usr/bin/env bash
set -e

scriptPath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

. "${scriptPath}/scripts/config.sh"

imageName="api-sdk-build-env"

buildInDocker() {
  docker build -t "${imageName}" "${rootPath}"

  docker run --rm \
    -v "/var/run/docker.sock:/var/run/docker.sock" \
    -v "${rootPath}:${rootPath}" \
    -w "${rootPath}" \
    "${imageName}"
}

buildInDocker
