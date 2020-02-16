# Document Store API SDK

This package contains resources that will help you work with the Document Store API.

## Table of Contents

- [Documentation](#docs)
- [OpenAPI Specification](#spec)
- [JSON Schema](#json-schema)
- [Mock Server](#mock-server)
- [Code Examples](#code-examples)

----

## Documentation
<a name="docs"></a>

----

Complete documentation for the Document Store API is provided by [doc-store-api.pdf](doc-store-api.pdf).

Interactive API documentation with client code examples can be found in [api-docs/index.html](api-docs/index.html).

----

## OpenAPI Specification
<a name="spec"></a>

----

```
The OpenAPI Specification (OAS) defines a standard, language-agnostic interface to RESTful APIs which allows both humans and computers to discover and understand the capabilities of the service without access to source code, documentation, or through network traffic inspection. 

When properly defined, a consumer can understand and interact with the remote service with a minimal amount of implementation logic.
```

*See: https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md*

An OpenAPI v3 specification file is included which provides technical documentation for the Document Store API. This includes security scheme, endpoints, query parameters, request bodies, response status codes and response bodies.

See: [openapi-spec/doc-store-api.yaml](openapi-spec/doc-store-api.yaml)

----

## JSON Schema
<a name="json-schema"></a>

----

```
JSON Schema is a vocabulary that allows you to annotate and validate JSON documents.
```

*See: https://json-schema.org/*

Each request and response has a defined model, with constraints on expected property names, acceptable property values and formats. These constraints are described by the JSON schema files included in the `json-schema` directory.

These can be used to validate your request models and understand what the data coming back from the API will look like, in terms of object structure and value formats.

A really simple and easy to use online validator is [JSON Schema Validator](https://www.jsonschemavalidator.net/). You can paste in a request schema and your request JSON to see if it is valid and view any errors.

See [JSON Schema Implementation](https://json-schema.org/implementations.html) for a curated list of Schema validators and parsers for many popular languages. (C#, Java, Node.js, Python etc.)

----

## Mock Server
<a name="mock-server"></a>

----

A mock of the Document Store API is provided which you can use to test real HTTP requests and get sample responses back.

This also comes with a built in Swagger UI instance.

See: [mock-server/README.pdf](mock-server/README.pdf)

----

## Code Examples
<a name="code-examples"></a>

----

An example implementation of a client can be found in [api-code/client](api-code/client). This uses TypeScript and the [axios](https://github.com/axios/axios/blob/master/README.md) HTTP library.

A server stub written using ASP.NET Core 2.0 can be found in [api-code/server](api-code/server).


A MySQL database schema file can be found in [api-code/database](api-code/database).
