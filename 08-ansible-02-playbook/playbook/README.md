# README.md

Playbook устанавливает на всех контейнерах JAVA определенной версии, далее устанавливает и настраивает Elastisearch и Kibana на соответствующих контейнерах docker. Для установки необходим proxy.

## VARS

#### JAVA
- **java_jdk_version** - версия
- **java_oracle_jdk_package** - архив

#### Elastisearch

- **elastic_version** - версия
- **elastic_home** - домашняя директория

### Kibana

- **kibana_version** - версия
- **kibana_home** - домашняя директория

## TAGS

- **elastic** - все связанное с Elasticsearch
- **kibana** - все связанное с Kibana
- **java** - все связанное с JAVA