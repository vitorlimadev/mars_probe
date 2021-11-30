# ProbeApi

The webserver application resposible for guiding the VI Probe in mars.

## Repository layout

This is an umbrella application with the following apps:

- `probe_api`: The domain logic about the Probe's models.
- `probe_api_web`: The web communication layer.

Outside of the apps, there is:

- `docker-compose.yml`: The docker-compose to setup the local development PostgreSQL database.

## Local setup

After cloning the project:

```shell
# Set up the development database
docker-compose up -d

# Get the dependencies
mix deps.get

# Create the development database and run migrations
mix ecto.create && mix ecto.migrate

# Starts the development server at http://localhost:4000/
iex -S mix phx.server
```

## Testing

```shell
# Run unitary tests
mix test

# Get unitary test coverage
mix test --cover
```

## Endpoints

* Postman documentation - https://www.getpostman.com/collections/7d8d4c991ecaac2796b1
