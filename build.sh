#! /usr/bin/env bash
set -e

scriptPath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

. "${scriptPath}/scripts/config.sh"

specUri="${1:-${specPath}}"

function buildSdkZip() {
  apiVersion="${1:-$defaultApiVersion}"
  zipFilename="${sdkTitle}_v${apiVersion}.zip"
  zipPath="${outPath}/${zipFilename}"

  log "Packaging SDK into ${zipFilename}"

  zip -r "${zipPath}" ${outDir}/*
}

function generateServerClientAndDb() {
  mkdir -p "${codePath}"

  "${codeGenDir}/generate-client-server.sh"
  "${codeGenDir}/generate-db-schema.sh"

  # cleanup useless generated files
  rm -rf "${codePath}/client/.openapi-generator" \
    "${codePath}/server/.openapi-generator" \
    "${codePath}/database/.openapi-generator"

  rm -f "${codePath}/client/.openapi-generator-ignore" \
    "${codePath}/server/.openapi-generator-ignore" \
    "${codePath}/database/.openapi-generator-ignore"
}

function generateDocs() {
  log "Generating Static API Docs"

  yarn run og --templates "${docTemplatePath}" --output "${outDir}" "${specUri}" markdown
  mv "${outDir}/openapi.md" "${docPath}"

  "${scriptsPath}/generate-docs.sh"
  mv "${scriptPath}/api-docs/out" "${outDir}/api-docs"

  log "Build API Doc PDFs"

  yarn run pretty-md-pdf -i "${docPath}" --chromium-args "${mdToPdfChromeArgs}"
  yarn run pretty-md-pdf -i "${docsPath}/README.md" -o "${outDir}/README.pdf" --chromium-args "${mdToPdfChromeArgs}"
  yarn run pretty-md-pdf -i "${outDir}/mock-api/README.md" --chromium-args "${mdToPdfChromeArgs}"

  # cleanup
  rm "${docPath}"
  rm "${outDir}/mock-api/README.md"
}

function copyMockServer() {
  log "Copying Mock API Server Files"

  cp -r "${mockServerPath}" "${outDir}/mock-api"
}

function generateJsonSchemas() {
  log "Generating JSON Schemas"

  # generate schemas
  pipenv run openapi2jsonschema --output "${jsonSchemaPath}" "${specUri}"

  # dereference all schemas (no refs, place whole schema in one file)
  pushd "${outDir}" > /dev/null

  pipenv run openapi2jsonschema --output "json-schema" --stand-alone "file://${specUri}"

  popd
}

function downloadOpenApiSpec() {
  if [ -f "${specUri}" ]; then
      # api spec is a file
      cp "${specUri}" "${openApiSchemaFilePath}"
  else 
      wget -O "${openApiSchemaFilePath}" "${specUri}"
  fi

  # return OpenAPI spec version
  pipenv run yq -r .info.version "${openApiSchemaFilePath}"
}

function packageSdk() {
  log "Building Out Directory"

  rm -rf "${outPath}"
  mkdir -p "${openApiSchemaPath}"

  log "Installing tools"

  pushd "${scriptPath}" > /dev/null

  pipenv install
  yarn install

  popd

  log "Getting OpenAPI Spec"
  openApiSpecVersion=$(downloadOpenApiSpec)

  generateJsonSchemas
  copyMockServer
  generateDocs

  generateServerClientAndDb

  buildSdkZip "${openApiSpecVersion}"
}

function errorAndExit() {
  >&2 echo "ERROR: ${1}"
  exit 1
}

function assertCommandPresent() {
  if [ ! -x "$(command -v ${1})" ]; then
    errorAndExit "${1} is not installed, see README.md for help"
  fi
}

function main() {
  assertCommandPresent "docker"
  assertCommandPresent "pipenv"
  assertCommandPresent "yarn"

  if [ -z "${specUri}" ]; then
    errorAndExit "Blank API spec URI passed to script"
  fi

  packageSdk

  log "SDK Build Finished"
}

main
