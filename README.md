# devops-netology

## Домашнее задание к занятию «2.4. Инструменты Git»

### Скопировать репозиторий 
```
┌[kisa☮kisa-Lenovo-G40-30]-(~)
└> git clone git@github.com:hashicorp/terraform.git
Клонирование в «terraform»…
remote: Enumerating objects: 251168, done.
remote: Counting objects: 100% (134/134), done.
remote: Compressing objects: 100% (106/106), done.
remote: Total 251168 (delta 67), reused 53 (delta 28), pack-reused 251034
Получение объектов: 100% (251168/251168), 185.24 МиБ | 3.42 МиБ/с, готово.
Определение изменений: 100% (155708/155708), готово.
┌[kisa☮kisa-Lenovo-G40-30]-(~)
└> cd terraform 
┌[kisa☮kisa-Lenovo-G40-30]-(~/terraform)-[git://main ✔]-
└> 
```

### Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.

1. Комментарий: ```Update CHANGELOG.md```
2. Полная хеш-функция коммита: ```aefead2207ef7e2aa5dc81a34aedf0cad4c32545```

Как получил:
```
┌[kisa☮kisa-Lenovo-G40-30]-(~/terraform)-[git://main ✔]-
└> git rev-list --format=%B --max-count=1 aefea
commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Update CHANGELOG.md
┌[kisa☮kisa-Lenovo-G40-30]-(~/terraform)-[git://main ✔]-
└> 
```
Альтернативный вариант:
```
┌[kisa☮kisa-Lenovo-G40-30]-(~/terraform)-[git://main ✔]-
└> git show aefea

commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Jun 18 10:29:58 2020 -0400

    Update CHANGELOG.md

diff --git a/CHANGELOG.md b/CHANGELOG.md
index 86d70e3e0..588d807b1 100644
--- a/CHANGELOG.md
+++ b/CHANGELOG.md
@@ -27,6 +27,7 @@ BUG FIXES:
 * backend/s3: Prefer AWS shared configuration over EC2 metadata credentials by default ([#25134](https://github.com/hashicorp/terraform/issues/25134))
 * backend/s3: Prefer ECS credentials over EC2 metadata credentials by default ([#25134](https://github.com/hashicorp/terraform/issues/25134))
 * backend/s3: Remove hardcoded AWS Provider messaging ([#25134](https://github.com/hashicorp/terraform/issues/25134))
+* command: Fix bug with global `-v`/`-version`/`--version` flags introduced in 0.13.0beta2 [GH-25277]
 * command/0.13upgrade: Fix `0.13upgrade` usage help text to include options ([#25127](https://github.com/hashicorp/terraform/issues/25127))
 * command/0.13upgrade: Do not add source for builtin provider ([#25215](https://github.com/hashicorp/terraform/issues/25215))
 * command/apply: Fix bug which caused Terraform to silently exit on Windows when using absolute plan path ([#25233](https://github.com/hashicorp/terraform/issues/25233))
(END)

```

### Какому тегу соответствует коммит 85024d3?

Тег соответсвующий коммиту `v0.12.23`

Как получил:
```
[kisa☮kisa-Lenovo-G40-30]-(~/terraform)-[git://main ✔]-
└> git tag --points-at=85024d3

v0.12.23
(END)
```

## Сколько родителей у коммита b8d720? Напишите их хеши.

у коммита `b8d720` 2 родителя:
```
56cd7859e05c36c06b56d013b55a252d0bb7e158
9ea88f22fc6269854151c571162c5bcf958bee2b
```

как получил:
```
git show b8d720^1
commit 56cd7859e05c36c06b56d013b55a252d0bb7e158
***
git show b8d720^2
commit 9ea88f22fc6269854151c571162c5bcf958bee2b
***
[kisa☮kisa-Lenovo-G40-30]-(~/terraform)-[git://main ✔]-
└> git show b8d720^3
fatal: неоднозначный аргумент «b8d720^3»: неизвестная редакция или не путь в рабочем каталоге.

```

## Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.

Между тегами v0.12.23 и v0.12.24 10 коммитов включая коммит с тегом v0.12.24, а именно:
```
33ff1c03b v0.12.24
b14b74c49 [Website] vmc provider links
3f235065b Update CHANGELOG.md
6ae64e247 registry: Fix panic when server is unreachable
5c619ca1b website: Remove links to the getting started guide's old location
06275647e Update CHANGELOG.md
d5f9411f5 command: Fix bug when using terraform login on Windows
4b6d06cc5 Update CHANGELOG.md
dd01a3507 Update CHANGELOG.md
225466bc3 Cleanup after v0.12.23 release
```
Как получил:

```
┌[kisa☮kisa-Lenovo-G40-30]-(~/terraform)-[git://main ✔]-
└> git log v0.12.23..v0.12.24 --oneline

33ff1c03b (tag: v0.12.24) v0.12.24
b14b74c49 [Website] vmc provider links
3f235065b Update CHANGELOG.md
6ae64e247 registry: Fix panic when server is unreachable
5c619ca1b website: Remove links to the getting started guide's old location
06275647e Update CHANGELOG.md
d5f9411f5 command: Fix bug when using terraform login on Windows
4b6d06cc5 Update CHANGELOG.md
dd01a3507 Update CHANGELOG.md
225466bc3 Cleanup after v0.12.23 release
```

## Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).

Функция была создана в коммите: ```8c928e83589d90a031f811fae52a81be7153e82f```

Как получил:
```
[kisa☮kisa-Lenovo-G40-30]-(~/terraform)-[git://main ✔]-
└> git log -S'func providerSource(' --pretty=format:"%H"

8c928e83589d90a031f811fae52a81be7153e82f
```

Проверяем:
```
git show 8c928e83589d90a031f811fae52a81be7153e82f


***
+
+// providerSource constructs a provider source based on a combination of the
+// CLI configuration and some default search locations. This will be the
+// provider source used for provider installation in the "terraform init"
+// command, unless overridden by the special -plugin-dir option.
+func providerSource(services *disco.Disco) getproviders.Source {
+       // We're not yet using the CLI config here because we've not implemented
+       // yet the new configuration constructs to customize provider search
+       // locations. That'll come later.
+       // For now, we have a fixed set of search directories:
+       // - The "terraform.d/plugi
***
```

## Найдите все коммиты в которых была изменена функция globalPluginDirs.

Функция globalPluginDirs была изменена в следующих коммитах:
```
78b12205587fe839f10d946ea3fdc06719decb05
52dbf94834cb970b510f2fba853a5b49ad9b1a46
41ab0aef7a0fe030e84018973a64135b11abcd70
66ebff90cdfaa6938f26f908c7ebad8d547fea17
```

В следующем коммите была создана:
```
8364383c359a6b738a436d1b7745ccdce178df47
```

Как нашел:
```
┌[kisa☮kisa-Lenovo-G40-30]-(~/terraform)-[git://main ✔]-
└> git grep globalPluginDirs

commands.go:            GlobalPluginDirs: globalPluginDirs(),
commands.go:    helperPlugins := pluginDiscovery.FindPlugins("credentials", globalPluginDirs())
internal/command/cliconfig/config_unix.go:              // FIXME: homeDir gets called from globalPluginDirs during init, before
plugins.go:// globalPluginDirs returns directories that should be searched for
plugins.go:func globalPluginDirs() []string {

┌[kisa☮kisa-Lenovo-G40-30]-(~/terraform)-[git://main ✔]-
└> git log -L':globalPluginDirs:plugins.go' 
```

## Кто автор функции synchronizedWriters?

Функцию **synchronizedWriters** добавил **Martin Atkins \<mart@degeneration.co.uk\>**

Как нашел:

```
git log -S'synchronizedWriters( --oneline'

bdfea50cc remove unused
fd4f7eb0b remove prefixed io
5ac311e2a main: synchronize writes to VT100-faker on Windows

git show 5ac311e2a

commit 5ac311e2a91e381e2f52234668b49ba670aa0fe5
Author: Martin Atkins <mart@degeneration.co.uk>
Date:   Wed May 3 16:25:41 2017 -0700
***
+
+// synchronizedWriters takes a set of writers and returns wrappers that ensure
+// that only one write can be outstanding at a time across the whole set.
+func synchronizedWriters(targets ...io.Writer) []io.Writer {
+       mutex := &sync.Mutex{}

```