FROM elixir:1.9.1-alpine

WORKDIR /app

RUN apk update && apk add postgresql
RUN mix local.rebar --force
RUN mix local.hex --force
RUN mix archive.install hex phx_new 1.4.11 --force

RUN apk update && \
  apk add --no-cache \
  make \
  bash \
  openssl-dev

COPY . .

CMD ["/app/entrypoint.sh"]

