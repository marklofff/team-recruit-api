#!/usr/bin/env sh
docker-compose build
docker-compose run app mix deps.get
docker-compose run app mix deps.compile
