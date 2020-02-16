#! /usr/bin/env bash
set -e

scriptPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. "${scriptPath}/config.sh"

docsOutPath="${docsPath}/out"

buildSlateHtml() {
  log "Generating HTML Docs From Markdown"

  docker build -t slate:alpine "${docsPath}"

  docker run \
    -v "${docsOutPath}/doc-store-api.md:/slate/source/index.html.md:ro" \
    -v "${docsPath}/logo.png:/slate/source/images/logo.png:ro" \
    -v "${docsOutPath}:/slate/build" \
    slate:alpine
}

generateMarkdown() {
  log "Generating Slate/Shins Markdown"

  pushd "${scriptPath}" > /dev/null

  yarn run widdershins \
    --search false \
    --summary "${openApiSchemaFilePath}" \
    -o "${docsOutPath}/doc-store-api.md"

  popd
}

buildDocs() {
  rm -rf "${docsOutPath}"
  mkdir -p "${docsOutPath}"

  generateMarkdown
  buildSlateHtml
}

buildDocs
