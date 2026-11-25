#!/bin/bash

#
# Финальный этап запуска контейнера
#
# Окружение экземпляра (в т.ч. DOCK_PORTS) уже лежит в /etc/environment:
# файл создаётся на хосте при создании экземпляра и копируется в контейнер
#

DOCK_USER="$1"

source /etc/environment

service ssh start