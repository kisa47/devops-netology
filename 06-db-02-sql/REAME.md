# Домашнее задание к занятию "6.2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

### Ответ

[docker compose файл](docker/docker-compose.yml) для поднятия контейнера с БД и контейнера для восстановлия БД из резервной копии.

Листинг команд:
```
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-02-sql/docker)-[git://master ✗]-
└> docker-compose up
Starting postgres12     ... done
Starting postgres12-bak ... done
Attaching to postgres12-bak, postgres12
postgres12        | 
postgres12        | PostgreSQL Database directory appears to contain a database; Skipping initialization
postgres12        | 
postgres12-bak    | 
postgres12-bak    | PostgreSQL Database directory appears to contain a database; Skipping initialization
postgres12-bak    | 
postgres12-bak    | 2022-06-01 17:43:03.802 UTC [1] LOG:  starting PostgreSQL 12.11 (Debian 12.11-1.pgdg110+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 10.2.1-6) 10.2.1 20210110, 64-bit
postgres12-bak    | 2022-06-01 17:43:03.802 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
postgres12-bak    | 2022-06-01 17:43:03.803 UTC [1] LOG:  listening on IPv6 address "::", port 5432
postgres12-bak    | 2022-06-01 17:43:03.910 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
postgres12        | 2022-06-01 17:43:03.894 UTC [1] LOG:  starting PostgreSQL 12.11 (Debian 12.11-1.pgdg110+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 10.2.1-6) 10.2.1 20210110, 64-bit
postgres12        | 2022-06-01 17:43:03.894 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
postgres12        | 2022-06-01 17:43:03.895 UTC [1] LOG:  listening on IPv6 address "::", port 5432
postgres12        | 2022-06-01 17:43:03.988 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
postgres12        | 2022-06-01 17:43:04.027 UTC [26] LOG:  database system was shut down at 2022-06-01 17:42:43 UTC
postgres12        | 2022-06-01 17:43:04.038 UTC [1] LOG:  database system is ready to accept connections
postgres12-bak    | 2022-06-01 17:43:04.108 UTC [26] LOG:  database system was shut down at 2022-06-01 17:42:43 UTC
postgres12-bak    | 2022-06-01 17:43:04.156 UTC [1] LOG:  database system is ready to accept connections
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-02-sql/docker)-[git://master ✗]-
└> docker ps -a
CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS                      PORTS      NAMES
2ee7040c91b3   postgres:12-bullseye   "docker-entrypoint.s…"   2 minutes ago   Up About a minute           5432/tcp   postgres12-bak
2bb3d7900f06   postgres:12-bullseye   "docker-entrypoint.s…"   4 minutes ago   Up About a minute           5432/tcp   postgres12

```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db

### Ответ

- итоговый список БД после выполнения пунктов выше:
```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
(4 rows)

```
- описание таблиц (describe):
```
test_db=# \d orders
 order_id | integer |           | not null | nextval('orders_order_id_seq'::regclass)
 name     | text    |           |          | 
 price    | integer |           |          | 

test_db=# \d clients
 client_id | integer |           | not null | nextval('clients_client_id_seq'::regclass)
 last_name | text    |           |          | 
 country   | text    |           |          | 
 order_id  | integer |           |          |

```
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db:
```
SELECT table_name, grantee, privilege_type FROM information_schema.role_table_grants WHERE table_name IN ('clients', 'orders') AND grantee <> 'postgres';
```
- список пользователей с правами над таблицами test_db
```
test_db=# SELECT table_name, grantee, privilege_type FROM information_schema.role_table_grants WHERE table_name IN ('clients', 'orders') AND grantee <> 'postgres';
 clients    | test_admin_user  | INSERT
 clients    | test_admin_user  | SELECT
 clients    | test_admin_user  | UPDATE
 clients    | test_admin_user  | DELETE
 clients    | test_admin_user  | TRUNCATE
 clients    | test_admin_user  | REFERENCES
 clients    | test_admin_user  | TRIGGER
 clients    | test_simple_user | INSERT
 clients    | test_simple_user | SELECT
 clients    | test_simple_user | UPDATE
 clients    | test_simple_user | DELETE
 orders     | test_simple_user | INSERT
 orders     | test_simple_user | SELECT
 orders     | test_simple_user | UPDATE
 orders     | test_simple_user | DELETE
 orders     | test_admin_user  | INSERT
 orders     | test_admin_user  | SELECT
 orders     | test_admin_user  | UPDATE
 orders     | test_admin_user  | DELETE
 orders     | test_admin_user  | TRUNCATE
 orders     | test_admin_user  | REFERENCES
 orders     | test_admin_user  | TRIGGER
```
- Листинг команд:

```
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-02-sql/docker)-[git://master ✗]-
└> docker exec -it postgres12 /bin/bash

root@2bb3d7900f06:/# su - postgres
postgres@2bb3d7900f06:~$ psql
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

postgres=# CREATE USER test_admin_user LOGIN;
CREATE ROLE

postgres=# CREATE DATABASE test_db;
CREATE DATABASE

postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
(4 rows)

postgres=# 
\q
postgres@2bb3d7900f06:~$ psql test_db
psql (12.11 (Debian 12.11-1.pgdg110+1))
Type "help" for help.

test_db=# CREATE TABLE clients (client_id serial primary key, last_name text, country text, order_id  int);
CREATE TABLE
test_db=# CREATE TABLE orders (order_id serial primary key, name text, price int );
CREATE TABLE
test_db=# \d orders
 order_id | integer |           | not null | nextval('orders_order_id_seq'::regclass)
 name     | text    |           |          | 
 price    | integer |           |          | 

test_db=# \d clients
 client_id | integer |           | not null | nextval('clients_client_id_seq'::regclass)
 last_name | text    |           |          | 
 country   | text    |           |          | 
 order_id  | integer |           |          | 


test_db=# CREATE USER test_simple_user LOGIN;
test_db=# GRANT ALL PRIVILEGES ON  DATABASE test_db TO test_admin_user;
GRANT
test_db=# GRANT SELECT, INSERT, UPDATE, DELETE ON orders TO test_simple_user;
GRANT
test_db=# GRANT SELECT, INSERT, UPDATE, DELETE ON clients TO test_simple_user;
GRANT
test_db=#
test_db=# SELECT table_name, grantee, privilege_type FROM information_schema.role_table_grants WHERE table_name IN ('clients', 'orders') AND grantee <> 'postgres';
 clients    | test_admin_user  | INSERT
 clients    | test_admin_user  | SELECT
 clients    | test_admin_user  | UPDATE
 clients    | test_admin_user  | DELETE
 clients    | test_admin_user  | TRUNCATE
 clients    | test_admin_user  | REFERENCES
 clients    | test_admin_user  | TRIGGER
 clients    | test_simple_user | INSERT
 clients    | test_simple_user | SELECT
 clients    | test_simple_user | UPDATE
 clients    | test_simple_user | DELETE
 orders     | test_simple_user | INSERT
 orders     | test_simple_user | SELECT
 orders     | test_simple_user | UPDATE
 orders     | test_simple_user | DELETE
 orders     | test_admin_user  | INSERT
 orders     | test_admin_user  | SELECT
 orders     | test_admin_user  | UPDATE
 orders     | test_admin_user  | DELETE
 orders     | test_admin_user  | TRUNCATE
 orders     | test_admin_user  | REFERENCES
 orders     | test_admin_user  | TRIGGER
test_db=# INSERT INTO orders (name, price) VALUES ('chocolate', 10);
INSERT 0 1
test_db=# SELECT * FROM orders;
        1 | chocolate |    10

test_db=# INSERT INTO orders (name, price) VALUES ('printer', 3000);
INSERT 0 1
test_db=# INSERT INTO orders (name, price) VALUES ('book', 500);
INSERT 0 1
test_db=# INSERT INTO orders (name, price) VALUES ('monitor', 7000);
INSERT 0 1
test_db=# INSERT INTO orders (name, price) VALUES ('guitar', 4000);
INSERT 0 1
test_db=# SELECT * FROM orders;
        1 | chocolate |    10
        2 | printer   |  3000
        3 | book      |   500
        4 | monitor   |  7000
        5 | guitar    |  4000

test_db=#
```
## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

### Ответ:

Листинг команд:
```
test_db=# BEGIN;
BEGIN
test_db=# INSERT INTO orders (name, price) VALUES ('chocolate', 10);
INSERT 0 1
test_db=# SELECT * FROM orders;
        1 | chocolate |    10

test_db=# INSERT INTO orders (name, price) VALUES ('printer', 3000);
INSERT 0 1
test_db=# INSERT INTO orders (name, price) VALUES ('book', 500);
INSERT 0 1
test_db=# INSERT INTO orders (name, price) VALUES ('monitor', 7000);
INSERT 0 1
test_db=# INSERT INTO orders (name, price) VALUES ('guitar', 4000);
INSERT 0 1
test_db=# COMMIT;
test_db=# SELECT * FROM orders;
        1 | chocolate |    10
        2 | printer   |  3000
        3 | book      |   500
        4 | monitor   |  7000
        5 | guitar    |  4000

test_db=# INSERT INTO clients (last_name, country) VALUES ('Ivanov Ivan Ivanovich', 'USA');
INSERT 0 1
test_db=# INSERT INTO clients (last_name, country) VALUES ('Petrov Petr Petrovich', 'Canada');
INSERT 0 1
test_db=# INSERT INTO clients (last_name, country) VALUES ('Iogann Sebastyan Bax', 'Japan');
INSERT 0 1
test_db=# INSERT INTO clients (last_name, country) VALUES ('Ronni James Dio', 'Russia');
INSERT 0 1
test_db=# INSERT INTO clients (last_name, country) VALUES ('Rithcie Blackmore', 'Russia');
INSERT 0 1
test_db=# SELECT * FROM clients;
         1 | Ivanov Ivan Ivanovich | USA     |         
         2 | Petrov Petr Petrovich | Canada  |         
         3 | Iogann Sebastyan Bax  | Japan   |         
         4 | Ronni James Dio       | Russia  |         
         5 | Rithcie Blackmore     | Russia  |     

test_db=# SELECT count(*) FROM orders;
     5

test_db=# SELECT count(*) FROM clients;
     5
```

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.

### Ответ:
```
test_db=# BEGIN;
BEGIN
test_db=# UPDATE clients SET order_id = (SELECT order_id FROM orders WHERE name = 'book') WHERE client_id = (SELECT client_id FROM clients WHERE last_name = 'Ivanov Ivan Ivanovich');
UPDATE 1
test_db=# COMMIT;
COMMIT
test_db=# BEGIN;
BEGIN
test_db=# UPDATE clients SET order_id = (SELECT order_id FROM orders WHERE name = 'monitor') WHERE client_id = (SELECT client_id FROM clients WHERE last_name = 'Petrov Petr Petrovich');
UPDATE 1
test_db=# COMMIT;
COMMIT
test_db=# BEGIN;
BEGIN
test_db=# UPDATE clients SET order_id = (SELECT order_id FROM orders WHERE name = 'guitar') WHERE client_id = (SELECT client_id FROM clients WHERE last_name = 'Iogann Sebastyan Bax');
UPDATE 1
test_db=# COMMIT;
COMMIT
test_db=# SELECT * FROM clients;
         4 | Ronni James Dio       | Russia  |         
         5 | Rithcie Blackmore     | Russia  |         
         1 | Ivanov Ivan Ivanovich | USA     |        3
         2 | Petrov Petr Petrovich | Canada  |        4
         3 | Iogann Sebastyan Bax  | Japan   |        5

test_db=# SELECT c.last_name, o.name FROM clients c INNER JOIN orders o ON o.order_id = c.order_id;
 Ivanov Ivan Ivanovich | book
 Petrov Petr Petrovich | monitor
 Iogann Sebastyan Bax  | guitar

test_db=# 
```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

### Ответ

```
test_db=# EXPLAIN SELECT c.last_name, o.name FROM clients c INNER JOIN orders o ON o.order_id = c.order_id;
 Hash Join  (cost=37.00..57.24 rows=810 width=64)
   Hash Cond: (c.order_id = o.order_id)
   ->  Seq Scan on clients c  (cost=0.00..18.10 rows=810 width=36)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=36)
         ->  Seq Scan on orders o  (cost=0.00..22.00 rows=1200 width=36)
```



- **Hash Join** соединение по хешу, при котором строки таблицы **orders** записываются в хеш-таблицу в памяти (**Hash**), после чего сканируется таблица **clients** и для каждой её строки проверяется соответствие (**Hash Cond**) по хеш-таблице. Приблизительная условная "стоимость" запуска операции 37.00, приблизительная стоимость выполнения операции до конца 57.24, rows=810 - ожидаемое количество обработанных строк, width ожидаемая длина строк;
- **Hash Cond** (условие сравнения)
- **Seq Scan** последовательное сканирование строк таблицы **clients**, запуск 0.00, выполнение 18.10, предположительно обработает 810 строк, с предположительной длиной 36;
- **Hash** создание хеш таблицы, которая будет использована в **Hash Join**, на основе сканирования **Seq Scan** таблицы **orders**.
- **Seq Scan** последовательное сканирование строк таблицы **orders**, запуск 0.00, выполнение 22, предположительно обработает 1200 строк, с предположительной длиной 36.

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

### Ответ:

В официальных контейнерах postgres нет возможности остановить postgres без остановки контейнера, поэтому восстановление БД из копии созданной таким путем ```pg_basebackup -D /var/lib/postgresql/backup/ -F tar``` невозможно. В качестве доступного способа был выбран способ с дампом БД.

```
postgres@2bb3d7900f06:~$ pg_dump -W test_db > backup/test_db.sq;
Password: 
postgres@2bb3d7900f06:~$
┌[vladimir☮ubuntu]-(~)
└> docker stop postgres12
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-02-sql/docker)-[git://master ✗]-
└> docker exec -it postgres12-bak /bin/bash
root@2ee7040c91b3:/# su - postgres
postgres@2ee7040c91b3:~$ psql
postgres=# create database test_db;
CREATE DATABASE
postgres=# CREATE USER test_admin_user LOGIN;
CREATE ROLE
postgres=# CREATE USER test_simple_user LOGIN;
CREATE ROLE
postgres=# 
\q
postgres@2ee7040c91b3:~$ psql  test_db < backup/test_db.sq 
SET
SET
SET
SET
SET
 set_config 
------------
 
(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
ALTER TABLE
COPY 5
COPY 5
 setval 
--------
      5
(1 row)

 setval 
--------
      5
(1 row)

ALTER TABLE
ALTER TABLE
GRANT
GRANT
GRANT
GRANT
postgres@2ee7040c91b3:~$ psql -U postgres test_db -c "select * from clients;"
 client_id |       last_name       | country | order_id 
-----------+-----------------------+---------+----------
         4 | Ronni James Dio       | Russia  |         
         5 | Rithcie Blackmore     | Russia  |         
         1 | Ivanov Ivan Ivanovich | USA     |        3
         2 | Petrov Petr Petrovich | Canada  |        4
         3 | Iogann Sebastyan Bax  | Japan   |        5
(5 rows)

postgres@2ee7040c91b3:~$ 
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---