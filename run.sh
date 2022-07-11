#!/bin/sh

docker build -t git . && docker run -e DIREKTIV_TEST=true -p 9191:8080 -p 9292:9292 git