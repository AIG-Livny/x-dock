#!/bin/bash

# Этот скрипт выполняется при создании образа внутри контейнера

set -e

# Хидер подключается первым
source $COMMON_INSIDE_PATH/header-make-image

# Если есть файлы зеркал - копируем
ln -s $INSIDE_PATH/*.list /etc/apt/sources.list.d/

# Установка пакетов из списка packages-list.txt
DEBIAN_FRONTEND=noninteractive apt install -yqq $(cat $INSIDE_PATH/packages-list.txt)

# Локали
#cp $INSIDE_PATH/locale.gen /etc
#locale-gen
#localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8

## Настройка пользователя

# Удалим стандартного пользователя
if id -u ubuntu >/dev/null 2>&1; then
  userdel -r ubuntu
fi

groupadd -g $DOCK_GID $DOCK_USER
useradd -u $DOCK_UID -g $DOCK_GID -m -s /bin/bash -G $DOCK_USER,sudo $DOCK_USER
echo "$DOCK_USER:$DOCK_PASS" | chpasswd

# Чтобы при входе не писал ничего
touch /home/$DOCK_USER/.hushlogin

# При входе сразу должны оказаться в корне проекта
echo 'cd $APP_SRC_PATH' >> /home/$DOCK_USER/.bashrc

# USER не всегда определён автоматически
echo "export USER=$DOCK_USER" >> /home/$DOCK_USER/.bashrc

# Написать приветственное сообщение при входе
echo 'print-logon-message' >> /home/$DOCK_USER/.bashrc


# Подключаем общий компонент после создания пользователя
source $COMMON_INSIDE_PATH/make-image



# Здесь установка и настройка всего необходимого для приложения



# Права на файлы передаём пользователю
chown -R $DOCK_USER /home/$DOCK_USER
