# Mock Doc Store API

A mock Doc Store API that can be used to test endpoints, requests and responses. 

This mock server is served using [Docker](https://www.docker.com/) and [Prism](https://github.com/stoplightio/prism).

The server will validate request query parameters and request body JSON. This validation will follow the rules documented in [doc-store-api.pdf](../doc-store-api.pdf), which are based on the [doc-store-api.yaml](../openapi-spec/doc-store-api.yaml) OpenAPI specification.

---

## Setup

---

To run this mock API, you will need:

- `Docker`: Available for Windows, MacOS and Linux. See: https://docs.docker.com/install/ 
- `Docker Compose`: Bundled with Windows and MacOS versions of Docker, for Linux you need to install this yourself. See: https://docs.docker.com/compose/install/

*If you are planning to run Docker on Windows, at a minimum you need Windows 10 64bit (Pro, Enterprise or Education)*

---

## Running

---

- Make sure you don't have another app listening on port `8080`

- Open a terminal/command line in the `mock-server` directory, and run:

    ```bash
    ./start
    ```

    *On MacOS and Windows you may get prompts to add a firewall rule and to allow disk access when running this, if using Docker for the first time*

    *Tip: on Windows you can simply double click the `start.bat` file in explorer to start the server*

- This will start the mock API listening on port `8080`

- Open [http://localhost:8080/swagger-ui/](http://localhost:8080/swagger-ui/) to view the API in Swagger UI. You can try out API requests directly from this web app.

- Open [http://localhost:8080/api-docs](http://localhost:8080/api-docs) to view the interactive API documentation with code examples.

---

## Calling the API

---

API requests can be made using the base URL [http://localhost:8080/doc-store/api/v1](http://localhost:8080/doc-store/api/v1)

For example, to call the API status endpoint:

- curl

    ```bash
    curl -vvvv -X GET "http://localhost:8080/doc-store/api/v1/status"
    ```

- PowerShell

    ```powershell
    Invoke-WebRequest -UseBasicParsing -Method GET -URI "http://localhost:8080/doc-store/api/v1/status"
    ```

---

## Simulating Errors

---

If you want to test error responses for an endpoint, you have two options:

- Use a sample invalid request when calling the API, these are documented in [doc-store-api.pdf](../doc-store-api.pdf) and the [doc-store-api.yaml](../openapi-spec/doc-store-api.yaml) spec

- Omit a required field from the request body or pass a body with a field in the wrong format

- Pass an extra query parameter `__code` with the response code you want to test, for example:

    ```bash
    curl -X POST "http://localhost:8080/doc-store/api/v1/login?__code=500"
    ```

### Validation Errors

When you make a request which fails the query string or request body schema validation, the OpenAPI specification example HTTP 400 error response for that endpoint will always be returned, which may not include details of your specific validation error.

If you want to see what the specific error is, use the JSON schemas provided in `json-schemas` to validate your request body; see [README.pdf](../README.pdf) for more info.

#### Unicode Characters

Certain fields (such as names) are sometimes checked to ensure that the first character is a letter. This is set to allow a letter in any language, however the mock server will only recognise letters of the latin alphabet and throw an error if a unicode letter is used as the first character.

Unicode letters can still be used anywhere else in the string. A real API implementation can validate unicode letters correctly; this is only a limitation of the mock server.

*Note: JSON schema validators will not have this limitation*
