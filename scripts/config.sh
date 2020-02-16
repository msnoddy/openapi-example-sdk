#! /usr/bin/env bash
set -e

# polyfill for realpath command using python
command -v realpath &> /dev/null || realpath() {
    python -c "import os; print os.path.abspath('$1')"
}

scriptsPath=$(realpath "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )")

rootPath=$(realpath "${scriptsPath}/..")

sdkTitle="doc-store"
camelCaseSdkTitle="DocStore"

outPath="${rootPath}/out"
docsPath="${rootPath}/api-docs"
mockServerPath="${rootPath}/mock-api"
specPath="${rootPath}/openapi-spec/${sdkTitle}-api.yml"

docTemplatePath="${docsPath}/pdf-template"
codeGenDir="${scriptsPath}/code-gen"

outDir="${outPath}/${sdkTitle}"
jsonSchemaPath="${outDir}/json-schema"
codePath="${outDir}/api-code"
openApiSchemaPath="${outDir}/openapi-spec"

openApiSchemaFilePath="${openApiSchemaPath}/${sdkTitle}-api.yml"
docPath="${outDir}/${sdkTitle}-api.md"

defaultApiVersion="0.1.0"
mdToPdfChromeArgs='["--no-sandbox", "--disable-setuid-sandbox"]'

getLogTimestamp() {
  date "+%d-%m-%Y %H:%M:%S"
}

log() {
  message="[$(getLogTimestamp)] ${1}"
  messageLength=${#message}
  charPlaceholders=$(eval echo -n "{1..${messageLength}}")

  echo
  printf '=%.0s' ${charPlaceholders}
  echo

  echo "${message}"

  printf '=%.0s' ${charPlaceholders}
  echo
  echo
}
