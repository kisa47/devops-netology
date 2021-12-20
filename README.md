# devops-netology

## Домашнее задание к занятию "3.5. Файловые системы"

### Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

Нет не могут, так как это один и тот же файл c одной **inode**, так как в **inode** содержатся данные о владельцах и права доступа.

### Сделайте vagrant destroy на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим

Так как я могу запускать ВМ только на хосте с qemu/kvm (не могу останавливать работу kvm с ВМ) я собрал свою конфигурацию, аналогичную той, что в задании:

```
cat Vagrantfile 
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2004"
  config.vm.provider :libvirt do |libvirt|
    libvirt.storage :file, :size => '2560M', :bus => 'sata' 
    libvirt.storage :file, :size => '2560M', :bus => 'sata'
  end
end
```

### Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

Вот листинг разбиения:

```bash
root@ubuntu2004:/home/vagrant# fdisk /dev/sda

Welcome to fdisk (util-linux 2.34).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x119fb45c.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-5242879, default 2048): 2048

Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879): +2G 

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (2-4, default 2): 2
First sector (4196352-5242879, default 4196352):  
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879): 

Created a new partition 2 of type 'Linux' and of size 511 MiB.

Command (m for help): w

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

```

### Используя sfdisk, перенесите данную таблицу разделов на второй диск.

Вот листинг переноса таблицы на второй диск:

```bash
root@ubuntu2004:/home/vagrant# sfdisk -d /dev/sda | sfdisk --force /dev/sdb 
\Checking that no-one is using this disk right now ... OK

Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: QEMU HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0x119fb45c.
/dev/sdb1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
/dev/sdb2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
/dev/sdb3: Done.

New situation:
Disklabel type: dos
Disk identifier: 0x119fb45c

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdb1          2048 4196351 4194304    2G 83 Linux
/dev/sdb2       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

Проверяем:

```
root@ubuntu2004:/home/vagrant# sfdisk -l
Disk /dev/vda: 128 GiB, 137438953472 bytes, 268435456 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xeeaa3c14

Device     Boot   Start       End   Sectors   Size Id Type
/dev/vda1  *       2048    999423    997376   487M 83 Linux
/dev/vda2        999424   4999167   3999744   1.9G 82 Linux swap / Solaris
/dev/vda3       4999168 268433407 263434240 125.6G 83 Linux


Disk /dev/sda: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: QEMU HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x119fb45c

Device     Boot   Start     End Sectors  Size Id Type
/dev/sda1          2048 4196351 4194304    2G 83 Linux
/dev/sda2       4196352 5242879 1046528  511M 83 Linux


Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: QEMU HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x119fb45c

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdb1          2048 4196351 4194304    2G 83 Linux
/dev/sdb2       4196352 5242879 1046528  511M 83 Linux
root@ubuntu2004:/home/vagrant# 
```

### Соберите mdadm RAID1 на паре разделов 2 Гб.


```bash
root@ubuntu2004:/home/vagrant# mdadm --create --verbose --metadata=0.90 /dev/md0 -l 1 -n 2 /dev/sd{a,b}1
mdadm: size set to 2097088K
mdadm: array /dev/md0 started.
```

### Соберите mdadm RAID0 на второй паре маленьких разделов.

```bash
root@ubuntu2004:/home/vagrant# mdadm --create --verbose /dev/md1 -l 0 -n 2 /dev/sd{a,b}2
mdadm: chunk size defaults to 512K
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.
```

### Создайте 2 независимых PV на получившихся md-устройствах.

```bash
root@ubuntu2004:/home/vagrant# pvcreate /dev/md0 /dev/md1
  Physical volume "/dev/md0" successfully created.
  Physical volume "/dev/md1" successfully created.
```

### Создайте общую volume-group на этих двух PV.

Создание:

```bash
root@ubuntu2004:/home/vagrant# vgcreate vg1 /dev/md0 /dev/md1
  Volume group "vg1" successfully created
```
Проверка:

```bash
root@ubuntu2004:/home/vagrant# vgdisplay 
  --- Volume group ---
  VG Name               vg1
  System ID             
  Format                lvm2
  Metadata Areas        2
  Metadata Sequence No  1
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                0
  Open LV               0
  Max PV                0
  Cur PV                2
  Act PV                2
  VG Size               <2.99 GiB
  PE Size               4.00 MiB
  Total PE              765
  Alloc PE / Size       0 / 0   
  Free  PE / Size       765 / <2.99 GiB
  VG UUID               ofCKKb-u9Pz-TYJL-Xf4d-rHGm-7aDV-lgvqY3
```

### Создайте LV размером 100 Мб, указав его расположение на PV с RAID0

Создание:

```bash
root@ubuntu2004:/home/vagrant# lvcreate -L 100M vg1 /dev/md1 
  Logical volume "lvol0" created.
```

Проверка:

```bash
root@ubuntu2004:/home/vagrant# vgs
  VG  #PV #LV #SN Attr   VSize  VFree
  vg1   2   1   0 wz--n- <2.99g 2.89g
root@ubuntu2004:/home/vagrant# lvs
  LV    VG  Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  lvol0 vg1 -wi-a----- 100.00m                                                    
```

### Создайте mkfs.ext4 ФС на получившемся LV.

```bash
root@ubuntu2004:/home/vagrant# mkfs.ext4 /dev/vg1/lvol0
mke2fs 1.45.5 (07-Jan-2020)
Discarding device blocks: done                            
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
```

### Смонтируйте этот раздел в любую директорию, например, /tmp/new.

```bash
root@ubuntu2004:/home/vagrant# mkdir /tmp/new
root@ubuntu2004:/home/vagrant# mount /dev/vg1/lvol0 /tmp/new
```

### Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.

```bash
root@ubuntu2004:/home/vagrant# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
--2021-12-20 14:14:23--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 22721567 (22M) [application/octet-stream]
Saving to: ‘/tmp/new/test.gz’

/tmp/new/test.gz                                                     100%[====================================================================================================================================================================>]  21.67M  8.42MB/s    in 2.6s    

2021-12-20 14:14:26 (8.42 MB/s) - ‘/tmp/new/test.gz’ saved [22721567/22721567]
```

### Прикрепите вывод lsblk.

```bash
root@ubuntu2004:/home/vagrant# lsblk 
NAME            MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda               8:0    0   2.5G  0 disk  
├─sda1            8:1    0     2G  0 part  
│ └─md0           9:0    0     2G  0 raid1 
└─sda2            8:2    0   511M  0 part  
  └─md1           9:1    0  1018M  0 raid0 
    └─vg1-lvol0 253:0    0   100M  0 lvm   /tmp/new
sdb               8:16   0   2.5G  0 disk  
├─sdb1            8:17   0     2G  0 part  
│ └─md0           9:0    0     2G  0 raid1 
└─sdb2            8:18   0   511M  0 part  
  └─md1           9:1    0  1018M  0 raid0 
    └─vg1-lvol0 253:0    0   100M  0 lvm   /tmp/new
vda             252:0    0   128G  0 disk  
├─vda1          252:1    0   487M  0 part  /boot
├─vda2          252:2    0   1.9G  0 part  [SWAP]
└─vda3          252:3    0 125.6G  0 part  /
```

### Протестируйте целостность файла:

```
root@ubuntu2004:/home/vagrant# gzip -t /tmp/new/test.gz
root@ubuntu2004:/home/vagrant# echo $?
0
```

### Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

```bash
pvmove /dev/md1 /dev/md0
  /dev/md1: Moved: 100.00%
```

### Сделайте --fail на устройство в вашем RAID1 md.

```bash
root@ubuntu2004:/home/vagrant# mdadm /dev/md0 --fail /dev/sda1
mdadm: set /dev/sda1 faulty in /dev/md0
```

Проверка:
```bash
root@ubuntu2004:/home/vagrant# mdadm -D /dev/md0
/dev/md0:
           Version : 0.90
     Creation Time : Mon Dec 20 13:57:49 2021
        Raid Level : raid1
        Array Size : 2097088 (2047.94 MiB 2147.42 MB)
     Used Dev Size : 2097088 (2047.94 MiB 2147.42 MB)
      Raid Devices : 2
     Total Devices : 2
   Preferred Minor : 0
       Persistence : Superblock is persistent

       Update Time : Mon Dec 20 14:23:10 2021
             State : clean, degraded 
    Active Devices : 1
   Working Devices : 1
    Failed Devices : 1
     Spare Devices : 0

Consistency Policy : resync

              UUID : 09517c6e:d43a3e5e:d43f1cea:f37e2356 (local to host ubuntu2004.localdomain)
            Events : 0.23

    Number   Major   Minor   RaidDevice State
       -       0        0        0      removed
       1       8       17        1      active sync   /dev/sdb1

       2       8        1        -      faulty   /dev/sda1

```

### Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.

```bash
root@ubuntu2004:/home/vagrant# dmesg
[ 2685.781247] md/raid1:md0: Disk failure on sda1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.
```

### Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

```bash
root@ubuntu2004:/home/vagrant# gzip -t /tmp/new/test.gz
root@ubuntu2004:/home/vagrant# echo $?
0
```

### Погасите тестовый хост, vagrant destroy.

```zsh
root@ubuntu2004:/home/vagrant# exit
vagrant@ubuntu2004:~$ logout
Connection to 192.168.121.29 closed.
┌[vladimir☮ubuntu]-(~/vagrant)
└> vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Clearing any previously set forwarded ports...
==> default: Removing domain...
```