#!/bin/bash


if [ ! -z $1 ]
then
    git config --global credential.helper store
    echo "https://user:$1@github.com" >> "$HOME/.git-credentials"
fi