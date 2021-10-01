FROM elixir:1.12-alpine

ARG MIX_ENV

ENV SHELL=/bin/bash

WORKDIR /app
COPY ./_build/${MIX_ENV}/rel/phoenix_svelte_adminlte .

CMD ["./bin/phoenix_svelte_adminlte", "start"]
