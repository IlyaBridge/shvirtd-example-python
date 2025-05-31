#!/bin/bash

# Установка Docker
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Установка Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Клонирование репозитория
sudo mkdir -p /opt/app
cd /opt/app
sudo git clone https://github.com/IlyaBridge/shvirtd-example-python.git
cd shvirtd-example-python

# Запуск проекта
sudo docker-compose up -d --build

# Дополнительное ожидание для инициализации MySQL
sleep 30

# Проверка состояния контейнеров
echo "Состояние контейнеров:"
sudo docker ps -a

# Проверка логов MySQL
echo "Логи MySQL:"
sudo docker logs shvirtd-example-python-db-1

# Проверка работы
echo "Приложение запущено. Проверьте его по адресу:"
curl -s ifconfig.me
echo ":8090"

