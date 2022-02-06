# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"

## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

Ошибки:
 - '/t` в конце не нужен
 - ip первого сервера указывается некорректно
 - ip второго отсутствуют ковычки
 - табуляция нарушена
 - отсутсвует запятая

Исправленный json:
```json
{    
    "info" : "Sample JSON output from our service",
    "elements" :[
        {
            "name" : "first",
            "type" : "server",
            "ip" : "71.75.x.x" 
        },
        { 
            "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
        }
    ]
}
```

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
import time
import json
import yaml

srv = {'drive.google.com':'', 'mail.google.com':'', 'google.com':''}

print('start script')

while True:
    for host in srv:
        ip = socket.gethostbyname(host)
        if ip != srv[host] :
            if srv[host] != '' :
                print(f'[ERROR] {host} IP mismatch: {srv[host]} {ip}') 
            srv[host] = ip
        with open('services.yaml', 'w') as yml:
            yml.write(yaml.dump(srv, indent=2, explicit_end=True, explicit_start=True))
        with open('services.json', 'w') as js:
            js.write(json.dumps(srv, indent=2))
    time.sleep(2)
```
### Вывод скрипта при запуске при тестировании:
```
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology)-[git://baabd0b ✗]-
└> python3 script.py 
start script
[ERROR] google.com IP mismatch: 64.233.162.101 64.233.162.138
[ERROR] google.com IP mismatch: 64.233.162.138 142.250.150.100
[ERROR] google.com IP mismatch: 142.250.150.100 142.250.150.101
[ERROR] google.com IP mismatch: 142.250.150.101 173.194.221.138
[ERROR] google.com IP mismatch: 173.194.221.138 173.194.221.102
[ERROR] mail.google.com IP mismatch: 142.250.74.133 142.250.74.101
[ERROR] drive.google.com IP mismatch: 142.250.74.46 74.125.205.139
[ERROR] drive.google.com IP mismatch: 74.125.205.139 74.125.205.113
[ERROR] drive.google.com IP mismatch: 74.125.205.113 142.250.74.46
[ERROR] google.com IP mismatch: 173.194.221.102 64.233.162.138
[ERROR] google.com IP mismatch: 64.233.162.138 64.233.162.101
[ERROR] google.com IP mismatch: 64.233.162.101 142.250.74.142
[ERROR] mail.google.com IP mismatch: 142.250.74.101 74.125.131.18
[ERROR] drive.google.com IP mismatch: 142.250.74.46 74.125.205.100
[ERROR] drive.google.com IP mismatch: 74.125.205.100 74.125.205.139
[ERROR] mail.google.com IP mismatch: 74.125.131.18 108.177.14.17
[ERROR] mail.google.com IP mismatch: 108.177.14.17 142.251.1.83
[ERROR] google.com IP mismatch: 142.250.74.142 209.85.233.100
[ERROR] google.com IP mismatch: 209.85.233.100 209.85.233.138
[ERROR] drive.google.com IP mismatch: 74.125.205.139 64.233.165.139
[ERROR] drive.google.com IP mismatch: 64.233.165.139 64.233.165.113
[ERROR] mail.google.com IP mismatch: 142.251.1.83 142.250.74.101
[ERROR] google.com IP mismatch: 209.85.233.138 142.250.74.142
[ERROR] drive.google.com IP mismatch: 64.233.165.113 74.125.205.102
[ERROR] drive.google.com IP mismatch: 74.125.205.102 74.125.205.139
[ERROR] drive.google.com IP mismatch: 74.125.205.139 142.251.1.100
[ERROR] drive.google.com IP mismatch: 142.251.1.100 142.251.1.138
[ERROR] google.com IP mismatch: 142.250.74.142 209.85.233.113
[ERROR] google.com IP mismatch: 209.85.233.113 209.85.233.100
[ERROR] drive.google.com IP mismatch: 142.251.1.138 74.125.205.100
[ERROR] drive.google.com IP mismatch: 74.125.205.100 74.125.205.139
[ERROR] drive.google.com IP mismatch: 74.125.205.139 142.250.74.46
[ERROR] google.com IP mismatch: 209.85.233.100 142.250.74.142
[ERROR] google.com IP mismatch: 142.250.74.142 142.251.1.113
[ERROR] google.com IP mismatch: 142.251.1.113 142.251.1.139
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{
  "drive.google.com": "142.250.74.46",
  "mail.google.com": "142.250.74.101",
  "google.com": "142.251.1.139"
}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
---
drive.google.com: 142.250.74.46
google.com: 142.251.1.139
mail.google.com: 142.250.74.101
...
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

### Ваш скрипт:
```python
???
```

### Пример работы скрипта:
???










