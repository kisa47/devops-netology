# devops-netology

## Домашнее задание к занятию "3.4. Операционные системы, лекция 2"

### На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter: поместите его в автозагрузку, предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron), удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

init file

```
vim /lib/systemd/system/node-exporter.service


[Unit]
Description=Prometheus exporter for hardware and OS metrics exposed by *NIX kernels, written in Go with pluggable metric collectors.

[Service]
EnvironmentFile=-/etc/node_exporter.conf
User=prometheus
ExecStart=/usr/bin/node_exporter
ExecReload=/bin/kill -HUP $MAINPID
TimeoutStopSec=20s
SendSIGKILL=no
Restart=always

[Install]
WantedBy=multi-user.target
```

Обновляем и стартуем
```
systemctl daemon-reload
systemctl enable node-explorer
systemctl start node-explorer

systemctl status node-explorer.service 
● node-explorer.service - Prometheus exporter for hardware and OS metrics exposed by *NIX kernels, written in Go with pluggable metric collec>
     Loaded: loaded (/lib/systemd/system/node-explorer.service; enabled; vendor preset: enabled)
     Active: active (running) since Fri 2021-12-10 11:18:18 UTC; 14min ago
   Main PID: 4509 (node_exporter)
      Tasks: 3 (limit: 1071)
     Memory: 7.3M
     CGroup: /system.slice/node-explorer.service
             └─4509 /usr/bin/node_exporter

Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.028Z caller=node_exporter.go:115 level=info collector=ther>
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.028Z caller=node_exporter.go:115 level=info collector=time
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.029Z caller=node_exporter.go:115 level=info collector=timex
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.029Z caller=node_exporter.go:115 level=info collector=udp_>
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.029Z caller=node_exporter.go:115 level=info collector=uname
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.029Z caller=node_exporter.go:115 level=info collector=vmst>
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.029Z caller=node_exporter.go:115 level=info collector=xfs
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.030Z caller=node_exporter.go:115 level=info collector=zfs
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.030Z caller=node_exporter.go:199 level=info msg="Listening>
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.030Z caller=tls_config.go:195 level=info msg="TLS is disab>
```

проверяем работу 
```
curl http://localhost:9100/metrics
# HELP go_gc_duration_seconds A summary of the pause duration of garbage collection cycles.
# TYPE go_gc_duration_seconds summary
go_gc_duration_seconds{quantile="0"} 1.0046e-05
go_gc_duration_seconds{quantile="0.25"} 3.2059e-05
go_gc_duration_seconds{quantile="0.5"} 4.116e-05
go_gc_duration_seconds{quantile="0.75"} 7.4097e-05
go_gc_duration_seconds{quantile="1"} 0.000222808
go_gc_duration_seconds_sum 0.001597787
go_gc_duration_seconds_count 27
# HELP go_goroutines Number of goroutines that currently exist.
# TYPE go_goroutines gauge
go_goroutines 8
# HELP go_info Information about the Go environment.
# TYPE go_info gauge
go_info{version="go1.17.3"} 1
# HELP go_memstats_alloc_bytes Number of bytes allocated and still in use.
# TYPE go_memstats_alloc_bytes gauge
go_memstats_alloc_bytes 1.93152e+06
# HELP go_memstats_alloc_bytes_total Total number of bytes allocated, even if freed.
# TYPE go_memstats_alloc_bytes_total counter
go_memstats_alloc_bytes_total 6.2326128e+07
# HELP go_memstats_buck_hash_sys_bytes Number of bytes used by the profiling bucket hash table.
# TYPE go_memstats_buck_hash_sys_bytes gauge
go_memstats_buck_hash_sys_bytes 1.462839e+06
# HELP go_memstats_frees_total Total number of frees.
# TYPE go_memstats_frees_total counter
go_memstats_frees_total 772152
# HELP go_memstats_gc_cpu_fraction The fraction of this program's available CPU time used by the GC since the program started.
# TYPE go_memstats_gc_cpu_fraction gauge
go_memstats_gc_cpu_fraction 2.9209022536048214e-05
```


Проверка стоп и релоад

```
systemctl stop node-explorer.service 
root@ubuntu2004:/opt# systemctl status node-explorer.service 
● node-explorer.service - Prometheus exporter for hardware and OS metrics exposed by *NIX kernels, written in Go with pluggable metric collec>
     Loaded: loaded (/lib/systemd/system/node-explorer.service; disabled; vendor preset: enabled)
     Active: inactive (dead)

Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.029Z caller=node_exporter.go:115 level=info collector=udp_>
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.029Z caller=node_exporter.go:115 level=info collector=uname
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.029Z caller=node_exporter.go:115 level=info collector=vmst>
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.029Z caller=node_exporter.go:115 level=info collector=xfs
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.030Z caller=node_exporter.go:115 level=info collector=zfs
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.030Z caller=node_exporter.go:199 level=info msg="Listening>
Dec 10 11:18:18 ubuntu2004.localdomain node_exporter[4509]: ts=2021-12-10T11:18:18.030Z caller=tls_config.go:195 level=info msg="TLS is disab>
Dec 10 11:35:01 ubuntu2004.localdomain systemd[1]: Stopping Prometheus exporter for hardware and OS metrics exposed by *NIX kernels, written >
Dec 10 11:35:01 ubuntu2004.localdomain systemd[1]: node-explorer.service: Succeeded.
Dec 10 11:35:01 ubuntu2004.localdomain systemd[1]: Stopped Prometheus exporter for hardware and OS metrics exposed by *NIX kernels, written i
root@ubuntu2004:/opt# systemctl start node-explorer.service 
root@ubuntu2004:/opt# systemctl restart node-explorer.service 
root@ubuntu2004:/opt# systemctl status node-explorer.service 
● node-explorer.service - Prometheus exporter for hardware and OS metrics exposed by *NIX kernels, written in Go with pluggable metric collec>
     Loaded: loaded (/lib/systemd/system/node-explorer.service; enabled; vendor preset: enabled)
     Active: active (running) since Fri 2021-12-10 11:54:07 UTC; 5s ago
   Main PID: 4859 (node_exporter)
      Tasks: 3 (limit: 1071)
     Memory: 2.2M
     CGroup: /system.slice/node-explorer.service
             └─4859 /usr/bin/node_exporter

Dec 10 11:54:07 ubuntu2004.localdomain node_exporter[4859]: ts=2021-12-10T11:54:07.261Z caller=node_exporter.go:115 level=info collector=ther>
Dec 10 11:54:07 ubuntu2004.localdomain node_exporter[4859]: ts=2021-12-10T11:54:07.262Z caller=node_exporter.go:115 level=info collector=time
Dec 10 11:54:07 ubuntu2004.localdomain node_exporter[4859]: ts=2021-12-10T11:54:07.262Z caller=node_exporter.go:115 level=info collector=timex
Dec 10 11:54:07 ubuntu2004.localdomain node_exporter[4859]: ts=2021-12-10T11:54:07.262Z caller=node_exporter.go:115 level=info collector=udp_>
Dec 10 11:54:07 ubuntu2004.localdomain node_exporter[4859]: ts=2021-12-10T11:54:07.262Z caller=node_exporter.go:115 level=info collector=uname
Dec 10 11:54:07 ubuntu2004.localdomain node_exporter[4859]: ts=2021-12-10T11:54:07.262Z caller=node_exporter.go:115 level=info collector=vmst>
Dec 10 11:54:07 ubuntu2004.localdomain node_exporter[4859]: ts=2021-12-10T11:54:07.262Z caller=node_exporter.go:115 level=info collector=xfs
Dec 10 11:54:07 ubuntu2004.localdomain node_exporter[4859]: ts=2021-12-10T11:54:07.262Z caller=node_exporter.go:115 level=info collector=zfs
Dec 10 11:54:07 ubuntu2004.localdomain node_exporter[4859]: ts=2021-12-10T11:54:07.262Z caller=node_exporter.go:199 level=info msg="Listening>
Dec 10 11:54:07 ubuntu2004.localdomain node_exporter[4859]: ts=2021-12-10T11:54:07.262Z caller=tls_config.go:195 level=info msg="TLS is disab>
```

### Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

CPU:

- node_cpu_seconds_total{cpu="0",mode="idle"} 2238.49
- node_cpu_seconds_total{cpu="0",mode="system"} 16.72
- node_cpu_seconds_total{cpu="0",mode="user"} 6.86
- process_cpu_seconds_total 0.14

Память:

- node_memory_MemAvailable_bytes 6.5286144e+08
- node_memory_MemFree_bytes 1.22728448e+08

Диск:

- node_disk_io_time_seconds_total{device="vda"} 21.456
- node_disk_read_time_seconds_total{device="vda"} 6.472
- node_disk_write_time_seconds_total{device="vda"} 27.241

Сеть:

node_network_receive_errs_total{device="eth0"}  0
node_network_receive_bytes_total{device="eth0"} 5.5760681e+07
node_network_transmit_bytes_total{device="eth0"} 1.27492e+06
node_network_transmit_errs_total{device="eth0"} 0

### Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

Да, можно, например:
```
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[    0.000000] Hypervisor detected: KVM
```
У меня для запуска вм используется гипервизор kvm.

### Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?

По умолчанию:
```
sysctl fs.nr_open
fs.nr_open = 1048576
```

Этот параметр означает текущее максимальное возможное число открытых дескрипторов ядра. Максимальное значение параметра можно посмотреть выполнив коаманду ```cat /proc/sys/fs/file-max```

Мягкий и жесткий лимиты (**ulimit -Sn** и **ulimit -Hn**) не могут превышать **fs.nr_open**

### Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.

запускаем команду в отдельном неимспейсе
```
unshare --fork --pid --mount-proc sleep 1h
```

проверяем:

```
root@ubuntu2004:/home/vagrant# ps -e | grep sleep
   3194 pts/1    00:00:00 sleep
root@ubuntu2004:/home/vagrant# nsenter --target 3194 --pid --mount
root@ubuntu2004:/# ps
    PID TTY          TIME CMD
      2 pts/0    00:00:00 bash
     11 pts/0    00:00:00 ps
```

### Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

```:(){ :|:& };:``` можно рассмотреть как:

```
:()
  {
       :|:&
  };
:
```
Эта команда определяет функцию без имени ```:``` выполнение которой создает  2 экземпляра функции ```:``` один из которых в фоне, таким образом происходит умножение процессов до достижения **ulimit**.

**dmesg** дает следующую информацию:
```
[   22.548947] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-5.scope
```

В ОС Linux **cgroup** ведет учет и накладывает ограничения на используемые ресурсы. 
Ограничить число процессов для пользователя можно выполнив команду ```ulimit -u <ограничение>```.

Стандартное число возможных процессов равно 31077. Таким образом ограничив кол-во возможных запущнных процессов пользователем можно снизить нагрузку на систему при таких нештатных ситуациях.