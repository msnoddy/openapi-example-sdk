# OpenAPI Example SDK

Design first approach to API development.

This repo contains build scripts for an example API SDK using the OpenAPI specification and open source tools.

It uses a simple document store API as an example interface, see the spec file @  [openapi-spec/doc-store-api.yml](openapi-spec/doc-store-api.yml).

Originally developed for a [Kainos](https://www.kainos.com) team talk in February 2020.

## SDK Structure

Documentation for the SDK itself can be found in `api-docs/README.md`. It will describe how to use the tools and files included. 

The `api-docs/pdf-template` directory holds a customised template for the Node.js `openapi3-generator` package which generates the API documentation from the OpenAPI spec.

## Quickstart

You can either build the API SDK example directly or use docker.

### Direct Build

Make sure you have the following installed:

- [Docker](https://www.docker.com/products/docker-desktop)
- `pipenv`
- `yarn`
- `jq`
- `python` version specified in `Pipfile` *(brew install of pipenv bundles python 3)*
- `node.js` version specified in `.nvmrc` OR `nvm`

*You can use `brew` to install all of the above*

Ensure `docker` is running and run the main build script:

```bash
./build.sh
```

### Docker Build

This method requires no tools other than [Docker](https://www.docker.com/products/docker-desktop) to be installed.

Ensure `docker` is running and run the docker build script:

```bash
./build-docker.sh
```

### Output

Output files and a ZIP package are placed in the `out` directory. This contains the following files:

```
├── README.pdf              // SDK docs
├── doc-store-api.pdf       // API docs
├── api-code                // Code examples
│   ├── client
│   ├── database
│   ├── server
├── api-docs                // HTML API docs
│   ├── index.html
│   ├── ...
├── json-schema             // API JSON schemas
│   ├── doc-metadata.json
│   ├── ...
├── mock-api                // Mock API server
│   ├── README.pdf
│   ├── ...
└── openapi-spec            // OpenAPI v3 Schema
    └── doc-store-api.yaml
```

## Mock Server

An API mock server has been created in the `mock-api` directory. This uses Docker and docker-compose to create a mock API using the OpenAPI spec.

See: `mock-api/README.md`

## Build Pipeline

1. API spec is copied from the `openapi-spec` dir
1. Version is extracted from spec using `yq`
1. JSON schemas are generated using `openapi2jsonschema`
1. Mock server files are copied from the `mock-api` dir
1. API Spec is converted to a Markdown file using `openapi3-generator`, template stored in `api-docs/pdf-template`
1. HTML documentation for the spec is generated using `widdershins` and `slate`
1. Client, Server and Database code is generated from the spec using `openapi-generator`
1. README files and the API markdown doc are converted to PDF using `pretty-md-pdf`
1. All the generated artifacts are packaged in a zip

## Tools Used

There are three main sources of tools for this project:

- pipenv (Python)
- yarn (Node.js)
- docker

Below is a listing of all tools used:

| Tool                 | Description                                                                                                                         | Provided by |
|----------------------|-------------------------------------------------------------------------------------------------------------------------------------|-------------|
| `yq`                 | YAML version of the `jq` command, used to extract API version from spec                                                             | pipenv      |
| `openapi2jsonschema` | Converts schema definitions in the spec into JSON Schemas                                                                           | pipenv      |
| `docker-compose`     | Hosts the environment for the Mock API                                                                                              | pipenv      |
| `prism`              | Mock API that  serve requests based on an OpenAPI spec                                                                           | docker      |
| `swagger-ui`         | Browser interface to view the spec and call the Mock API                                                                            | docker      |
| `nginx`              | Reverse proxy to serve both prism and swagger-ui                                                                                    | docker      |
| `openapi3-generator` | Generates text from OpenAPI specs using handlebar templates. This builds the static API documentation.                              | yarn        |
| `widdershins`        | Builds slate compatible markdown from different formats, including OpenAPI. Used to build a slate doc from the spec.                | yarn        |
| `slate`              | Framework to build rich HTML docs from it's own markdown format. The `widdershins` output is loaded into this to generate API docs.   | docker      |
| `openapi-generator`  | Generates code using OpenAPI specs. Used to generate a server project, client code and a database schema.                           | docker      |
| `pretty-md-pdf`      | Produces nice looking PDF files from raw markdown. This is used to make the API docs generated by `openapi3-generator` easier to use. | yarn        |

## Other OpenAPI Tools

There are a wide variety of open source and web based tools for working with OpenAPI specs. Below are a few good starting points:

- [Swagger Editor](https://editor.swagger.io/): Import the API spec file into this editor
    - Provides Swagger UI to explore the spec
    - Generate server stubs and clients in many popular langauages (C#, Java, Node.js, Python etc.)
- [OpenAPI Tools](https://openapi.tools/): Curated list of OpenAPI tools (note: not all tools listed support OpenAPI v3 currently)
