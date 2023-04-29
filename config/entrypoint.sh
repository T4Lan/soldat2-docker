#!/bin/bash

cd soldat2

sed -i "s|RCON_PASSWORD|${RCON_PASSWORD}|g" autoconfig.ini
sed -i "s|SERVER_NAME|${SERVER_NAME}|g" autoconfig.ini
sed -i "s|SERVER_GREET_MESSAGE|${SERVER_GREET_MESSAGE}|g" autoconfig.ini

exec "$@"