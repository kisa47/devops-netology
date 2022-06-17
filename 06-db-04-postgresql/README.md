# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql

### Ответ

- вывода списка БД ```\l[+]   [PATTERN]      list databases```
- подключения к БД ```\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo} connect to new database (currently "postgres")```
- вывода списка таблиц ```\d[S+]                 list tables, views, and sequences``` 
- вывода описания содержимого таблиц ``` \d[S+]  NAME           describe table, view, sequence, or index ```
- выхода из psql ```\q                     quit psql```

### Решение

- Поднимем контейнер из [манифеста](docker/docker-compose.yml) командой ```docker-compose up &```
- вызываем подсказку по командам:
```
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-04-postgresql/docker)-[git://master ✗]-
└> docker exec -it psql psql -U postgres
psql (13.7 (Debian 13.7-1.pgdg110+1))
Type "help" for help.

postgres=# \?
General
  \copyright             show PostgreSQL usage and distribution terms
  \crosstabview [COLUMNS] execute query and display results in crosstab
  \errverbose            show most recent error message at maximum verbosity
  \g [(OPTIONS)] [FILE]  execute query (and send results to file or |pipe);
                         \g with no arguments is equivalent to a semicolon
```


## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

### Ответ

```
test_database=# WITH t AS (
SELECT tablename, avg_width FROM pg_stats WHERE tablename = 'orders'
)
SELECT * FROM t
WHERE avg_width = (SELECT MAX(avg_width) FROM t)
;
 tablename | avg_width 
-----------+-----------
 orders    |        16
(1 row)
```

### Решение

- Создаем БД **test_database**:
```
template1=# CREATE DATABASE test_database;
CREATE DATABASE
```
- Восстанавливаем из бекапа:
```
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-04-postgresql/docker)-[git://master ✗]-
└> docker exec -it psql /bin/bash          
root@0c20326870b2:/# su postgres
postgres@0c20326870b2:/$ psql test_database < /var/lib/postgresql-backup/test_dump.sql 
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
ALTER TABLE
COPY 8
 setval 
--------
      8
(1 row)

ALTER TABLE
```
- проверяем результат:
```
postgres=# \c test_database ;
You are now connected to database "test_database" as user "postgres".
test_database=# \d
              List of relations
 Schema |     Name      |   Type   |  Owner   
--------+---------------+----------+----------
 public | orders        | table    | postgres
 public | orders_id_seq | sequence | postgres
(2 rows)
```

- Собираем статистику:
```
test_database=# ANALYZE public.orders;
ANALYZE
```
- Получаем столбец таблицы `orders` с наибольшим средним значением размера элементов в байтах.

```
test_database=# WITH t AS (
SELECT tablename, avg_width FROM pg_stats WHERE tablename = 'orders'
)
SELECT * FROM t
WHERE avg_width = (SELECT MAX(avg_width) FROM t)
;
 tablename | avg_width 
-----------+-----------
 orders    |        16
(1 row)
```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

### Решение

- Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

Можно, если реализовать [Секционирование таблиц](https://postgrespro.ru/docs/postgresql/10/ddl-partitioning).


```
test_database=# CREATE TABLE orders_2 (CHECK (price <= 499)) INHERITS (orders);
CREATE TABLE
test_database=# CREATE TABLE orders_1 (CHECK (price > 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO orders_1 SELECT * FROM orders WHERE price > 499;
INSERT 0 3
test_database=# INSERT INTO orders_2 SELECT * FROM orders WHERE price <= 499;
INSERT 0 5
test_database=# SELECT * FROM orders_2;
 id |        title         | price 
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
(5 rows)

test_database=# SELECT * FROM orders_1;
 id |       title        | price 
----+--------------------+-------
  2 | My little database |   500
  6 | WAL never lies     |   900
  8 | Dbiezdmin          |   501
(3 rows)
```



## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

### Решение
```
root@0c20326870b2:/# pg_dump -U postgres test_database > /var/lib/postgresql-backup/psql_dump.sql
```

- Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

```
CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) UNIQUE NOT NULL,
    price integer DEFAULT 0
);
```
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---