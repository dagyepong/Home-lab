#! /usr/bin/env bash

backup_label=kopia_backup
containers_to_backup=( $(docker ps --filter "label=$backup_label" -q) )

for container in "${containers_to_backup[@]}"
do
    docker unpause "$container"
done
