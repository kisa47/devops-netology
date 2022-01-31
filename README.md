### Как сдавать задания

Вы уже изучили блок «Системы управления версиями», и начиная с этого занятия все ваши работы будут приниматься ссылками на .md-файлы, размещённые в вашем публичном репозитории.

Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-02-py/README.md). Заполните недостающие части документа решением задач (заменяйте `???`, ОСТАЛЬНОЕ В ШАБЛОНЕ НЕ ТРОГАЙТЕ чтобы не сломать форматирование текста, подсветку синтаксиса и прочее, иначе можно отправиться на доработку) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желани.

# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | Значение присвоено не будет, так как int и str нельзя применять сложение  |
| Как получить для переменной `c` значение 12?  | ```c = str(a) + b```  |
| Как получить для переменной `c` значение 3?  | ```c = a + int(b)```  |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/devops-netology", "git status -u -s"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find(' M ') != -1:
        prepare_result = result.replace(' M ', '~/devops-netology/')
        print(prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology)-[git://baabd0b ✗]-
└> git commit -m test 
[отделённый HEAD e3a7f22] test
 3 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 test/file
 create mode 100644 test/file1
 create mode 100644 test/file1M
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology)-[git://e3a7f22 ✗]-
└> echo "1" >> test/file*
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology)-[git://e3a7f22 ✗]-
└> git status -u -s      
 M README.md
 M test/file
 M test/file1
 M test/file1M
?? script.py
?? test.py
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology)-[git://e3a7f22 ✗]-
└> ./script.py           
~/devops-netology/README.md
~/devops-netology/test/file
~/devops-netology/test/file1
~/devops-netology/test/file1M
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology)-[git://e3a7f22 ✗]-
└> 
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys

try:
    dir = sys.argv[1]
except IndexError:
    dir = os.getcwd()

bash_command = ["cd " + dir, "git status -s -u"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find(' M ') != -1:
        count = result.count('../')
        file = dir
        if count > 0:
            new_dir = ''
            new_count = file.count('/') - count
            for patch in file.split('/'):
                new_dir = new_dir + '/' + patch
            result = result.replace('../', '')
        prepare_result = result.replace(' M ', file+"/")
        print(prepare_result.replace('//','/'))
```

### Вывод скрипта при запуске при тестировании:
```
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology)-[git://e3a7f22 ✗]-
└> git status -u -s           
 M README.md
 M test/file
 M test/file1
 M test/file1M
?? script.py
?? test.py
?? test/script.py
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology)-[git://e3a7f22 ✗]-
└> ./script.py                     
/home/kisa/devops-netology/README.md
/home/kisa/devops-netology/test/file
/home/kisa/devops-netology/test/file1
/home/kisa/devops-netology/test/file1M
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology)-[git://e3a7f22 ✗]-
└> cp script.py test/script.py 
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology)-[git://e3a7f22 ✗]-
└> cd test 
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology/test)-[git://e3a7f22 ✗]-
└> ./script.py 
/home/kisa/devops-netology/test/README.md
/home/kisa/devops-netology/test/file
/home/kisa/devops-netology/test/file1
/home/kisa/devops-netology/test/file1M
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology/test)-[git://e3a7f22 ✗]-
└> cp script.py ~/            
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology/test)-[git://e3a7f22 ✗]-
└> cd ~/
└> ./script.py ~/devops-netology
/home/kisa/devops-netology/README.md
/home/kisa/devops-netology/test/file
/home/kisa/devops-netology/test/file1
/home/kisa/devops-netology/test/file1M
```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
import time

srv = {'drive.google.com':'', 'mail.google.com':'', 'google.com':''}

print('start script')

while True:
    for host in srv:
        ip = socket.gethostbyname(host)
        if ip != srv[host] :
            if srv[host] != '' :
                print(f'[ERROR] {host} IP mismatch: {srv[host]} {ip}') 
            srv[host] = ip
    time.sleep(2)
```

### Вывод скрипта при запуске при тестировании:
```
┌[kisa☮kisa-Lenovo-G40-30]-(~/devops-netology)-[git://e3a7f22 ✗]-
└> ./script.py
start script
[ERROR] mail.google.com IP mismatch: 64.233.162.17 64.233.162.19
[ERROR] mail.google.com IP mismatch: 64.233.162.19 64.233.162.18
[ERROR] google.com IP mismatch: 64.233.161.101 74.125.205.102
[ERROR] google.com IP mismatch: 74.125.205.102 74.125.205.113
[ERROR] mail.google.com IP mismatch: 64.233.162.18 64.233.162.17
[ERROR] mail.google.com IP mismatch: 64.233.162.17 64.233.162.19
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз переносить архив с нашими изменениями с сервера на наш локальный компьютер, формировать новую ветку, коммитить в неё изменения, создавать pull request (PR) и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. Мы хотим максимально автоматизировать всю цепочку действий. Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым). При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. С директорией локального репозитория можно делать всё, что угодно. Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

### Ваш скрипт:
```python
???
```

### Вывод скрипта при запуске при тестировании:
```
???
```