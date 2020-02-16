#! /usr/bin/env bash
set -e

scriptPath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

. "${scriptPath}/../config.sh"

generateClientServerCode() {
  rm -rf "${codePath}/server"
  rm -rf "${codePath}/client"

  mkdir -p "${codePath}/server"
  mkdir -p "${codePath}/client"

  log "Building Dotnet Core Server"

  "${codeGenDir}/openapi-gen.sh" aspnetcore \
    "${codePath}" \
    server \
    "packageAuthors=Matthew,packageName=${camelCaseSdkTitle}.Api,packageTitle=${sdkTitle} API"

  log "Building Typescript Client"

  "${codeGenDir}/openapi-gen.sh" typescript-axios \
    "${codePath}" \
    client
}

generateClientServerCode
