FROM elixir:1.8.1-slim

# Allow builds to occur for different mix environments, default to dev.
ARG environment=prod
ENV MIX_ENV=${environment}

# Install Hex and Phoenix
RUN mix local.hex --force
RUN mix local.rebar --force

# install curl and bash
RUN apt-get update
RUN apt-get install -y -q bash curl gpg

# Install node
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y -q inotify-tools nodejs

# Create folder for Application to live
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install Elixir Dependencies
RUN mix deps.clean --all
RUN mix deps.get --only prod

RUN cd assets && npm install && cd ..
RUN cd assets && npx webpack --mode production && cd ..
RUN mix compile
RUN mix phx.digest
