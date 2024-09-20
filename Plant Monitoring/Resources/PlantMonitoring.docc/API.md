# API

This article explains the Plant Monitor API.

## Overview

The **Plant Monitor API** allows you to interact with the backend system for managing plants, devices, and sensor data. This API provides endpoints for creating, retrieving, updating, and deleting plants and devices, as well as handling sensor outputs.

- **API Base URL**: [https://api.aysilsimge.dev](https://api.aysilsimge.dev)
- **API Swagger Documentation**: [https://api.aysilsimge.dev/docs#/](https://api.aysilsimge.dev/docs#/)

## Authorization

The **Plant Monitor API** uses **Bearer Token Authentication** to protect certain endpoints. You must authenticate with valid credentials to receive a token that will be used in subsequent API requests.

## Authentication Flow

To obtain an authorization token, you need to send a `POST` request to the `/GetAuth` endpoint with the required credentials (username and password). This is typically done securely by storing credentials in environment variables or using a secure credentials manager.

Example cURL request to obtain a token:

```bash
curl --location 'https://api.aysilsimge.dev/GetAuth' \
--header 'Content-Type: application/json' \
--data '{
  "username": "your-username",
  "password": "your-password"
}``

## Response

If the authentication is successful, the server will respond with a token. This token must be used in the Authorization header for all future requests to protected endpoints.

Example response:

```json
{
    "access_token": "your-generated-token",
    "token_type": "bearer"
}
```

## Using the Token

Once you have obtained the token, include it in the Authorization header for all future requests to secured endpoints:

```bash
curl --location 'https://api.aysilsimge.dev/GetPlants' \
--header 'Authorization: Bearer <your-generated-token>'
```

This ensures that the API knows you are an authorized user.

## Usage

To interact with the API, make HTTP requests to the base URL, followed by the specific endpoint. For example, to create a plant, you would make a POST request to /CreatePlant at https://api.aysilsimge.dev/CreatePlant.

You can use the API documentation via Swagger to explore endpoints and test different API requests interactively.
