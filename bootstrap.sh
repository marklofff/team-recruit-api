#!/usr/bin/bash

docker-compose run frontend yarn
docker-compose run app mix deps.get
docker-compose run app mix ecto.reset

