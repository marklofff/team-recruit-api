#!/usr/bin/env bash

docker-compose build
docker-compose run app mix deps.get
docker-compose run app mix ecto.create
docker-compose run app mix ecto.migrate
