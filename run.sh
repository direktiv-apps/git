#!/bin/sh

docker build -t git . && docker run -p 9191:8080 git