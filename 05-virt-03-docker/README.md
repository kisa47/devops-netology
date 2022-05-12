
# Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате Slack.

---

## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

### Ответ

Ссылка на форк: https://hub.docker.com/r/surtsov/webserver-netology

[Dockerfile](docker/Dockerfile)

Листинг команд:
```
┌[vladimir☮ubuntu]-(~/devops-netology/05-virt-03-docker/docker)-[git://master ✗]-
└> sudo docker build -t webserver-netology .
Sending build context to Docker daemon  3.072kB
Step 1/4 : FROM nginx:latest
 ---> 7425d3a7c478
Step 2/4 : MAINTAINER Vladimir Surtsov <v.surtsov@gmail.com>
 ---> Running in 6efea529f960
Removing intermediate container 6efea529f960
 ---> 9c74e9260383
Step 3/4 : ENV TZ=Europe/Moscow
 ---> Running in 34a8ee16b868
Removing intermediate container 34a8ee16b868
 ---> 3121dfab6f43
Step 4/4 : COPY ./index.html /usr/share/nginx/html/index.html
 ---> 2a84a181e91d
Successfully built 2a84a181e91d
Successfully tagged webserver-netology:latest
┌[vladimir☮ubuntu]-(~/devops-netology/05-virt-03-docker/docker)-[git://master ✗]-
└> sudo docker image tag webserver-netology surtsov/webserver-netology:latest
┌[vladimir☮ubuntu]-(~/devops-netology/05-virt-03-docker/docker)-[git://master ✗]-
└> sudo docker image push surtsov/webserver-netology:latest
The push refers to repository [docker.io/surtsov/webserver-netology]
984212e1ee37: Pushed 
feb57d363211: Mounted from library/nginx 
98c84706d0f7: Mounted from library/nginx 
4311f0ea1a86: Mounted from library/nginx 
6d049f642241: Mounted from library/nginx 
3158f7304641: Mounted from library/nginx 
fd95118eade9: Mounted from library/nginx 
latest: digest: sha256:b49821824e9e06335d46b463ffc47653b095cae50a9ab581283e6a606e95f344 size: 1777
```

## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- Высоконагруженное монолитное java веб-приложение;
- Nodejs веб-приложение;
- Мобильное приложение c версиями для Android и iOS;
- Шина данных на базе Apache Kafka;
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
- Мониторинг-стек на базе Prometheus и Grafana;
- MongoDB, как основное хранилище данных для java-приложения;
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

### Ответ

- Высоконагруженное монолитное java веб-приложение: контейнер хорошо подходит для распространения и развёртывания приложений в проде.
- Nodejs веб-приложение: таже контейнер удобен для развёртывания в проде + можно перед также в контейнере поставить балансировщик с tls и рядом бд.
- Мобильное приложение c версиями для Android и iOS: только виртуализация или физические устройства. Автотесты можно и в вм.
- Шина данных на базе Apache Kafka: можно как в контейнере так и в ВМ. Контейнер предпочтительнее за счет меньшей утилизации ресурсов.
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения: три ноды elasticsearch, два logstash и две ноды kibana: контейнеры вполне подойдут, при условии elasticsearch - stateful.
- Мониторинг-стек на базе Prometheus и Grafana: веб-приложения, поэтому контейнер.
- MongoDB, как основное хранилище данных для java-приложения: контейнер stateful.
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry:контейнера более чем подходят, только в принципе для Gitlab CI/CD можно использовать runer в ВМ с высокой доступностью, но и в runer в контейнере вполне может существовать если не нужны привилегированные контейнеры.

## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

### Ответ

Ссылка на [директорию](./data)

Листинг команд:
```
┌[vladimir☮ubuntu]-(~/devops-netology/05-virt-03-docker)-[git://master ✗]-
└> sudo docker run -v ~/devops-netology/05-virt-03-docker/data:/data -t -d --name my_centos centos:latest
Unable to find image 'centos:latest' locally
latest: Pulling from library/centos
a1d0c7532777: Pull complete 
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
57270ead04933e3be4a209ba2d2cda495ab8f0c6b8b14db4fed58d70176498b1
┌[vladimir☮ubuntu]-(~/devops-netology/05-virt-03-docker)-[git://master ✗]-
└> sudo docker run -v ~/devops-netology/05-virt-03-docker/data:/data -t -d --name my_debian debian:latest
23fb57feec3f83c79f2b15c54a6de48c14a44b017e93039d6c0607b25cd8bf34
┌[vladimir☮ubuntu]-(~/devops-netology/05-virt-03-docker)-[git://master ✗]-
└> sudo docker exec -it my_centos /bin/bash
[root@57270ead0493 /]# ls 
bin  data  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
[root@57270ead0493 /]# echo "Текст любого содержания в /data" >> /data/text_from_centos
[root@57270ead0493 /]# ls /data
text_from_centos
[root@57270ead0493 /]# exit
┌[vladimir☮ubuntu]-(~/devops-netology/05-virt-03-docker)-[git://master ✗]-
└> echo "Еще один файл с любым содержанием" >> data/text_from_host
┌[vladimir☮ubuntu]-(~/devops-netology/05-virt-03-docker)-[git://master ✗]-
└> sudo docker exec -it my_debian /bin/bash                       
root@23fb57feec3f:/# ls /data
text_from_centos  text_from_host
root@23fb57feec3f:/# echo /data/*
/data/text_from_centos /data/text_from_host
root@23fb57feec3f:/# cat /data/*
Текст любого содержания в /data Ю
Еще один файл с любым содержанием
root@23fb57feec3f:/# 
```

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

### Ответ

[Ссылка](https://hub.docker.com/r/surtsov/ansible)
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---