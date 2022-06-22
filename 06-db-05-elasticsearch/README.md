# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
- ссылку на образ в репозитории dockerhub
- ответ `elasticsearch` на запрос пути `/` в json виде

Подсказки:
- возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения

Далее мы будем работать с данным экземпляром elasticsearch.

### Ответ:

- [Dockerfile](./docker/Dockerfile), [docker-compose.yml](./docker/docker-compose.yml) и [конфиг эластика](./docker/elasticsearch.yml)
- [Образ в Docker-hub](https://hub.docker.com/r/surtsov/centos7-elasticsearch)
-  ответ `elasticsearch` на запрос пути `/` в json виде:
```
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl http://localhost:9200
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "4qrwCaecT22Ipu3vjjlEQw",
  "version" : {
    "number" : "8.2.3",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "9905bfb62a3f0b044948376b4f607f70a8a151b4",
    "build_date" : "2022-06-08T22:21:36.455508792Z",
    "build_snapshot" : false,
    "lucene_version" : "9.1.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

## Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

Получите состояние кластера `elasticsearch`, используя API.

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

Удалите все индексы.

**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

### Ответ

- Добавляем индексы:

```
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X PUT localhost:9200/ind-1 -H 'Content-Type: application/json' -d' {"settings": {"index": {"number_of_shards": 1, "number_of_replicas": 0}}}, {"acknowledged" : true, "shards_acknowledged" : true, "index" : "ind-1"}'
elasticsearch    | [2022-06-22T09:42:01,865][INFO ][o.e.c.m.MetadataCreateIndexService] [netology_test] [ind-1] creating index, cause [api], templates [], shards [1]/[0]
elasticsearch    | [2022-06-22T09:42:02,670][INFO ][o.e.c.r.a.AllocationService] [netology_test] current.health="GREEN" message="Cluster health status changed from [YELLOW] to [GREEN] (reason: [shards started [[ind-1][0]]])." previous.health="YELLOW" reason="shards started [[ind-1][0]]"
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-1"}%                                                                                                                                                                                                                        
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X PUT localhost:9200/ind-2 -H 'Content-Type: application/json' -d'{"settings": {"index": {"number_of_shards": 2, "number_of_replicas": 1}}}, {"acknowledged" : true, "shards_acknowledged" : true, "index" : "ind-2"}'
elasticsearch    | [2022-06-22T09:42:45,641][INFO ][o.e.c.m.MetadataCreateIndexService] [netology_test] [ind-2] creating index, cause [api], templates [], shards [2]/[1]
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-2"}%                                                                                                                                                                                                                        
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X PUT localhost:9200/ind-3 -H 'Content-Type: application/json' -d'{"settings": {"index": {"number_of_shards": 4, "number_of_replicas": 2}}}, {"acknowledged" : true, "shards_acknowledged" : true, "index" : "ind-3"}'
elasticsearch    | [2022-06-22T09:43:03,266][INFO ][o.e.c.m.MetadataCreateIndexService] [netology_test] [ind-3] creating index, cause [api], templates [], shards [4]/[2]
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-3"}%
```

- Получаем список индексов и их статусов, используя API:

```
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X GET localhost:9200/_cat/indices    

yellow open ind-3 Dz5FdsnoR46hczZ_rJZ2rA 4 2 0 0 900b 900b
green  open ind-1 I1otZwEOQeKpe90jon_nsQ 1 0 0 0 225b 225b
yellow open ind-2 PIBCMB5jQ0CirivhEmk1JA 2 1 0 0 450b 450b
```

- Получаем состояние кластера:

```
curl -X GET 'localhost:9200/_cluster/health?pretty'
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 8,
  "active_shards" : 8,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 44.44444444444444
}
```

- Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

    Индексы 2 и 3 имеет состояние **yellow** так как указано количество реплик 1 и 2 соответственно, а реплик нет.
    Кластер в состоянии **yellow** так как индексы в **yellow**.

- Удаляем все индексы:

```
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X DELETE localhost:9200/ind-1  
elasticsearch    | [2022-06-22T09:51:46,964][INFO ][o.e.c.m.MetadataDeleteIndexService] [netology_test] [ind-1/I1otZwEOQeKpe90jon_nsQ] deleting index
{"acknowledged":true}%                                                                                                                                                                                                                                                                   
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X DELETE localhost:9200/ind-2
elasticsearch    | [2022-06-22T09:51:49,178][INFO ][o.e.c.m.MetadataDeleteIndexService] [netology_test] [ind-2/PIBCMB5jQ0CirivhEmk1JA] deleting index
{"acknowledged":true}%                                                                                                                                                                                                                                                                   
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X DELETE localhost:9200/ind-3
elasticsearch    | [2022-06-22T09:51:50,786][INFO ][o.e.c.m.MetadataDeleteIndexService] [netology_test] [ind-3/Dz5FdsnoR46hczZ_rJZ2rA] deleting index
{"acknowledged":true}% 
```

## Задача 3

В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`ами.

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

Подсказки:
- возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch`

### Решение

- Регистрируем директорию как `snapshot repository` c именем `netology_backup`:

```
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X PUT localhost:9200/_snapshot/netology_backup -H 'Content-Type: application/json' -d '{"type": "fs", "settings": {"location": "/opt/elasticsearch-8.2.3/snapshots"}}{"acknowledged" : true}'
{"acknowledged":true}% 
```

- Получаем информацию о репозитории:

```
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X GET 'localhost:9200/_snapshot/netology_backup?pretty'
{
  "netology_backup" : {
    "type" : "fs",
    "settings" : {
      "location" : "/opt/elasticsearch-8.2.3/snapshots"
    }
  }
}
```

- Создаем индекс `test` с 0 реплик и 1 шардом:
```
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X PUT localhost:9200/test -H 'Content-Type: application/json' -d '{"settings": {"index": {"number_of_shards": 1, "number_of_replicas": 0}}}{"acknowledged" : true, "shards_acknowledged" : true, "index" : "test"}'
{"acknowledged":true,"shards_acknowledged":true,"index":"test"}%                                                                                                                                                                                                                         
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X GET localhost:9200/_cat/indices
green open test MnKpaTAeTmWOryp7vF3qWQ 1 0 0 0 225b 225b
```

- Создаем снапшот:
```
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X PUT localhost:9200/_snapshot/netology_backup/snapshot1
{"accepted":true}% 
```

- Удаляем **test** и добавляем **test2**:

```
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X DELETE localhost:9200/test
{"acknowledged":true}%   
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X PUT localhost:9200/test-2 -H 'Content-Type: application/json' -d '{"settings": {"index": {"number_of_shards": 1, "number_of_replicas": 0}}}{"acknowledged" : true, "shards_acknowledged" : true, "index" : "test-2"}'
{"acknowledged":true,"shards_acknowledged":true,"index":"test-2"}%
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X GET localhost:9200/_cat/indices
green open test-2 9K5mIQynSNSTbSMxcYy2ZQ 1 0 0 0 225b 225b
```

- Восстанавливаем данные и снапшота:
```
curl -X POST localhost:9200/_snapshot/netology_backup/snapshot1/_restore?pretty -H 'Content-Type: application/json' -d '{"indices": "*", "include_global_state": true}{"accepted" : true}'
┌[vladimir☮ubuntu]-(~/devops-netology/06-db-05-elasticsearch/docker)-[git://master ✗]-
└> curl -X GET localhost:9200/_cat/indices
green open test-2 9K5mIQynSNSTbSMxcYy2ZQ 1 0 0 0 225b 225b
green open test   P0c8QUDdT4eFqkU2ywTAlw 1 0 0 0 225b 225b
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---