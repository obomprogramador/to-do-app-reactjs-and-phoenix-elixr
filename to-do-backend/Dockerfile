FROM elixir:1.16.1

ARG PHOENIX_VERSION=1.7.12
ARG NODE_VERSION=20.10.0

RUN apt update \
  && apt upgrade -y \
  && apt install -y bash curl git build-essential inotify-tools

ENV NVM_DIR /opt/nvm
RUN mkdir -p ${NVM_DIR} \
  && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash \
  && . $NVM_DIR/nvm.sh \
  && nvm install ${NODE_VERSION} \
  && nvm alias default ${NODE_VERSION} \
  && nvm use default \
  && npm install -g yarn

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN mix local.hex --force
RUN mix archive.install --force hex phx_new ${PHOENIX_VERSION}
RUN mix local.rebar --force
RUN mix do deps.get, deps.compile

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

EXPOSE 4000

# CMD mix do ecto.setup