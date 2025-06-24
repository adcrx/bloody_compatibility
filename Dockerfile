FROM elixir:1.15

RUN mix local.hex --force && \
    mix local.rebar --force

RUN apt-get update && \
    apt-get install -y build-essential inotify-tools

WORKDIR /app

COPY mix.exs mix.lock ./
RUN mix deps.get

COPY . .
