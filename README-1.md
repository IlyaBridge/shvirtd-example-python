# Домашнее задание к занятию "`Практическое применение Docker`" - `Казначеев Илья`

### Инструкция к выполнению

1. Для выполнения заданий обязательно ознакомьтесь с [инструкцией](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD) по экономии облачных ресурсов. Это нужно, чтобы не расходовать средства, полученные в результате использования промокода.
3. **Своё решение к задачам оформите в вашем GitHub репозитории.**
4. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.
5. Сопроводите ответ необходимыми скриншотами.

---
## Примечание: Ознакомьтесь со схемой виртуального стенда [по ссылке](https://github.com/netology-code/shvirtd-example-python/blob/main/schema.pdf)
---
## Задача 0
1. Убедитесь что у вас НЕ(!) установлен ```docker-compose```, для этого получите следующую ошибку от команды ```docker-compose --version```
```
Command 'docker-compose' not found, but can be installed with:

sudo snap install docker          # version 24.0.5, or
sudo apt  install docker-compose  # version 1.25.0-1

See 'snap info docker' for additional versions.
```
В случае наличия установленного в системе ```docker-compose``` - удалите его.  
2. Убедитесь что у вас УСТАНОВЛЕН ```docker compose```(без тире) версии не менее v2.24.X, для это выполните команду ```docker compose version```  
###  **Своё решение к задачам оформите в вашем GitHub репозитории!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!**
---

## Задача 1
1. Сделайте в своем github пространстве fork [репозитория](https://github.com/netology-code/shvirtd-example-python/blob/main/README.md).
   Примечание: В связи с доработкой кода python приложения. Если вы уверены что задание выполнено вами верно, а код python приложения работает с ошибкой то используйте вместо main.py файл not_tested_main.py(просто измените CMD)
3. Создайте файл с именем ```Dockerfile.python``` для сборки данного проекта(для 3 задания изучите https://docs.docker.com/compose/compose-file/build/ ). Используйте базовый образ ```python:3.9-slim```. 
Обязательно используйте конструкцию ```COPY . .``` в Dockerfile. Не забудьте исключить ненужные в имадже файлы с помощью dockerignore. Протестируйте корректность сборки.  
4. (Необязательная часть, *) Изучите инструкцию в проекте и запустите web-приложение без использования docker в venv. (Mysql БД можно запустить в docker run).
5. (Необязательная часть, *) По образцу предоставленного python кода внесите в него исправление для управления названием используемой таблицы через ENV переменную.

### ВНИМАНИЕ!
!!! В процессе последующего выполнения ДЗ НЕ изменяйте содержимое файлов в fork-репозитории! Ваша задача ДОБАВИТЬ 5 файлов: ```Dockerfile.python```, ```compose.yaml```, ```.gitignore```, ```.dockerignore```,```bash-скрипт```. Если вам понадобилось внести иные изменения в проект - вы что-то делаете неверно!

### Решение 1

![00z500001-1 (Решение)](https://github.com/user-attachments/assets/6e025a11-c2d0-4493-a89c-b3bb82a7c3d1)

![00z500001-2 (Решение)](https://github.com/user-attachments/assets/c97734c9-552e-4ea1-a89b-3da881229949)

![00z500001-3 (Решение)](https://github.com/user-attachments/assets/92437b5d-b63b-4726-b38b-e9d22c0bd4bc)

![00z500001-4 (Решение)](https://github.com/user-attachments/assets/b05b6d64-a23d-468b-9eaa-1d36d117b5f3)

---

## Задача 2 (*)
1. Создайте в yandex cloud container registry с именем "test" с помощью "yc tool" . [Инструкция](https://cloud.yandex.ru/ru/docs/container-registry/quickstart/?from=int-console-help)
2. Настройте аутентификацию вашего локального docker в yandex container registry.
3. Соберите и залейте в него образ с python приложением из задания №1.
4. Просканируйте образ на уязвимости.
5. В качестве ответа приложите отчет сканирования.

### Решение 2

![00z500002-10 (отчет сканирования)](https://github.com/user-attachments/assets/eb537541-cb76-43e1-ad71-6ed8cf4093f2)

---

## Задача 3
1. Изучите файл "proxy.yaml"
2. Создайте в репозитории с проектом файл ```compose.yaml```. С помощью директивы "include" подключите к нему файл "proxy.yaml".
3. Опишите в файле ```compose.yaml``` следующие сервисы: 

- ```web```. Образ приложения должен ИЛИ собираться при запуске compose из файла ```Dockerfile.python``` ИЛИ скачиваться из yandex cloud container registry(из задание №2 со *). Контейнер должен работать в bridge-сети с названием ```backend``` и иметь фиксированный ipv4-адрес ```172.20.0.5```. Сервис должен всегда перезапускаться в случае ошибок.
Передайте необходимые ENV-переменные для подключения к Mysql базе данных по сетевому имени сервиса ```web``` 

- ```db```. image=mysql:8. Контейнер должен работать в bridge-сети с названием ```backend``` и иметь фиксированный ipv4-адрес ```172.20.0.10```. Явно перезапуск сервиса в случае ошибок. Передайте необходимые ENV-переменные для создания: пароля root пользователя, создания базы данных, пользователя и пароля для web-приложения.Обязательно используйте уже существующий .env file для назначения секретных ENV-переменных!

2. Запустите проект локально с помощью docker compose , добейтесь его стабильной работы: команда ```curl -L http://127.0.0.1:8090``` должна возвращать в качестве ответа время и локальный IP-адрес. Если сервисы не стартуют воспользуйтесь командами: ```docker ps -a ``` и ```docker logs <container_name>``` . Если вместо IP-адреса вы получаете ```NULL``` --убедитесь, что вы шлете запрос на порт ```8090```, а не 5000.

5. Подключитесь к БД mysql с помощью команды ```docker exec -ti <имя_контейнера> mysql -uroot -p<пароль root-пользователя>```(обратите внимание что между ключем -u и логином root нет пробела. это важно!!! тоже самое с паролем) . Введите последовательно команды (не забываем в конце символ ; ): ```show databases; use <имя вашей базы данных(по-умолчанию example)>; show tables; SELECT * from requests LIMIT 10;```.

6. Остановите проект. В качестве ответа приложите скриншот sql-запроса.

### Решение 3

![00z500003-2 (Ответ)](https://github.com/user-attachments/assets/8d014ee5-7612-4165-be77-400c7c79ff53)

---

## Задача 4
1. Запустите в Yandex Cloud ВМ (вам хватит 2 Гб Ram).
2. Подключитесь к Вм по ssh и установите docker.
3. Напишите bash-скрипт, который скачает ваш fork-репозиторий в каталог /opt и запустит проект целиком.
4. Зайдите на сайт проверки http подключений, например(или аналогичный): ```https://check-host.net/check-http``` и запустите проверку вашего сервиса ```http://<внешний_IP-адрес_вашей_ВМ>:8090```. Таким образом трафик будет направлен в ingress-proxy. ПРИМЕЧАНИЕ:  приложение main.py( в отличие от not_tested_main.py) весьма вероятно упадет под нагрузкой, но успеет обработать часть запросов - этого достаточно. Обновленная версия (main.py) не прошла достаточного тестирования временем, но должна справиться с нагрузкой.
5. (Необязательная часть) Дополнительно настройте remote ssh context к вашему серверу. Отобразите список контекстов и результат удаленного выполнения ```docker ps -a```
6. В качестве ответа повторите  sql-запрос и приложите скриншот с данного сервера, bash-скрипт и ссылку на fork-репозиторий.

### Решение 4
Файл deploy.sh:
https://github.com/IlyaBridge/shvirtd-example-python/blob/main/task_4/deploy.sh

![Задача 4 ответ 0 ход выполнения команды Docker](https://github.com/user-attachments/assets/80879def-9289-4c9c-9510-c4be8b5b84d6)

![Задача 4 ответ 1 проверка работоспособности](https://github.com/user-attachments/assets/5d435e4a-ff71-44cc-abda-60c242adc5e6)

![Задача 4 ответ 2 check-host](https://github.com/user-attachments/assets/ff705b8a-53c0-4662-ab2d-6f9745337adf)

![Задача 4 ответ 3 проверка в браузере](https://github.com/user-attachments/assets/1c710a25-3423-477e-b2b3-1ed32566dc1e)

![Задача 4 ответ 4 MySQL](https://github.com/user-attachments/assets/e2116c6c-5858-4bd1-827d-976763b165fe)

---

## Задача 5 (*)
1. Напишите и задеплойте на вашу облачную ВМ bash скрипт, который произведет резервное копирование БД mysql в директорию "/opt/backup" с помощью запуска в сети "backend" контейнера из образа ```schnitzler/mysqldump``` при помощи ```docker run ...``` команды. Подсказка: "документация образа."
2. Протестируйте ручной запуск
3. Настройте выполнение скрипта раз в 1 минуту через cron, crontab или systemctl timer. Придумайте способ не светить логин/пароль в git!!
4. Предоставьте скрипт, cron-task и скриншот с несколькими резервными копиями в "/opt/backup"

---

## Задача 6
Скачайте docker образ ```hashicorp/terraform:latest``` и скопируйте бинарный файл ```/bin/terraform``` на свою локальную машину, используя dive и docker save.
Предоставьте скриншоты  действий .

### Решение 6
Скачивание образа Terraform
```
docker pull hashicorp/terraform:latest
docker images | grep terraform  
```
![006 0-0001](https://github.com/user-attachments/assets/eb9e4747-a3a0-46d7-a287-95987477a83c)

Сохранение образа в .tar-архив
```
docker save hashicorp/terraform:latest -o terraform.tar
ls -lh terraform.tar  
```
![006 0-0002](https://github.com/user-attachments/assets/743cef73-ec3f-4b0f-96b9-c8279a6e96d7)

Установка dive
```
wget https://github.com/wagoodman/dive/releases/download/v0.11.0/dive_0.11.0_linux_amd64.deb

sudo apt install ./dive_0.11.0_linux_amd64.deb

dive --version  
```

Анализ через dive
```
dive ./terraform.tar
```
![006 0-0003](https://github.com/user-attachments/assets/61e11f18-e38f-481d-b4fb-f3034eff7eea)
При попытке анализа образа через dive возникла ошибка:
Handler not available locally... invalid reference format

Извлечение файла terraform
Создаем директорию для распаковки
```
mkdir terraform && cd terraform
```

Распаковываем образ
```
tar -xf ../terraform.tar
```

Смотрим manifest.json
```
cat manifest.json
```
![006 0-0005 (Manifest)](https://github.com/user-attachments/assets/b102ba0d-f8d2-4602-94bc-5edec3130e52)

Переброр всех слоёв из manifest.json
```
# Переходим в директорию с blobs
cd blobs/sha256/

# Перебираем все слои из manifest.json
for layer in 08000c18d16dadf9553d747a58cf44023423a9ab010aab96cf263d2216b8b350 d37c201d602b7b9c29907060445ac3e59e815a4da90f6e74e94a29c04cdb7807 8bdcd40dd9a21bff31f8e91a12485a16af0054832fcea58fae09c22072ed294e e0f55b34ca5dc362ab5757d39045589d45aaa6ffe70a3bb2d88b2939592a5806; do
  echo "Проверяю слой $layer"
  mkdir -p temp_extract
  tar -xf "$layer" -C temp_extract
  if [ -f temp_extract/bin/terraform ]; then
    echo "Найден terraform в слое $layer"
    cp temp_extract/bin/terraform ../../terraform
    break
  fi
  rm -rf temp_extract
done

# Возвращаемся в исходную директорию
cd ../..

# Делаем terraform исполняемым
chmod +x terraform

# Проверяем версию
./terraform version
```
![006 0-0006-1 (Перебираем Слои)](https://github.com/user-attachments/assets/0a1751d6-7db6-4ff1-937a-77f53458f5e4)

---

## Задача 6.1
Добейтесь аналогичного результата, используя docker cp.  
Предоставьте скриншоты  действий .

### Решение 6.1
Создаем временный контейнер
```
docker create --name temp_terraform hashicorp/terraform:latest
```
![006 1-№0001](https://github.com/user-attachments/assets/1b43b761-41ed-4a25-bf83-aa9c0248a843)

Контейнер создан в остановленном состоянии
Копируем файл из контейнера
```
docker cp temp_terraform:/bin/terraform ./terraform
```
![006 1-№0002](https://github.com/user-attachments/assets/f819da4e-cf13-40af-9ac3-6ab97c8717ba)

Удаляем временный контейнер
```
docker rm temp_terraform
```
![006 1-№0003](https://github.com/user-attachments/assets/d7766860-2c8f-407d-86e8-2934fc4b0c2f)
контейнер удалён после копирования.

Делаем файл исполняемым
```
sudo chmod +x ./terraform
```
![006 1-№0004](https://github.com/user-attachments/assets/51268ca2-9910-40bd-8b32-eedc359772f5)

Проверяем
```
./terraform --version
```
![006 1-№0005](https://github.com/user-attachments/assets/3501d202-2fac-4772-ae02-332783653144)

Каталог, в котором находится бинарник
![006 1-№0006](https://github.com/user-attachments/assets/07dfda7a-ebc2-4365-b91b-5e4dba85cfc4)

---

## Задача 6.2 (**)
Предложите способ извлечь файл из контейнера, используя только команду docker build и любой Dockerfile.  
Предоставьте скриншоты  действий .

---

## Задача 7 (***)
Запустите ваше python-приложение с помощью runC, не используя docker или containerd.  
Предоставьте скриншоты  действий .

---
