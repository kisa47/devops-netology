# Домашнее задание к занятию "08.01 Введение в Ansible"

## Подготовка к выполнению
1. Установите ansible версии 2.10 или выше.
2. Создайте свой собственный публичный репозиторий на github с произвольным именем.
3. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

### Ответ
```
┌[vladimir☮ubuntu]-(~/devops-netology/07-terraform-06-providers)-[git://master ✗]-
└> ansible --version
ansible 2.10.17
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/vladimir/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.8/dist-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 3.8.10 (default, Jun 22 2022, 20:18:18) [GCC 9.4.0]
```


## Основная часть
1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте какое значение имеет факт `some_fact` для указанного хоста при выполнении playbook'a.
2. Найдите файл с переменными (group_vars) в котором задаётся найденное в первом пункте значение и поменяйте его на 'all default fact'.
3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились следующие значения: для `deb` - 'deb default fact', для `el` - 'el default fact'.
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

### Ответ

1. Факт `some_fact`= 12 
```
TASK [Print fact] ***********************************************************************************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": 12
}
```
2. [Файл](playbook/group_vars/all/examp.yml) со значением **some_fact**.

3. Окружение из (докерфайлов)[docker] 
```
┌[vladimir☮ubuntu]-(~/devops-netology/08-ansible-01-base/docker)-[git://master ✗]-
└> docker build -f Dockerfile.centos . -t centos:netology
Sending build context to Docker daemon  3.072kB
Step 1/2 : FROM centos:7
 ---> eeb6ee3f44bd
Step 2/2 : RUN yum install -y python3
 ---> Running in c705bd673370
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
Installed:
  python3.x86_64 0:3.6.8-18.el7                                                 

Dependency Installed:
  libtirpc.x86_64 0:0.2.4-0.16.el7   python3-libs.x86_64 0:3.6.8-18.el7         
  python3-pip.noarch 0:9.0.3-8.el7   python3-setuptools.noarch 0:39.2.0-10.el7  

Complete!
Removing intermediate container c705bd673370
 ---> 891d9385a29b
Successfully built 891d9385a29b
Successfully tagged centos:netology
┌[vladimir☮ubuntu]-(~/devops-netology/08-ansible-01-base/docker)-[git://master ✗]-
└> docker run -id --name centos7 centos:netology /bin/bash
6c15ad359cb92877a2db7e06020c0abb55265af6d0c8d0270a0e47b69e713d57
┌[vladimir☮ubuntu]-(~/devops-netology/08-ansible-01-base/docker)-[git://master ✗]-
└> docker build -f Dockerfile.ubuntu . -t ubuntu:netology
Sending build context to Docker daemon  2.048kB
Step 1/2 : FROM ubuntu
 ---> ed337547de8f
Step 2/2 : RUN apt-get update && apt-get install -y python3
 ---> Running in 1e845a4a95ca
 Get:1 http://archive.ubuntu.com/ubuntu jammy InRelease [270 kB]
Get:2 http://security.ubuntu.com/ubuntu jammy-security InRelease [110 kB]
Get:3 http://archive.ubuntu.com/ubuntu jammy-updates InRelease [114 kB]
 ---> 09d8113bc87b
Successfully built 09d8113bc87b
Successfully tagged ubuntu:netology
┌[vladimir☮ubuntu]-(~/devops-netology/08-ansible-01-base/docker)-[git://master ✗]-
└> docker run -id --name ubuntu ubuntu:netology /bin/bash
12fe0e32e93a75c279b043f5f18f1abe7a96a9a07d1b52f08c6792b9f48d0960
```
4. `some_fact` для каждого хоста **ubuntu**=**deb**, **centos7**=**el** :
```
┌[vladimir☮ubuntu]-(~/devops-netology/08-ansible-01-base/playbook)-[git://master ✗]-
└> ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] *******************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *************************************************************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP ******************************************************************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```
5. (group_vars)[playbook/group_vars/]

6. `some_fact` для каждого хоста применились:

```
┌[vladimir☮ubuntu]-(~/devops-netology/08-ansible-01-base/playbook)-[git://master ✗]-
└> ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] *******************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *************************************************************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ******************************************************************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
7. Шифруем
```
┌[vladimir☮ubuntu]-(~/devops-netology/08-ansible-01-base/playbook)-[git://master ✗]-
└> ansible-vault encrypt group_vars/deb/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful
┌[vladimir☮ubuntu]-(~/devops-netology/08-ansible-01-base/playbook)-[git://master ✗]-
└> ansible-vault encrypt group_vars/el/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful
```
8. Запускаем:
```
┌[vladimir☮ubuntu]-(~/devops-netology/08-ansible-01-base/playbook)-[git://master ✗]-
└> ansible-playbook --ask-vault-pass -i inventory/prod.yml site.yml 
Vault password: 

PLAY [Print os facts] *******************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *************************************************************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ******************************************************************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```

9. Список плагинов:

```
add_host                                                                       Add a host (and alternatively a group) to the ansible-playbook in-memory inventory                                                                                                                   
amazon.aws.aws_az_facts                                                        Gather information about availability zones in AWS                                                                                                                                                   
amazon.aws.aws_az_info                                                         Gather information about availability zones in AWS                                                                                                                                                   
amazon.aws.aws_caller_facts                                                    Get information about the user and account being used to make AWS calls                                                                                                                              
amazon.aws.aws_caller_info                                                     Get information about the user and account being used to make AWS calls                                                                                                                              
amazon.aws.aws_s3                                                              manage objects in S3                                                                                                                                                                                                                   
```

10. Добавляем группу хостов **local** в [prod.yml](playbook/inventory/prod.yml)

11. Запускаем, и убеждаемся что факт о локалхост получен из all так как не определен:
```
[vladimir☮ubuntu]-(~/devops-netology/08-ansible-01-base/playbook)-[git://master ✗]-
└> ansible-playbook --ask-vault-pass -i inventory/prod.yml site.yml 
Vault password: 

PLAY [Print os facts] *******************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************************************************************
ok: [centos7]
ok: [localhost]
ok: [ubuntu]

TASK [Print OS] *************************************************************************************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ******************************************************************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в вашей личный репозиторий.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---