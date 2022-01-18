# devops-netology

## Домашнее задание к занятию "3.7. Компьютерные сети, лекция 2"

### Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?

Для проверки доступных сетевых интерфейсов на моей машине под управлением Ubuntu 20.04 можно использовать команды ```ip```, ```ifconfig``` и ```netstat```.

с использование ```ip```:

```bash
┌[vladimir☮ubuntu]-(~)
└> ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp1s0f0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:e0:ed:42:fe:e4 brd ff:ff:ff:ff:ff:ff
3: enp1s0f1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:e0:ed:42:fe:e5 brd ff:ff:ff:ff:ff:ff
4: enp1s0f2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:e0:ed:42:fe:e6 brd ff:ff:ff:ff:ff:ff
5: enp1s0f3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 00:e0:ed:42:fe:e7 brd ff:ff:ff:ff:ff:ff
6: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether b4:2e:99:cc:05:79 brd ff:ff:ff:ff:ff:ff
    altname enp0s31f6
7: virbr1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:ad:f1:11 brd ff:ff:ff:ff:ff:ff
8: virbr1-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel master virbr1 state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:ad:f1:11 brd ff:ff:ff:ff:ff:ff
9: virbr2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:87:09:15 brd ff:ff:ff:ff:ff:ff
10: virbr2-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel master virbr2 state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:87:09:15 brd ff:ff:ff:ff:ff:ff
11: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:0a:3c:b6 brd ff:ff:ff:ff:ff:ff
12: virbr0-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel master virbr0 state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:0a:3c:b6 brd ff:ff:ff:ff:ff:ff
13: virbr3: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:7c:34:be brd ff:ff:ff:ff:ff:ff
14: virbr3-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel master virbr3 state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:7c:34:be brd ff:ff:ff:ff:ff:ff
15: br-77a4944f2df5: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:8d:64:0a:82 brd ff:ff:ff:ff:ff:ff
16: br-add6bcf8fb21: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:31:c8:85:76 brd ff:ff:ff:ff:ff:ff
17: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:7d:0a:69:d6 brd ff:ff:ff:ff:ff:ff
18: br-c07b6a766308: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:66:ae:12:4d brd ff:ff:ff:ff:ff:ff
```

с использованием ifconfig

```bash
┌[vladimir☮ubuntu]-(~)
└> ifconfig -a
br-77a4944f2df5: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.16.238.1  netmask 255.255.255.0  broadcast 172.16.238.255
        ether 02:42:8d:64:0a:82  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

br-add6bcf8fb21: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.18.0.1  netmask 255.255.0.0  broadcast 172.18.255.255
        ether 02:42:31:c8:85:76  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

br-c07b6a766308: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.16.239.1  netmask 255.255.255.0  broadcast 172.16.239.255
        ether 02:42:66:ae:12:4d  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:7d:0a:69:d6  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eno1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.14.69  netmask 255.255.240.0  broadcast 192.168.15.255
        inet6 fe80::b62e:99ff:fecc:579  prefixlen 64  scopeid 0x20<link>
        ether b4:2e:99:cc:05:79  txqueuelen 1000  (Ethernet)
        RX packets 15257370  bytes 6442423194 (6.4 GB)
        RX errors 0  dropped 119014  overruns 0  frame 0
        TX packets 1803342  bytes 227116369 (227.1 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 16  memory 0xa1300000-a1320000  

enp1s0f0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 00:e0:ed:42:fe:e4  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device memory 0x8f800000-8f81ffff  

enp1s0f1: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 00:e0:ed:42:fe:e5  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device memory 0x8f820000-8f83ffff  

enp1s0f2: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 00:e0:ed:42:fe:e6  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device memory 0x8f840000-8f85ffff  

enp1s0f3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 00:e0:ed:42:fe:e7  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1119  bytes 52682 (52.6 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device memory 0x8f860000-8f87ffff  

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 687372  bytes 51940036 (51.9 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 687372  bytes 51940036 (51.9 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

virbr0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 192.168.130.1  netmask 255.255.255.0  broadcast 192.168.130.255
        ether 52:54:00:0a:3c:b6  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

virbr1: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 10.0.0.1  netmask 255.255.255.0  broadcast 10.0.0.255
        ether 52:54:00:ad:f1:11  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

virbr2: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 192.168.125.1  netmask 255.255.255.0  broadcast 192.168.125.255
        ether 52:54:00:87:09:15  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

virbr3: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 192.168.140.1  netmask 255.255.255.0  broadcast 192.168.140.255
        ether 52:54:00:7c:34:be  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

virbr0-nic: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 52:54:00:0a:3c:b6  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

virbr1-nic: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 52:54:00:ad:f1:11  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

virbr2-nic: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 52:54:00:87:09:15  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

virbr3-nic: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 52:54:00:7c:34:be  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

и наконец ```netstat```:
```bash
┌[vladimir☮ubuntu]-(~)
└> netstat -i
Kernel Interface table
Iface      MTU    RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR Flg
br-77a49  1500        0      0      0 0             0      0      0      0 BMU
br-add6b  1500        0      0      0 0             0      0      0      0 BMU
br-c07b6  1500        0      0      0 0             0      0      0      0 BMU
docker0   1500        0      0      0 0             0      0      0      0 BMU
eno1      1500 15260404      0 119041 0       1803589      0      0      0 BMRU
enp1s0f0  1500        0      0      0 0             0      0      0      0 BMU
enp1s0f1  1500        0      0      0 0             0      0      0      0 BMU
enp1s0f2  1500        0      0      0 0             0      0      0      0 BMU
enp1s0f3  1500        0      0      0 0          1119      0      0      0 BMRU
lo       65536   687664      0      0 0        687664      0      0      0 LRU
virbr0    1500        0      0      0 0             0      0      0      0 BMU
virbr1    1500        0      0      0 0             0      0      0      0 BMU
virbr2    1500        0      0      0 0             0      0      0      0 BMU
virbr3    1500        0      0      0 0             0      0      0      0 BMU
```

В Windows в cmd:

```
C:\Users\kerb>ipconfig                                                                                                                                                                                                                    Настройка протокола IP для Windows

Адаптер Ethernet 4:
DNS-суффикс подключения . . . . . : 
IPv4-адрес. . . . . . . . . . . . : 192.168.6.156
Маска подсети . . . . . . . . . . : 255.255.240.0
Основной шлюз. . . . . . . . . : 192.168.10.1 
```
### Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?

Протокол для распознавания соседа по сетевому интерфейсу **lldp**, пакет **lldpd**, команда **llpdpctl**.

Чтобы распознавание готово надо включить сервис **lldpd** командой ```systemctl start lldpd```

Для демонстрации запустил вагрантбоксы немного переделав конфиг:
```
# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = {
  'netology1' => '10',
  'netology2' => '60',
  'netology3' => '90',
}

Vagrant.configure("2") do |config|

  config.vm.box = "generic/ubuntu2004"

  config.vm.provider "libvirt"
  boxes.each do |k,v|
     config.vm.define k do |node|
      node.vm.network :private_network, :ip => "172.28.128.#{v}"
      node.vm.provision "shell" do |s|
        s.inline = "hostname $1; apt -y install nginx lldpd; systemctl start lldpd;"
        s.args = [k]
      end
    end
  end
end
```

И на хостовой машине выполнил команду ```lldpctl```

```bash
┌[vladimir☮ubuntu]-(~/vagrant)
└> sudo lldpctl              
-------------------------------------------------------------------------------
LLDP neighbors:
-------------------------------------------------------------------------------
Interface:    eno1, via: LLDP, RID: 1, Time: 0 day, 01:44:34
  Chassis:     
    ChassisID:    mac c4:36:da:01:09:00
  Port:        
    PortID:       ifname gi1/1/3
    TTL:          120
-------------------------------------------------------------------------------
Interface:    vnet1, via: LLDP, RID: 12, Time: 0 day, 00:01:41
  Chassis:     
    ChassisID:    mac 52:54:00:91:26:7b
    SysName:      netology3
    SysDescr:     Ubuntu 20.04.3 LTS Linux 5.4.0-89-generic #100-Ubuntu SMP Fri Sep 24 14:50:10 UTC 2021 x86_64
    MgmtIP:       172.28.128.90
    MgmtIP:       fe80::5054:ff:fe91:267b
    Capability:   Bridge, off
    Capability:   Router, off
    Capability:   Wlan, off
    Capability:   Station, on
  Port:        
    PortID:       mac 52:54:00:d1:86:aa
    PortDescr:    eth1
    TTL:          120
-------------------------------------------------------------------------------
Interface:    vnet3, via: LLDP, RID: 11, Time: 0 day, 00:05:11
  Chassis:     
    ChassisID:    mac 52:54:00:3c:28:c3
    SysName:      netology1
    SysDescr:     Ubuntu 20.04.3 LTS Linux 5.4.0-89-generic #100-Ubuntu SMP Fri Sep 24 14:50:10 UTC 2021 x86_64
    MgmtIP:       172.28.128.10
    MgmtIP:       fe80::5054:ff:fe47:3b9
    Capability:   Bridge, off
    Capability:   Router, off
    Capability:   Wlan, off
    Capability:   Station, on
  Port:        
    PortID:       mac 52:54:00:47:03:b9
    PortDescr:    eth1
    TTL:          120
-------------------------------------------------------------------------------
Interface:    vnet5, via: LLDP, RID: 13, Time: 0 day, 00:03:10
  Chassis:     
    ChassisID:    mac 52:54:00:16:32:38
    SysName:      netology2
    SysDescr:     Ubuntu 20.04.3 LTS Linux 5.4.0-89-generic #100-Ubuntu SMP Fri Sep 24 14:50:10 UTC 2021 x86_64
    MgmtIP:       172.28.128.60
    MgmtIP:       fe80::5054:ff:fe84:1f7b
    Capability:   Bridge, off
    Capability:   Router, off
    Capability:   Wlan, off
    Capability:   Station, on
  Port:        
    PortID:       mac 52:54:00:84:1f:7b
    PortDescr:    eth1
    TTL:          120
-------------------------------------------------------------------------------
```

### Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.

Для разделения сетей используется технология **VLAN** (Virtual Local Area Network). Для обеспечения передачи трафика существует 2 режима работы портов: **access** и **trunk**. Между портами в режиме **trunk** может передаваться трафик нескольких заданных виртуальных сетей (например 2-10 и 100), каждый из которых помечается специальной меткой (тегом), которая описана в стандарте **802.1Q**, который встраивается в фреим и по стандарту максимальное кол-во vlan не может превышать **4095** (vlan 0 зарезервирован). При этом  vlan 1 не рекомендуется использовать из-за того, что на большинстве сетевого оборудования он установлен по умолчанию для всех **access** портов. Трафик между **access** портами передается без тэга vlan, и может передаваться только между портами входящих в один vlan внутри коммутатора. Данная технология существует для повышения безопасности сети, оптимизации работы оборудования и снижения накладных расходов, что достигается путем разделения трафика проходящего через одно и тоже оборудование.

В linux пакет для использования **vlan** используется устаревший пакет **vlan**. Также необходима поддержка ядром 802.1Q, чтобы включить модуль ядра нужно выполнить команду ```modprobe 8021q```.

Для создания тегированного интерфейса можно использовать устаревшую команду ```vconfig```.

Например для поднятия тегированного интерфейса с помощью команды ```vconfig`` нужно выполнить следующие команды:

машина 1
```bash
sudo modprobe 8021q
apt-get install vlan
sudo vconfig add eth1 100 #eth0 это девайс а 100 тег
sudo ip address add 192.168.100.100/24 dev eth1.100 && sudo ip link set up eth1.100 #настраиваем тегированный интерфейс 
```

машина 2
```bash
sudo modprobe 8021q
apt-get install vlan
sudo vconfig add eth0 100 #eth0 это девайс а 100 тег
sudo ip address add 192.168.100.101/24 dev eth1.100 && sudo ip link set up eth1.100 #настраиваем тегированный интерфейс 
```

После чего выполним проверку доступности 100.100 с машины 100.101

```bash 
ping -s 1000 192.168.100.100
1008 bytes from 192.168.100.100: icmp_seq=1 ttl=64 time=0.265 ms
1008 bytes from 192.168.100.100: icmp_seq=2 ttl=64 time=0.415 ms
```

и проверим приходят ли пакеты на машине 100.100

```bash
cat /proc/net/vlan/eth1.100 
eth1.100  VID: 100	 REORDER_HDR: 1  dev->priv_flags: 1021
         total frames received           33
          total bytes received         8932
      Broadcast/Multicast Rcvd            0

      total frames transmitted           33
       total bytes transmitted         9394
Device: eth1
INGRESS priority mappings: 0:0  1:0  2:0  3:0  4:0  5:0  6:0 7:0
 EGRESS priority mappings: 
```

Также можно настроить с помощью ```iproute```

машина 1 
```bash
sudo ip link add link eth1 name eth1.101 type vlan id 101
ip address add 192.168.101.100/24 dev eth1.101 && ip link set up eth1.101
```
машина 2
```bash
sudo ip link add link eth1 name eth1.101 type vlan id 101
ip address add 192.168.101.101/24 dev eth1.101 && ip link set up eth1.101
```
Проверяем
```bash
ping 192.168.101.101
PING 192.168.101.101 (192.168.101.101) 56(84) bytes of data.
64 bytes from 192.168.101.101: icmp_seq=1 ttl=64 time=0.653 ms
64 bytes from 192.168.101.101: icmp_seq=2 ttl=64 time=0.770 ms
64 bytes from 192.168.101.101: icmp_seq=3 ttl=64 time=0.790 ms
64 bytes from 192.168.101.101: icmp_seq=4 ttl=64 time=0.785 ms
64 bytes from 192.168.101.101: icmp_seq=5 ttl=64 time=0.721 ms
^C
--- 192.168.101.101 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4073ms
rtt min/avg/max/mdev = 0.653/0.743/0.790/0.051 ms

cat /proc/net/vlan/eth1.101
eth1.101  VID: 101	 REORDER_HDR: 1  dev->priv_flags: 1021
         total frames received           14
          total bytes received         5672
      Broadcast/Multicast Rcvd            0

      total frames transmitted           14
       total bytes transmitted         5868
Device: eth1
INGRESS priority mappings: 0:0  1:0  2:0  3:0  4:0  5:0  6:0 7:0
 EGRESS priority mappings: 
```

Еще один способ настройки через ```netplan```

машина 1
```bash
cat /etc/network/interfaces
auto eth1.102
iface eth1.102 inet static
    address 192.168.102.100
    netmask 255.255.255.0
    vlan-raw-device eth1

systemctl restart networking.service
```
машина 2
```bash
cat /etc/network/interfaces
auto eth1.102
iface eth1.102 inet static
    address 192.168.102.101
    netmask 255.255.255.0
    vlan-raw-device eth1
    
systemctl restart networking.service
```

проверяем

```bash
ping -s 1000 192.168.102.101
PING 192.168.102.101 (192.168.102.101) 1000(1028) bytes of data.
1008 bytes from 192.168.102.101: icmp_seq=1 ttl=64 time=0.710 ms
1008 bytes from 192.168.102.101: icmp_seq=2 ttl=64 time=0.829 ms
1008 bytes from 192.168.102.101: icmp_seq=3 ttl=64 time=0.718 ms
1008 bytes from 192.168.102.101: icmp_seq=4 ttl=64 time=0.779 ms
1008 bytes from 192.168.102.101: icmp_seq=5 ttl=64 time=0.769 ms
1008 bytes from 192.168.102.101: icmp_seq=6 ttl=64 time=0.748 ms
1008 bytes from 192.168.102.101: icmp_seq=7 ttl=64 time=0.734 ms
^C
--- 192.168.102.101 ping statistics ---
7 packets transmitted, 7 received, 0% packet loss, time 6116ms
rtt min/avg/max/mdev = 0.710/0.755/0.829/0.038 ms

cat /proc/net/vlan/eth1.102
eth1.102  VID: 102	 REORDER_HDR: 1  dev->priv_flags: 1021
         total frames received           11
          total bytes received         7420
      Broadcast/Multicast Rcvd            0

      total frames transmitted           11
       total bytes transmitted         7574
Device: eth1
INGRESS priority mappings: 0:0  1:0  2:0  3:0  4:0  5:0  6:0 7:0
 EGRESS priority mappings: 
```

## Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.

В линукс есть 7 типов агрегации интерфейсов:

- mode=0 (balance-rr)
    Этот режим используется по-умолчанию, если в настройках не указано другое. balance-rr обеспечивает балансировку нагрузки и отказоустойчивость. В данном режиме пакеты отправляются "по кругу" от первого интерфейса к последнему и сначала. Если выходит из строя один из интерфейсов, пакеты отправляются на остальные оставшиеся.При подключении портов к разным коммутаторам, требует их настройки.

- mode=1 (active-backup)
    При active-backup один интерфейс работает в активном режиме, остальные в ожидающем. Если активный падает, управление передается одному из ожидающих. Не требует поддержки данной функциональности от коммутатора.

- mode=2 (balance-xor)
    Передача пакетов распределяется между объединенными интерфейсами по формуле ((MAC-адрес источника) XOR (MAC-адрес получателя)) % число интерфейсов. Один и тот же интерфейс работает с определённым получателем. Режим даёт балансировку нагрузки и отказоустойчивость.

- mode=3 (broadcast)
    Происходит передача во все объединенные интерфейсы, обеспечивая отказоустойчивость.

- mode=4 (802.3ad)
    Это динамическое объединение портов. В данном режиме можно получить значительное увеличение пропускной способности как входящего так и исходящего трафика, используя все объединенные интерфейсы. Требует поддержки режима от коммутатора, а так же (иногда) дополнительную настройку коммутатора.

- mode=5 (balance-tlb)
    Адаптивная балансировка нагрузки. При balance-tlb входящий трафик получается только активным интерфейсом, исходящий - распределяется в зависимости от текущей загрузки каждого интерфейса. Обеспечивается отказоустойчивость и распределение нагрузки исходящего трафика. Не требует специальной поддержки коммутатора.

- mode=6 (balance-alb)
    Адаптивная балансировка нагрузки (более совершенная). Обеспечивает балансировку нагрузки как исходящего (TLB, transmit load balancing), так и входящего трафика (для IPv4 через ARP). Не требует специальной поддержки коммутатором, но требует возможности изменять MAC-адрес устройства.

Для настройки необходима поддержка ядром агрегации (bonding) ```modprobe bonding```

Пример конфига:

```bash
cat /etc/network/interfaces
# The loopback network interface
auto lo
iface lo inet loopback


auto bond0 eth0 eth1
# параметры бонд-интерфейса
iface bond0 inet static
        address 10.0.0.11
        netmask 255.255.255.0
        gateway 10.0.0.254
        # определяем подчиненные (объединяемые) интерфейсы
        bond-slaves eth0 eth1
        # задаем тип бондинга mode=6
        bond-mode balance-alb
        # интервал проверки линии в миллисекундах
bond-miimon 100
        # Задержка перед установкой соединения в миллисекундах
bond-downdelay 200
# Задержка перед обрывом соединения в миллисекундах
        bond-updelay 200
```

## Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.

В сети с маской **29** бит всего **8** узлов.

Подсетей с маской **29** бит в сети с маской **24** бита может быть не более 32.

Внутри сети 10.10.10.0/24 находятся следующие сети с маской /29

- 10.10.10.0/29 
- 10.10.10.8/29
- 10.10.10.16/29
- 10.10.10.24/29
- 10.10.10.32/29
и т.д.

Обоснование:

маска /24 в двоичной системе: 11111111 11111111 11111111 00000 000
маска /29 в двоичной системе: 11111111 11111111 11111111 11111 000

опустим три первых октета, так как они не меняются для /24 получаем:

00000000
11111000

Соответственно, можно выделить только те сети, у которых уникальные 5 бит, 2^5 это 32.

## Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.

Если диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты, то 2 организации весьма крупные... и стоит использовать сети из диапазона 100.64.0.0/10 .

Так как предполагается использовать не более 50 хостов подойдет 100.64.0.0/26.

## Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?

Посмотреть ARP в Linux таблицу можно выполнив команду arp (входит в пакет net-tools)

```bash
arp -n
Address                  HWtype  HWaddress           Flags Mask            Iface
192.168.10.18            ether   2e:d5:23:52:6e:d9   C                     eno1
192.168.14.217           ether   00:16:3e:13:ee:c3   C                     eno1
192.168.10.144           ether   00:25:90:f9:5a:6b   C                     eno1
192.168.14.125           ether   02:ff:f0:91:c9:b9   C                     eno1
192.168.9.195            ether   3c:4a:92:ba:50:56   C                     eno1
192.168.11.222           ether   88:51:fb:ee:a7:87   C                     eno1
172.17.0.2               ether   02:42:ac:11:00:02   C                     docker0
192.168.9.156            ether   00:15:99:93:7c:c5   C                     eno1
10.0.0.69                ether   02:ff:f0:71:b5:e5   C                     eno1
10.0.0.69                        (incomplete)                              virbr1
192.168.7.175            ether   00:16:3e:25:3b:f8   C                     eno1
192.168.14.210           ether   00:16:3e:f3:6d:6f   C                     eno1
192.168.14.118           ether   20:65:8e:85:6a:80   C                     eno1
192.168.10.1             ether   00:1b:21:a6:98:b4   C                     eno1
192.168.11.114           ether   00:26:58:04:68:bc   C                     eno1
192.168.7.60             ether   b4:2e:99:cc:05:68   C                     eno1
192.168.121.208          ether   52:54:00:49:78:5e   C                     virbr4
192.168.14.215           ether   00:16:3e:4f:4e:d6   C                     eno1
192.168.14.60            ether   52:54:00:35:23:d2   C                     eno1
192.168.10.6             ether   d8:e0:b8:f0:00:ae   C                     eno1
192.168.9.187            ether   04:0e:3c:e9:0d:62   C                     eno1
192.168.10.25            ether   16:cf:be:f2:ad:9e   C                     eno1
192.168.14.211           ether   00:16:3e:26:59:c8   C                     eno1
192.168.0.203            ether   d8:e0:b8:00:49:e2   C                     eno1
192.168.14.138           ether   20:65:8e:85:69:a2   C                     eno1
192.168.6.141            ether   02:ff:f0:79:c1:d1   C                     eno1
192.168.11.115           ether   00:26:58:04:68:76   C                     eno1
192.168.9.221            ether   f4:ce:46:43:21:5f   C                     eno1
192.168.7.168            ether   02:ff:f0:71:8c:bb   C                     eno1
192.168.10.17            ether   5a:ae:ae:6a:fe:fd   C                     eno1
192.168.9.198            ether   3c:d9:2b:9f:ac:94   C                     eno1
192.168.14.105           ether   ac:1f:6b:04:d1:48   C                     eno1
192.168.10.7             ether   00:0c:29:a9:fb:06   C                     eno1
192.168.9.194            ether   00:17:c8:9e:c1:dc   C                     eno1
192.168.14.212           ether   00:16:3e:b8:a3:70   C                     eno1
192.168.5.228            ether   10:7b:44:93:96:35   C                     eno1
192.168.6.104            ether   00:0c:29:4d:81:8c   C                     eno1
192.168.9.184            ether   a0:8c:fd:66:78:81   C                     eno1
192.168.10.104           ether   d6:6d:d8:e5:ff:51   C                     eno1
192.168.10.148           ether   00:16:3e:f7:da:e2   C                     eno1
```
Очистить arp таблицу:

``` 
┌[vladimir☮ubuntu]-(~/vagrant)
└> sudo ip neigh flush dev eno1
┌[vladimir☮ubuntu]-(~/vagrant)
└> arp -n                      
Address                  HWtype  HWaddress           Flags Mask            Iface
172.17.0.2               ether   02:42:ac:11:00:02   C                     docker0
10.0.0.69                        (incomplete)                              virbr1
192.168.10.1             ether   00:1b:21:a6:98:b4   C                     eno1
192.168.121.208          ether   52:54:00:49:78:5e   C                     virbr4
192.168.10.7             ether   00:0c:29:a9:fb:06   C                     eno1
```

удалить адрес:
```bash
arp -n                     
Address                  HWtype  HWaddress           Flags Mask            Iface
192.168.10.144           ether   00:25:90:f9:5a:6b   C                     eno1
172.17.0.2               ether   02:42:ac:11:00:02   C                     docker0
10.0.0.69                ether   02:ff:f0:71:b5:e5   C                     eno1
10.0.0.69                        (incomplete)                              virbr1
192.168.7.175            ether   00:16:3e:25:3b:f8   C                     eno1
192.168.10.1             ether   00:1b:21:a6:98:b4   C                     eno1
192.168.121.208          ether   52:54:00:49:78:5e   C                     virbr4
192.168.10.7             ether   00:0c:29:a9:fb:06   C                     eno1
┌[vladimir☮ubuntu]-(~/vagrant)
└> sudo arp -d 192.168.10.7
┌[vladimir☮ubuntu]-(~/vagrant)
└> arp -n                  
Address                  HWtype  HWaddress           Flags Mask            Iface
192.168.10.144           ether   00:25:90:f9:5a:6b   C                     eno1
172.17.0.2               ether   02:42:ac:11:00:02   C                     docker0
10.0.0.69                ether   02:ff:f0:71:b5:e5   C                     eno1
10.0.0.69                        (incomplete)                              virbr1
192.168.7.175            ether   00:16:3e:25:3b:f8   C                     eno1
192.168.10.1             ether   00:1b:21:a6:98:b4   C                     eno1
192.168.121.208          ether   52:54:00:49:78:5e   C                     virbr4
```