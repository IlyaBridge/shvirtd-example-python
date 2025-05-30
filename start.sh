#!/bin/bash

# Загрузка переменных из .env
set -a
source .env
set +a

# Остановка и очистка
docker compose down -v --remove-orphans

# Запуск проекта
docker compose up -d --build

# Ожидание инициализации
echo "Ожидание запуска сервисов..."
sleep 15

# Проверка endpoint
echo "Тестирование endpoint:"
curl -v http://127.0.0.1:8090

# Проверка БД (используем правильный пароль из .env)
echo -e "\nПроверка базы данных:"
docker exec -i shvirtd-example-python-db-1 mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "
SHOW DATABASES;
USE $MYSQL_DATABASE;
SHOW TABLES;
SELECT * FROM requests LIMIT 10;
"
