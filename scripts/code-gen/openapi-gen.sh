#! /usr/bin/env bash
set -e

scriptPath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

. "${scriptPath}/../config.sh"

generator="$1"
baseDir="$2"
outDir="$3"
additionalProps="$4"

runOpenApiGenerator() {
  docker run \
    --rm \
    -v "${baseDir}:/local" \
    -v "${openApiSchemaFilePath}:/opt/api/doc-store-api.yml:ro" \
    openapitools/openapi-generator-cli \
    generate \
    -i "/opt/api/doc-store-api.yml" \
    -g "${generator}" \
    -o "/local/${outDir}" \
    -p "${additionalProps}"
}

runOpenApiGenerator
