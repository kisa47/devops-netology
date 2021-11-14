# devops-netology

## Домашнее задание к занятию "3.1. Работа в терминале, лекция 1"

### Установите средство виртуализации Oracle VirtualBox.

```sudo apt-get install virtualbox```

### Установите средство автоматизации Hashicorp Vagrant.

```sudo apt-get install vagrant```

### Ознакомьтесь с графическим интерфейсом VirtualBox, посмотрите как выглядит виртуальная машина, которую создал для вас Vagrant, какие аппаратные ресурсы ей выделены. Какие ресурсы выделены по-умолчанию?

- RAM - 1024mb
- vCPU- 2
- HDD - 64Gb SATA vdisk
- Тип адаптера - NAT (драйвер e1000)

### Ознакомьтесь с возможностями конфигурации VirtualBox через Vagrantfile: документация. Как добавить оперативной памяти или ресурсов процессора виртуальной машине?

Для того чтобы добавить vCPU или RAM нужно в **Vagrantfile** добавить ```config.vm.provider``` и соответсвующие параметры.

```
 Vagrant.configure("2") do |config|
        config.vm.box = "bento/ubuntu-20.04"
        config.vm.provider "virtualbox" do |v|
             v.memory = 8000
             v.cpus = 6
        end
 end
```

### Какой переменной можно задать длину журнала history, и на какой строчке manual это описывается?

Кол-во записей в истории можно указать в переменной **HISTSIZE**, например:
```
vim ~/.bashrc

HISTSIZE=1000
```
В мануале описано тут:

```
#779
HISTSIZE
              The number of commands to remember in the command history (see HISTORY below).  If the value is 0, commands are not saved in
              the history list.  Numeric values less than zero result in every command being saved  on  the  history  list  (there  is  no
              limit).  The shell sets the default value to 500 after reading any startup files.

```

### что делает директива ignoreboth в bash?

директива **ignoreboth** является сокращением для одновременного использования **ignorespace** и **ignoredups**. 
**ignorespace** - не сохранять в истории команды начинающиеся с пробела
**ignoredups** - не выполнять сохранения повторяющихся команд

Использование:
```
echo "HISTCONTROL=ignoreboth" >>~/.bashrc
```
В мануале:

```
#755
A colon-separated list of values controlling how commands are saved on the history list.  If the list of values includes ig
              norespace, lines which begin with a space character are not saved in the history list.  A value of ignoredups  causes  lines
              matching  the previous history entry to not be saved.  A value of ignoreboth is shorthand for ignorespace and ignoredups.  A
              value of erasedups causes all previous lines matching the current line to be removed from the history list before that  line
              is  saved.   Any  value  not  in the above list is ignored.  If HISTCONTROL is unset, or does not include a valid value, all
              lines read by the shell parser are saved on the history list, subject to the value of HISTIGNORE.  The second and subsequent
              lines of a multi-line compound command are not tested, and are added to the history regardless of the value of HISTCONTROL.
```

### В каких сценариях использования применимы скобки {} и на какой строчке man bash это описано?

Группировка команд, например:
```
{ echo 1; echo 2;} || echo 0
1
2
```
Списки, например {1,2,3} или {0..100}, например:
```
echo {1,2,3}
1 2 3
```

Подстановка значений параметров:
```
echo ${TEST[@]}
```

В мануале :
```
#238
SHELL GRAMMAR
    Compound Commands
        { list; }
              list  is  simply  executed  in the current shell environment.  list must be terminated with a newline or semicolon.  This is
              known as a group command.  The return status is the exit status of list.  Note that unlike the metacharacters ( and ), { and
              }  are  reserved  words  and must occur where a reserved word is permitted to be recognized.  Since they do not cause a word
              break, they must be separated from list by whitespace or another shell metacharacter.

#988
Brace Expansion
       Brace expansion is a mechanism by which arbitrary strings may be generated.  This mechanism is similar to pathname  expansion,  but
       the  filenames generated need not exist.  Patterns to be brace expanded take the form of an optional preamble, followed by either a
       series of comma-separated strings or a sequence expression between a pair of braces, followed by an optional postscript.  The  pre‐
       amble is prefixed to each string contained within the braces, and the postscript is then appended to each resulting string, expand‐
       ing left to right.

       Brace expansions may be nested.  The results of each expanded string are not sorted; left to right order is preserved.   For  exam‐
       ple, a{d,c,b}e expands into `ade ace abe'.

       A  sequence expression takes the form {x..y[..incr]}, where x and y are either integers or single characters, and incr, an optional
       increment, is an integer.  When integers are supplied, the expression expands to each number between x and y, inclusive.   Supplied
       integers  may  be  prefixed with 0 to force each term to have the same width.  When either x or y begins with a zero, the shell at‐
       tempts to force all generated terms to contain the same number of digits, zero-padding where necessary.  When characters  are  sup‐
       plied,  the  expression  expands  to each character lexicographically between x and y, inclusive, using the default C locale.  Note
       that both x and y must be of the same type.  When the increment is supplied, it is used as the difference between each  term.   The
       default increment is 1 or -1 as appropriate.

       Brace  expansion  is performed before any other expansions, and any characters special to other expansions are preserved in the re‐
       sult.  It is strictly textual.  Bash does not apply any syntactic interpretation to the context of the expansion or  the  text  be‐
       tween the braces.

#1052
Parameter Expansion
       The `$' character introduces parameter expansion, command substitution, or arithmetic expansion.  The parameter name or  symbol  to
       be  expanded may be enclosed in braces, which are optional but serve to protect the variable to be expanded from characters immedi‐
       ately following it which could be interpreted as part of the name.

       When braces are used, the matching ending brace is the first `}' not escaped by a backslash or within  a  quoted  string,  and  not
       within an embedded arithmetic expansion, command substitution, or parameter expansion.

       ${parameter}
              The  value of parameter is substituted.  The braces are required when parameter is a positional parameter with more than one
              digit, or when parameter is followed by a character which is not to be interpreted as part of its name.  The parameter is  a
              shell parameter as described above PARAMETERS) or an array reference (Arrays).

       If  the first character of parameter is an exclamation point (!), and parameter is not a nameref, it introduces a level of indirec‐
       tion.  Bash uses the value formed by expanding the rest of parameter as the new parameter; this is then expanded and that value  is
       used  in the rest of the expansion, rather than the expansion of the original parameter.  This is known as indirect expansion.  The
       value is subject to tilde expansion, parameter expansion, command substitution,  and  arithmetic  expansion.   If  parameter  is  a
       nameref,  this  expands to the name of the parameter referenced by parameter instead of performing the complete indirect expansion.
       The exceptions to this are the expansions of ${!prefix*} and ${!name[@]} described below.  The exclamation point  must  immediately
       follow the left brace in order to introduce indirection.
```

### С учётом ответа на предыдущий вопрос, как создать однократным вызовом touch 100000 файлов? Получится ли аналогичным образом создать 300000? Если нет, то почему?

```
mkdir test && cd test
touch {0-100000} 
```

300000 можно выполнить только увеличив максимальный размер стэка если это возможно

```
ulimit -aH
-s: stack size (kbytes)             unlimited


ulimit -s 300000
touch {0-300000}
```

### В man bash поищите по /\[\[. Что делает конструкция [[ -d /tmp ]]

 конструкция [[ -d /tmp ]] действует аналогично ```test -f /tmp``` т.е. проеверяет, существует ли файл /tmp, если существует код выхода $?=0 если нет, то $?=1.

### Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе type -a bash в виртуальной машине
```
PATH=/tmp/new_path_directory:$PATCH
mkdir -p /tmp/new_path_directory
ln -s /bin/bash /tmp/new_path_directory/bash

type -a bash
bash is /tmp/new_path_directory/bash
bash is /usr/bin/bash
bash is /bin/bash
```

### Чем отличается планирование команд с помощью batch и at?

at выполняет задачу в заданное время, а batch при снижении нагрузки ниже заданного или дефолтного значения 1,5.

