#!/bin/bash

#
# Финальный этап запуска контейнера
#

DOCK_USER=$1
SSH_AUTH_SOCK=$2
DOCK_PORTS=$3

echo -e "\n" >> /etc/environment
echo "export DOCK_PORTS='$DOCK_PORTS'" >> /etc/environment

service ssh start