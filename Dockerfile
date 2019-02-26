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
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y -q inotify-tools nodejs
RUN npm install --global webpack

# Create folder for Application to live
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install Elixir Dependencies
RUN mix deps.clean --all
RUN mix deps.get --only prod

RUN cd assets && webpack --mode production
RUN mix phx.digest
