# devops-netology

## 3.2. Работа в терминале, лекция 2

### Какого типа команда cd?

```cd``` - это встроенная команда. Так как это базовая необходимая для взаимодействия с системой. Без нее было бы сложно выполнять многие действия, а некоторые даже невозможно.

```
type cd
cd is a shell builtin
```

### Какая альтернатива без pipe команде grep <some_string> <some_file> | wc -l?

Альтернатива: ```grep -c <some_string> <some_file>``` 

Проверка: 
```
grep -i 1 .bashrc | wc -l
13
grep -c 1 .bashrc 
13
grep 2 .bashrc | wc -l
4
grep -c 2 .bashrc 
4
```

### Какой процесс с PID 1 является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?

Процессом с PID = 1 является ```systemd```. Это система инициализации в Linux. Она запускает все остальные процессы.

### Как будет выглядеть команда, которая перенаправит вывод stderr ls на другую сессию терминала?

Команда перенаправляющая stderr на другую сессию терминала: ```ls /root 2> /dev/pts/2```

### Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.

Команда: ```cat > testfile_1 < testfile```

Проверка:

```
echo 12345 > testfile
cat > testfile_1 < testfile
cat testfile_1
12345
```

### Получится ли находясь в графическом режиме, вывести данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?

Да

```
tty
/dev/pts/2
ls > /dev/tty4
```
и обратно
```
tty 
/dev/tty4
ls > /dev/pts/2
```

### Выполните команду bash 5>&1. К чему она приведет? Что будет, если вы выполните echo netology > /proc/$$/fd/5? Почему так происходит?

Результатом выполнения команды ```bash 5>&1``` будет запуск нового процесса bash с доступным файловым дискриптером 5 у которого родительским будет предыдующий bash. 

### Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty? Напоминаем: по умолчанию через pipe передается только stdout команды слева от | на stdin команды справа. Это можно сделать, поменяв стандартные потоки местами через промежуточный новый дескриптор, который вы научились создавать в предыдущем вопросе.

```
ls /root/ 2>&1 1>&5 | grep denied
ls: cannot open directory '/root/': Permission denied

ls / 2>&1 1>&5 | grep denied
bin  boot  dev  etc  home  lib  lib32  lib64  libx32  lost+found  media  mnt  opt  proc  root  run  sbin  snap  srv  sys  tmp  usr  var
```

Если нужно оменять местами, то:

```
ls / 5>&2 2>&1 1>&5
```

### Что выведет команда cat /proc/$$/environ? Как еще можно получить аналогичный по содержанию вывод?

```cat /proc/$$/environ``` показывает заданные переменные оболочки. Еще можно посмотреть их выполнив команду ```env```

### Используя man, опишите что доступно по адресам /proc/<PID>/cmdline, /proc/<PID>/exe

```/proc/<PID>/cmdline``` - только на чтение, содержит команду и аргументы запуска файла. У зомби пустой.

```/proc/<PID>/exe``` - символьная ссылка на на испольняемый файл, который образует данный процесс.

### Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью /proc/cpuinfo

sse4.2

```
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq vmx ssse3 fma cx16 pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch cpuid_fault invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves arat umip md_clear arch_capabilities
```

### При открытии нового окна терминала и vagrant ssh создается новая сессия и выделяется pty. Это можно подтвердить командой tty, которая упоминалась в лекции 3.2. Почитайте, почему так происходит, и как изменить поведение.

```
vagrant@netology1:~$ ssh localhost 'tty'
not a tty
``` 

```
ssh -t localhost 'tty'
/dev/pts/2
```

Это происходит, потому что выполнение командпо SSH  в отличае от подключения не образуют терминальгую сессию.

### Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись reptyr. Например, так можно перенести в screen процесс, который вы запустили по ошибке в обычной SSH-сессии.

```
tty
/dev/pts/0
mc &
```

```
/dev/pts/1
screen
sudo reptyr -T 5061
```

### sudo echo string > /root/new_file не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без sudo под вашим пользователем. Для решения данной проблемы можно использовать конструкцию echo string | sudo tee /root/new_file. Узнайте что делает команда tee и почему в отличие от sudo echo команда с sudo tee будет работать.

Команда ```echo``` вывыодит на stdout текст переданный в качестве аругумента. ```sudo echo string > file``` мы перенаправляем вывод в файл, но не от имени **root**. От **root** выполнется только сама echo. ```sudo tee``` же пишет в один или несколько файлов от имении **root** (когда sudo) то, что пришло на **stdin**, а также в **stdout** дублирует то, что записывается.  













