#! /usr/bin/env bash
set -e

scriptPath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

. "${scriptPath}/../config.sh"

generateDbSchema() {
  rm -rf "${codePath}/database"

  mkdir -p "${codePath}/database"

  "${codeGenDir}/openapi-gen.sh" mysql-schema \
    "${codePath}" \
    database \
    "defaultDatabaseName=${sdkTitle},identifierNamingConvention=snake_case"
}

generateDbSchema
