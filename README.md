# devops-netology

## Курсовая работа по итогам модуля "DevOps и системное администрирование"

### Процесс установки и настройки ufw

```bash
vagrant@ubuntu2004:~$ sudo apt-get install ufw
Reading package lists... Done
Building dependency tree       
Reading state information... Done
ufw is already the newest version (0.36-6).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
vagrant@ubuntu2004:~$ sudo ufw default deny incoming
Default incoming policy changed to 'deny'
(be sure to update your rules accordingly)
vagrant@ubuntu2004:~$ sudo ufw default allow outgoing
Default outgoing policy changed to 'allow'
(be sure to update your rules accordingly)
vagrant@ubuntu2004:~$ sudo ufw allow 22
Rules updated
Rules updated (v6)
vagrant@ubuntu2004:~$ sudo ufw allow 443
Rules updated
Rules updated (v6)
vagrant@ubuntu2004:~$ sudo ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup
vagrant@ubuntu2004:~$ sudo ufw status verbose 
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22                         ALLOW IN    Anywhere                  
443                        ALLOW IN    Anywhere                  
22 (v6)                    ALLOW IN    Anywhere (v6)             
443 (v6)                   ALLOW IN    Anywhere (v6)
```

## Процесс установки hashicorp vault

```bash
vagrant@ubuntu2004:~$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
OK
vagrant@ubuntu2004:~$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
Get:1 https://apt.releases.hashicorp.com focal InRelease [9,495 B]                                                                 
Get:2 https://apt.releases.hashicorp.com focal/main amd64 Packages [46.9 kB]                                                       
Get:3 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]                                  
Hit:4 http://us.archive.ubuntu.com/ubuntu focal InRelease                  
Get:5 http://us.archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
Get:6 http://security.ubuntu.com/ubuntu focal-security/main amd64 Packages [1,178 kB]
Get:7 http://us.archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
Get:8 http://us.archive.ubuntu.com/ubuntu focal-updates/main i386 Packages [597 kB]
Get:9 http://security.ubuntu.com/ubuntu focal-security/main i386 Packages [363 kB]
Get:10 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages [1,546 kB] 
Get:11 http://security.ubuntu.com/ubuntu focal-security/main Translation-en [210 kB]       
Get:12 http://security.ubuntu.com/ubuntu focal-security/main amd64 c-n-f Metadata [9,132 B]       
Get:13 http://security.ubuntu.com/ubuntu focal-security/restricted amd64 Packages [686 kB]         
Get:14 http://security.ubuntu.com/ubuntu focal-security/restricted i386 Packages [20.5 kB] 
Get:15 http://security.ubuntu.com/ubuntu focal-security/restricted Translation-en [97.9 kB]   
Get:16 http://security.ubuntu.com/ubuntu focal-security/restricted amd64 c-n-f Metadata [536 B]    
Get:17 http://security.ubuntu.com/ubuntu focal-security/universe i386 Packages [532 kB]            
Get:18 http://security.ubuntu.com/ubuntu focal-security/universe amd64 Packages [677 kB]           
Get:19 http://security.ubuntu.com/ubuntu focal-security/universe Translation-en [115 kB]           
Get:20 http://security.ubuntu.com/ubuntu focal-security/universe amd64 c-n-f Metadata [13.0 kB]          
Get:21 http://us.archive.ubuntu.com/ubuntu focal-updates/main Translation-en [299 kB]                    
Get:22 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 c-n-f Metadata [14.7 kB]
Get:23 http://us.archive.ubuntu.com/ubuntu focal-updates/restricted amd64 Packages [775 kB]
Get:24 http://security.ubuntu.com/ubuntu focal-security/multiverse i386 Packages [7,176 B]
Get:25 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 Packages [21.8 kB]  
Get:26 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 c-n-f Metadata [536 B]
Get:27 http://us.archive.ubuntu.com/ubuntu focal-updates/restricted i386 Packages [21.8 kB]  
Get:28 http://us.archive.ubuntu.com/ubuntu focal-updates/restricted Translation-en [111 kB]
Get:29 http://us.archive.ubuntu.com/ubuntu focal-updates/restricted amd64 c-n-f Metadata [532 B]
Get:30 http://us.archive.ubuntu.com/ubuntu focal-updates/universe i386 Packages [664 kB]
Get:31 http://us.archive.ubuntu.com/ubuntu focal-updates/universe amd64 Packages [894 kB]
Get:32 http://us.archive.ubuntu.com/ubuntu focal-updates/universe Translation-en [196 kB]
Get:33 http://us.archive.ubuntu.com/ubuntu focal-updates/universe amd64 c-n-f Metadata [20.1 kB]
Get:34 http://us.archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 Packages [24.8 kB]
Get:35 http://us.archive.ubuntu.com/ubuntu focal-updates/multiverse i386 Packages [8,432 B]
Get:36 http://us.archive.ubuntu.com/ubuntu focal-updates/multiverse Translation-en [6,928 B]
Get:37 http://us.archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 c-n-f Metadata [620 B]
Get:38 http://us.archive.ubuntu.com/ubuntu focal-backports/main amd64 Packages [42.0 kB]
Get:39 http://us.archive.ubuntu.com/ubuntu focal-backports/main i386 Packages [34.5 kB]
Get:40 http://us.archive.ubuntu.com/ubuntu focal-backports/main Translation-en [10.0 kB]
Get:41 http://us.archive.ubuntu.com/ubuntu focal-backports/main amd64 c-n-f Metadata [864 B]
Get:42 http://us.archive.ubuntu.com/ubuntu focal-backports/universe i386 Packages [11.4 kB]
Get:43 http://us.archive.ubuntu.com/ubuntu focal-backports/universe amd64 Packages [20.8 kB]
Get:44 http://us.archive.ubuntu.com/ubuntu focal-backports/universe Translation-en [14.3 kB]
Get:45 http://us.archive.ubuntu.com/ubuntu focal-backports/universe amd64 c-n-f Metadata [692 B]
Fetched 9,640 kB in 3s (3,346 kB/s)              
Reading package lists... Done
vagrant@ubuntu2004:~$ sudo apt-get update && sudo apt-get install vault
Get:1 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Hit:2 http://us.archive.ubuntu.com/ubuntu focal InRelease                                                                     
Hit:3 https://apt.releases.hashicorp.com focal InRelease                           
Hit:4 http://us.archive.ubuntu.com/ubuntu focal-updates InRelease
Hit:5 http://us.archive.ubuntu.com/ubuntu focal-backports InRelease
Fetched 114 kB in 1s (161 kB/s)
Reading package lists... Done
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  vault
0 upgraded, 1 newly installed, 0 to remove and 65 not upgraded.
Need to get 69.4 MB of archives.
After this operation, 188 MB of additional disk space will be used.
Get:1 https://apt.releases.hashicorp.com focal/main amd64 vault amd64 1.9.3 [69.4 MB]
Fetched 69.4 MB in 13s (5,215 kB/s)                                                                                                          
Selecting previously unselected package vault.
(Reading database ... 111108 files and directories currently installed.)
Preparing to unpack .../archives/vault_1.9.3_amd64.deb ...
Unpacking vault (1.9.3) ...
Setting up vault (1.9.3) ...
Generating Vault TLS key and self-signed certificate...
Generating a RSA private key
............++++
.............................................................................................................................................................................++++
writing new private key to 'tls.key'
-----
Vault TLS key and self-signed certificate have been generated in '/opt/vault/tls'.
vagrant@ubuntu2004:~$ vault
Usage: vault <command> [args]

Common commands:
    read        Read data and retrieves secrets
    write       Write data, configuration, and secrets
    delete      Delete secrets and configuration
    list        List data or secrets
    login       Authenticate locally
    agent       Start a Vault agent
    server      Start a Vault server
    status      Print seal and HA status
    unwrap      Unwrap a wrapped secret

Other commands:
    audit          Interact with audit devices
    auth           Interact with auth methods
    debug          Runs the debug command
    kv             Interact with Vault's Key-Value storage
    lease          Interact with leases
    monitor        Stream log messages from a Vault server
    namespace      Interact with namespaces
    operator       Perform operator-specific tasks
    path-help      Retrieve API help for paths
    plugin         Interact with Vault plugins and catalog
    policy         Interact with policies
    print          Prints runtime configurations
    secrets        Interact with secrets engines
    ssh            Initiate an SSH session
    token          Interact with tokens
```

## Процесс выпуска сертификата с помощью hashicorp vault

### Выпуск корневого сертефиката:



```bash
vagrant@ubuntu2004:~$ ==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Go Version: go1.17.5
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: inmem
                 Version: Vault v1.9.3
             Version Sha: 7dbdd57243a0d8d9d9e07cd01eb657369f8e1b8a

==> Vault server started! Log data will stream in below:

2022-02-01T19:18:54.634Z [INFO]  proxy environment: http_proxy="\"\"" https_proxy="\"\"" no_proxy="\"\""
2022-02-01T19:18:54.634Z [WARN]  no `api_addr` value specified in config or in VAULT_API_ADDR; falling back to detection if possible, but this value should be manually set
2022-02-01T19:18:54.634Z [INFO]  core: Initializing VersionTimestamps for core
2022-02-01T19:18:54.636Z [INFO]  core: security barrier not initialized
2022-02-01T19:18:54.636Z [INFO]  core: security barrier initialized: stored=1 shares=1 threshold=1
2022-02-01T19:18:54.636Z [INFO]  core: post-unseal setup starting
2022-02-01T19:18:54.638Z [INFO]  core: loaded wrapping token key
2022-02-01T19:18:54.638Z [INFO]  core: Recorded vault version: vault version=1.9.3 upgrade time="2022-02-01 19:18:54.638031688 +0000 UTC m=+0.037088236"
2022-02-01T19:18:54.638Z [INFO]  core: successfully setup plugin catalog: plugin-directory="\"\""
2022-02-01T19:18:54.638Z [INFO]  core: no mounts; adding default mount table
2022-02-01T19:18:54.639Z [INFO]  core: successfully mounted backend: type=cubbyhole path=cubbyhole/
2022-02-01T19:18:54.640Z [INFO]  core: successfully mounted backend: type=system path=sys/
2022-02-01T19:18:54.640Z [INFO]  core: successfully mounted backend: type=identity path=identity/
2022-02-01T19:18:54.643Z [INFO]  core: successfully enabled credential backend: type=token path=token/
2022-02-01T19:18:54.643Z [INFO]  core: restoring leases
2022-02-01T19:18:54.645Z [INFO]  expiration: lease restore complete
2022-02-01T19:18:54.645Z [INFO]  rollback: starting rollback manager
2022-02-01T19:18:54.645Z [INFO]  identity: entities restored
2022-02-01T19:18:54.645Z [INFO]  identity: groups restored
2022-02-01T19:18:54.646Z [INFO]  core: post-unseal setup complete
2022-02-01T19:18:54.646Z [INFO]  core: root token generated
2022-02-01T19:18:54.646Z [INFO]  core: pre-seal teardown starting
2022-02-01T19:18:54.646Z [INFO]  rollback: stopping rollback manager
2022-02-01T19:18:54.646Z [INFO]  core: pre-seal teardown complete
2022-02-01T19:18:54.646Z [INFO]  core.cluster-listener.tcp: starting listener: listener_address=127.0.0.1:8201
2022-02-01T19:18:54.646Z [INFO]  core.cluster-listener: serving cluster requests: cluster_listen_address=127.0.0.1:8201
2022-02-01T19:18:54.646Z [INFO]  core: post-unseal setup starting
2022-02-01T19:18:54.646Z [INFO]  core: loaded wrapping token key
2022-02-01T19:18:54.646Z [INFO]  core: successfully setup plugin catalog: plugin-directory="\"\""
2022-02-01T19:18:54.646Z [INFO]  core: successfully mounted backend: type=system path=sys/
2022-02-01T19:18:54.646Z [INFO]  core: successfully mounted backend: type=identity path=identity/
2022-02-01T19:18:54.646Z [INFO]  core: successfully mounted backend: type=cubbyhole path=cubbyhole/
2022-02-01T19:18:54.647Z [INFO]  core: successfully enabled credential backend: type=token path=token/
2022-02-01T19:18:54.647Z [INFO]  core: restoring leases
2022-02-01T19:18:54.647Z [INFO]  identity: entities restored
2022-02-01T19:18:54.647Z [INFO]  identity: groups restored
2022-02-01T19:18:54.647Z [INFO]  core: post-unseal setup complete
2022-02-01T19:18:54.647Z [INFO]  core: vault is unsealed
2022-02-01T19:18:54.648Z [INFO]  expiration: revoked lease: lease_id=auth/token/root/hc8d5c824ccb488983284f1fce4d73a7470101aca6d89665bd0c464e2823f3fb6
2022-02-01T19:18:54.650Z [INFO]  core: successful mount: namespace="\"\"" path=secret/ type=kv
2022-02-01T19:18:54.654Z [INFO]  expiration: lease restore complete
2022-02-01T19:18:54.654Z [INFO]  secrets.kv.kv_54ba8aee: collecting keys to upgrade
2022-02-01T19:18:54.654Z [INFO]  secrets.kv.kv_54ba8aee: done collecting keys: num_keys=1
2022-02-01T19:18:54.654Z [INFO]  secrets.kv.kv_54ba8aee: upgrading keys finished
2022-02-01T19:18:54.655Z [INFO]  rollback: starting rollback manager
WARNING! dev mode is enabled! In this mode, Vault runs entirely in-memory
and starts unsealed with a single unseal key. The root token is already
authenticated to the CLI, so you can immediately begin using Vault.

You may need to set the following environment variable:

    $ export VAULT_ADDR='http://127.0.0.1:8200'

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: f2J8xX74pLGqB8T/RNUV23x3/zzV0t0HM1XuuhV0EEs=
Root Token: root

Development mode should NOT be used in production installations!


[2]+  Done                     > /dev/null 2>&1
vagrant@ubuntu2004:~$ htop
vagrant@ubuntu2004:~$ export VAULT_ADDR=http://127.0.0.1:8200
vagrant@ubuntu2004:~$ export VAULT_TOKEN=root
vagrant@ubuntu2004:~$ vault secrets enable pki
2022-02-01T19:19:57.798Z [INFO]  core: successful mount: namespace="\"\"" path=pki/ type=pki
Success! Enabled the pki secrets engine at: pki/
vagrant@ubuntu2004:~$ vault secrets tune -max-lease-ttl=87600h pki
2022-02-01T19:20:11.761Z [INFO]  core: mount tuning of leases successful: path=pki/
Success! Tuned the secrets engine at: pki/
vagrant@ubuntu2004:~$ vault write -field=certificate pki/root/generate/internal common_name="devops.com" ttl=87600h > CA_cert.crt
vagrant@ubuntu2004:~$ vault write pki/config/urls issuing_certificates="$VAULT_ADDR/v1/pki/ca"  crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
Success! Data written to: pki/config/urls
```

### Промежуточный сертефикат

``` bash
vault secrets enable -path=pki_int pki
2022-02-01T19:25:54.865Z [INFO]  core: successful mount: namespace="\"\"" path=pki_int/ type=pki
Success! Enabled the pki secrets engine at: pki_int/
vagrant@ubuntu2004:~$ vault secrets tune -max-lease-ttl=43800h pki_int
2022-02-01T19:26:09.094Z [INFO]  core: mount tuning of leases successful: path=pki_int/
Success! Tuned the secrets engine at: pki_int/
vagrant@ubuntu2004:~$ vault write -format=json pki_int/intermediate/generate/internal common_name="devops.com Intermediate Authority" | jq -r '.data.csr' > pki_intermediate.csr
vagrant@ubuntu2004:~$ vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr  format=pem_bundle ttl="43800h"  | jq -r '.data.certificate' > intermediate.cert.pem
vagrant@ubuntu2004:~$ vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem
Success! Data written to: pki_int/intermediate/set-signed
```

### Создаем Роль

```bash
vault write pki_int/roles/devops-dot-com allowed_domains="devops.com" allow_subdomains=true max_ttl="720h"
Success! Data written to: pki_int/roles/devops-dot-com
```

### Создаем сертефикат

```bash
vagrant@ubuntu2004:~$ vault write pki_int/issue/devops-dot-com common_name="test.devops.com" ttl="720h" > test.devops.com.crt
```

### Добавляем сертефикат в доверенные

```bash
┌[kisa☮kisa-Lenovo-G40-30]-(~)
└> sudo cp CA_cert.crt /usr/local/share/ca-certificates/
[sudo] пароль для kisa: 
┌[kisa☮kisa-Lenovo-G40-30]-(~)
└> sudo update-ca-certificates
Updating certificates in /etc/ssl/certs...
1 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.
```

## Процесс установки и настройки сервера nginx

### Установка nginx

```bash
vagrant@ubuntu2004:~$ sudo apt-get install nginx
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  fontconfig-config fonts-dejavu-core libfontconfig1 libgd3 libjbig0 libjpeg-turbo8 libjpeg8 libnginx-mod-http-image-filter
  libnginx-mod-http-xslt-filter libnginx-mod-mail libnginx-mod-stream libtiff5 libwebp6 libxpm4 nginx-common nginx-core
Suggested packages:
  libgd-tools fcgiwrap nginx-doc ssl-cert
The following NEW packages will be installed:
  fontconfig-config fonts-dejavu-core libfontconfig1 libgd3 libjbig0 libjpeg-turbo8 libjpeg8 libnginx-mod-http-image-filter
  libnginx-mod-http-xslt-filter libnginx-mod-mail libnginx-mod-stream libtiff5 libwebp6 libxpm4 nginx nginx-common nginx-core
0 upgraded, 17 newly installed, 0 to remove and 65 not upgraded.
Need to get 2,432 kB of archives.
After this operation, 7,891 kB of additional disk space will be used.
Do you want to continue? [Y/n] 
Get:1 http://us.archive.ubuntu.com/ubuntu focal/main amd64 fonts-dejavu-core all 2.37-1 [1,041 kB]
Get:2 http://us.archive.ubuntu.com/ubuntu focal/main amd64 fontconfig-config all 2.13.1-2ubuntu3 [28.8 kB]
Get:3 http://us.archive.ubuntu.com/ubuntu focal/main amd64 libfontconfig1 amd64 2.13.1-2ubuntu3 [114 kB]
Get:4 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 libjpeg-turbo8 amd64 2.0.3-0ubuntu1.20.04.1 [117 kB]
Get:5 http://us.archive.ubuntu.com/ubuntu focal/main amd64 libjpeg8 amd64 8c-2ubuntu8 [2,194 B]
Get:6 http://us.archive.ubuntu.com/ubuntu focal/main amd64 libjbig0 amd64 2.1-3.1build1 [26.7 kB]
Get:7 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 libwebp6 amd64 0.6.1-2ubuntu0.20.04.1 [185 kB]
Get:8 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 libtiff5 amd64 4.1.0+git191117-2ubuntu0.20.04.2 [162 kB]
Get:9 http://us.archive.ubuntu.com/ubuntu focal/main amd64 libxpm4 amd64 1:3.5.12-1 [34.0 kB]
Get:10 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 libgd3 amd64 2.2.5-5.2ubuntu2.1 [118 kB]
Get:11 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 nginx-common all 1.18.0-0ubuntu1.2 [37.5 kB]
Get:12 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 libnginx-mod-http-image-filter amd64 1.18.0-0ubuntu1.2 [14.4 kB]
Get:13 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 libnginx-mod-http-xslt-filter amd64 1.18.0-0ubuntu1.2 [12.7 kB]
Get:14 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 libnginx-mod-mail amd64 1.18.0-0ubuntu1.2 [42.5 kB]
Get:15 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 libnginx-mod-stream amd64 1.18.0-0ubuntu1.2 [67.3 kB]
Get:16 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 nginx-core amd64 1.18.0-0ubuntu1.2 [425 kB]
Get:17 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 nginx all 1.18.0-0ubuntu1.2 [3,620 B]
Fetched 2,432 kB in 2s (1,377 kB/s)
Preconfiguring packages ...
Selecting previously unselected package fonts-dejavu-core.
(Reading database ... 111131 files and directories currently installed.)
Preparing to unpack .../00-fonts-dejavu-core_2.37-1_all.deb ...
Unpacking fonts-dejavu-core (2.37-1) ...
Selecting previously unselected package fontconfig-config.
Preparing to unpack .../01-fontconfig-config_2.13.1-2ubuntu3_all.deb ...
Unpacking fontconfig-config (2.13.1-2ubuntu3) ...
Selecting previously unselected package libfontconfig1:amd64.
Preparing to unpack .../02-libfontconfig1_2.13.1-2ubuntu3_amd64.deb ...
Unpacking libfontconfig1:amd64 (2.13.1-2ubuntu3) ...
Selecting previously unselected package libjpeg-turbo8:amd64.
Preparing to unpack .../03-libjpeg-turbo8_2.0.3-0ubuntu1.20.04.1_amd64.deb ...
Unpacking libjpeg-turbo8:amd64 (2.0.3-0ubuntu1.20.04.1) ...
Selecting previously unselected package libjpeg8:amd64.
Preparing to unpack .../04-libjpeg8_8c-2ubuntu8_amd64.deb ...
Unpacking libjpeg8:amd64 (8c-2ubuntu8) ...
Selecting previously unselected package libjbig0:amd64.
Preparing to unpack .../05-libjbig0_2.1-3.1build1_amd64.deb ...
Unpacking libjbig0:amd64 (2.1-3.1build1) ...
Selecting previously unselected package libwebp6:amd64.
Preparing to unpack .../06-libwebp6_0.6.1-2ubuntu0.20.04.1_amd64.deb ...
Unpacking libwebp6:amd64 (0.6.1-2ubuntu0.20.04.1) ...
Selecting previously unselected package libtiff5:amd64.
Preparing to unpack .../07-libtiff5_4.1.0+git191117-2ubuntu0.20.04.2_amd64.deb ...
Unpacking libtiff5:amd64 (4.1.0+git191117-2ubuntu0.20.04.2) ...
Selecting previously unselected package libxpm4:amd64.
Preparing to unpack .../08-libxpm4_1%3a3.5.12-1_amd64.deb ...
Unpacking libxpm4:amd64 (1:3.5.12-1) ...
Selecting previously unselected package libgd3:amd64.
Preparing to unpack .../09-libgd3_2.2.5-5.2ubuntu2.1_amd64.deb ...
Unpacking libgd3:amd64 (2.2.5-5.2ubuntu2.1) ...
Selecting previously unselected package nginx-common.
Preparing to unpack .../10-nginx-common_1.18.0-0ubuntu1.2_all.deb ...
Unpacking nginx-common (1.18.0-0ubuntu1.2) ...
Selecting previously unselected package libnginx-mod-http-image-filter.
Preparing to unpack .../11-libnginx-mod-http-image-filter_1.18.0-0ubuntu1.2_amd64.deb ...
Unpacking libnginx-mod-http-image-filter (1.18.0-0ubuntu1.2) ...
Selecting previously unselected package libnginx-mod-http-xslt-filter.
Preparing to unpack .../12-libnginx-mod-http-xslt-filter_1.18.0-0ubuntu1.2_amd64.deb ...
Unpacking libnginx-mod-http-xslt-filter (1.18.0-0ubuntu1.2) ...
Selecting previously unselected package libnginx-mod-mail.
Preparing to unpack .../13-libnginx-mod-mail_1.18.0-0ubuntu1.2_amd64.deb ...
Unpacking libnginx-mod-mail (1.18.0-0ubuntu1.2) ...
Selecting previously unselected package libnginx-mod-stream.
Preparing to unpack .../14-libnginx-mod-stream_1.18.0-0ubuntu1.2_amd64.deb ...
Unpacking libnginx-mod-stream (1.18.0-0ubuntu1.2) ...
Selecting previously unselected package nginx-core.
Preparing to unpack .../15-nginx-core_1.18.0-0ubuntu1.2_amd64.deb ...
Unpacking nginx-core (1.18.0-0ubuntu1.2) ...
Selecting previously unselected package nginx.
Preparing to unpack .../16-nginx_1.18.0-0ubuntu1.2_all.deb ...
Unpacking nginx (1.18.0-0ubuntu1.2) ...
Setting up libxpm4:amd64 (1:3.5.12-1) ...
Setting up nginx-common (1.18.0-0ubuntu1.2) ...
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /lib/systemd/system/nginx.service.
Setting up libjbig0:amd64 (2.1-3.1build1) ...
Setting up libnginx-mod-http-xslt-filter (1.18.0-0ubuntu1.2) ...
Setting up libwebp6:amd64 (0.6.1-2ubuntu0.20.04.1) ...
Setting up fonts-dejavu-core (2.37-1) ...
Setting up libjpeg-turbo8:amd64 (2.0.3-0ubuntu1.20.04.1) ...
Setting up libjpeg8:amd64 (8c-2ubuntu8) ...
Setting up libnginx-mod-mail (1.18.0-0ubuntu1.2) ...
Setting up fontconfig-config (2.13.1-2ubuntu3) ...
Setting up libnginx-mod-stream (1.18.0-0ubuntu1.2) ...
Setting up libtiff5:amd64 (4.1.0+git191117-2ubuntu0.20.04.2) ...
Setting up libfontconfig1:amd64 (2.13.1-2ubuntu3) ...
Setting up libgd3:amd64 (2.2.5-5.2ubuntu2.1) ...
Setting up libnginx-mod-http-image-filter (1.18.0-0ubuntu1.2) ...
Setting up nginx-core (1.18.0-0ubuntu1.2) ...
Setting up nginx (1.18.0-0ubuntu1.2) ...
Processing triggers for ufw (0.36-6) ...
Processing triggers for systemd (245.4-4ubuntu3.13) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
```

### конфиг nginx
```
vagrant@ubuntu2004:~$ cat /etc/nginx/sites-enabled/default 
server {
    listen 80 default_server;
    server_name test.devops.com www.test.devops.com;
    return 301 https://my_app.com$request_uri;
}

server {
        listen 443 ssl default_server;
        ssl_certificate     /etc/ssl/test.devops.com.crt;
        ssl_certificate_key     /etc/ssl/test.devops.com.crt;

        server_name test.devops.com www.test.devops.com;

        root /var/www/html;

        index index.html;

        server_name _;

        location / {
                try_files $uri $uri/ =404;
        }

}
```

Сертефикат:
```
vagrant@ubuntu2004:~$ cat /etc/ssl/devops.com.crt 
-----BEGIN CERTIFICATE-----
MIIDYzCCAkugAwIBAgIUVSXNCzeFVDA6eybT8qDLOEGyuNIwDQYJKoZIhvcNAQEL
BQAwLDEqMCgGA1UEAxMhZGV2b3BzLmNvbSBJbnRlcm1lZGlhdGUgQXV0aG9yaXR5
MB4XDTIyMDIwMTIwMzEwMloXDTIyMDMwMzIwMzEzMlowGjEYMBYGA1UEAxMPdGVz
dC5kZXZvcHMuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA/CSL
bZGPVpOylFqmhDqpiypw8UsRtZBSfF9dB9H61vGSvB19GFofIxokJx015LNEuOEk
Q2MfGEl0Cc9WU2jnW13AC3UjCa2Cm0ezMZY0VDHMEmv6smdZxYrRwAbMDMbrgQLf
rSpaCGdegEjsboMpjzcX3Y0J4wSna/rJnjUotxHfJJQRU6oz/SNtZ4rjK+Knydam
MkXy58ZSFHMWOKcPqf5qm/tOk06IPYOTsQlrhglDfZHDhbInO4WaxFs71PF4jK6/
TBl2Oj9LQRyo752FBMOs/Mutf0pQ6cKkpMyNOMH8H8sQjoeMAF6oo4QYyD+ngYxm
MlNt+Wo1kFGN2jfquwIDAQABo4GOMIGLMA4GA1UdDwEB/wQEAwIDqDAdBgNVHSUE
FjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwHQYDVR0OBBYEFM+cSPyVWIIXObF4lLSE
VFs3MmYAMB8GA1UdIwQYMBaAFDNEsUrsodsIRXJ6Op4UPbrZIvVwMBoGA1UdEQQT
MBGCD3Rlc3QuZGV2b3BzLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAB593kxTVOhKI
rHcpl0i//l9AuIhw2jGIGDaX4pDx2XRULhDtH3rZHD7NzUb1RlvrhZE5bGZF5j7A
B5YV5uSxFbav5+YB0DJWWe9t8OPYivyvBx3z/VbY/WiQuZFXdRs06pqhVRuNW+GU
JjnNgqfYUHyEudOOpFbRCumRgTchWpZDtiVw1+P6QpvX7GqABEBLSh9okFxGRmKu
bM2GyUSruibgM939h6BA6buXl9lbQ1hOTpHFGK7y7qNT/rNWjkuSx0TxGiNWg6sE
yiVEAD5QFicVHel2fLLuYHW5G4kkdf7QqL9B+1D1z+46YqX3P8mjB58w9sQroU/o
JPYvyUR++g==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDpDCCAoygAwIBAgIUNfyMZlOisdVrxpLNHICHdJJMxWQwDQYJKoZIhvcNAQEL
BQAwFTETMBEGA1UEAxMKZGV2b3BzLmNvbTAeFw0yMjAyMDExOTI4MTJaFw0yNzAx
MzExOTI4NDJaMCwxKjAoBgNVBAMTIWRldm9wcy5jb20gSW50ZXJtZWRpYXRlIEF1
dGhvcml0eTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALHtv3qTi7uC
bKKUzKw5ZYKQIl4InbSFbGMxDd32Jm78QNplv7bUR92zbxIGAVou6s363rJi7hER
eY/nK2DsJFh6eA6XPqGpr/TKIuLAcoUXY1iGecefTUUxi5jPepPw9DRVs+LcCObj
997kZajMRkkOfafiIbsIQuQ/XRgaBR7yvckx1s2HBoW0ELAJ/B65+OsG75EvzmIp
m1LWkq71OlKjSEqLX1E+D+MFNJOLgTXElzYv0LJaaCc1kSnINPpAoFtzqRijK9zv
IlmyS1O2jZGynKtuzxUgXgOkxcTWMuvLMQCB2HzW7HadlmK0Bb8bTxnuC4h+p1J6
xafOEar0L30CAwEAAaOB1DCB0TAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUw
AwEB/zAdBgNVHQ4EFgQUM0SxSuyh2whFcno6nhQ9utki9XAwHwYDVR0jBBgwFoAU
jEUvzw2bWUAUIGVcy6KhsiKQtg4wOwYIKwYBBQUHAQEELzAtMCsGCCsGAQUFBzAC
hh9odHRwOi8vMTI3LjAuMC4xOjgyMDAvdjEvcGtpL2NhMDEGA1UdHwQqMCgwJqAk
oCKGIGh0dHA6Ly8xMjcuMC4wLjE6ODIwMC92MS9wa2kvY3JsMA0GCSqGSIb3DQEB
CwUAA4IBAQC3OnohjBV3m4r56CT0EqknIvJjWRA5zZOAOVJMeR3Ke2MB0MbLx7is
vMyo3RWrRiDcOI3v96hRIKN0/p1fylSiQG0E8QS16PDg4W1ZI5gT/GnVMuA+FMNg
117s5Acewh0WwFkOq1qMZu8+kGLbIgaMLYn/S4b09Ej0T+gHG10WLe7oZM8IU/yB
/OpQXtbSzEQYCWZjmcPsyA5n0hB/Hj7AqKMieeBAQBlDwdUeN+2oHcZJNfFp4Kbs
sS7vOURmMlpZAs+Cpa5pZSmA10ZLaWU3Ts0/X2lS8v5crTZRmnkIAEWAadKvXxff
uHvR5WE5EI41bSwDi2isS49RgzWeNowy
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDpDCCAoygAwIBAgIUNfyMZlOisdVrxpLNHICHdJJMxWQwDQYJKoZIhvcNAQEL
BQAwFTETMBEGA1UEAxMKZGV2b3BzLmNvbTAeFw0yMjAyMDExOTI4MTJaFw0yNzAx
MzExOTI4NDJaMCwxKjAoBgNVBAMTIWRldm9wcy5jb20gSW50ZXJtZWRpYXRlIEF1
dGhvcml0eTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALHtv3qTi7uC
bKKUzKw5ZYKQIl4InbSFbGMxDd32Jm78QNplv7bUR92zbxIGAVou6s363rJi7hER
eY/nK2DsJFh6eA6XPqGpr/TKIuLAcoUXY1iGecefTUUxi5jPepPw9DRVs+LcCObj
997kZajMRkkOfafiIbsIQuQ/XRgaBR7yvckx1s2HBoW0ELAJ/B65+OsG75EvzmIp
m1LWkq71OlKjSEqLX1E+D+MFNJOLgTXElzYv0LJaaCc1kSnINPpAoFtzqRijK9zv
IlmyS1O2jZGynKtuzxUgXgOkxcTWMuvLMQCB2HzW7HadlmK0Bb8bTxnuC4h+p1J6
xafOEar0L30CAwEAAaOB1DCB0TAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUw
AwEB/zAdBgNVHQ4EFgQUM0SxSuyh2whFcno6nhQ9utki9XAwHwYDVR0jBBgwFoAU
jEUvzw2bWUAUIGVcy6KhsiKQtg4wOwYIKwYBBQUHAQEELzAtMCsGCCsGAQUFBzAC
hh9odHRwOi8vMTI3LjAuMC4xOjgyMDAvdjEvcGtpL2NhMDEGA1UdHwQqMCgwJqAk
oCKGIGh0dHA6Ly8xMjcuMC4wLjE6ODIwMC92MS9wa2kvY3JsMA0GCSqGSIb3DQEB
CwUAA4IBAQC3OnohjBV3m4r56CT0EqknIvJjWRA5zZOAOVJMeR3Ke2MB0MbLx7is
vMyo3RWrRiDcOI3v96hRIKN0/p1fylSiQG0E8QS16PDg4W1ZI5gT/GnVMuA+FMNg
117s5Acewh0WwFkOq1qMZu8+kGLbIgaMLYn/S4b09Ej0T+gHG10WLe7oZM8IU/yB
/OpQXtbSzEQYCWZjmcPsyA5n0hB/Hj7AqKMieeBAQBlDwdUeN+2oHcZJNfFp4Kbs
sS7vOURmMlpZAs+Cpa5pZSmA10ZLaWU3Ts0/X2lS8v5crTZRmnkIAEWAadKvXxff
uHvR5WE5EI41bSwDi2isS49RgzWeNowy
-----END CERTIFICATE-----
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEA/CSLbZGPVpOylFqmhDqpiypw8UsRtZBSfF9dB9H61vGSvB19
GFofIxokJx015LNEuOEkQ2MfGEl0Cc9WU2jnW13AC3UjCa2Cm0ezMZY0VDHMEmv6
smdZxYrRwAbMDMbrgQLfrSpaCGdegEjsboMpjzcX3Y0J4wSna/rJnjUotxHfJJQR
U6oz/SNtZ4rjK+KnydamMkXy58ZSFHMWOKcPqf5qm/tOk06IPYOTsQlrhglDfZHD
hbInO4WaxFs71PF4jK6/TBl2Oj9LQRyo752FBMOs/Mutf0pQ6cKkpMyNOMH8H8sQ
joeMAF6oo4QYyD+ngYxmMlNt+Wo1kFGN2jfquwIDAQABAoIBABqH/ePZnSuO/wt9
PmhLg+uQ27GIJKTmOse7gR6BidN0N+xzbeZSFVSsO4GiITmfY2vQxPASTgNQN1WQ
65R7RVzn0H1kJfuutj+Am+pr07XIR6Dom8iJ93hB0zBRhscRZ1Z75u1ht3eK6Pa2
taorQwQ+19QIMzIgGz3RdcWf8ljQ4yH5La792jHI2qZ9hTr/FPd99oYT+fhU025/
9h03fyElBu5Kzwq49kpZHr2gUMu+iTUJN/6t0o6a6z6PfYtWAC7j3DmyHAkj3puJ
JhrLUj7sPKIUsbA+FgkAkijayVq5jlrwf7GAjzT9PMH9Err1yKL+BxudqkwuTF8Q
9AVWQwECgYEA/+MSlvcBgLr4+FJcBRNgWBIz16dfo9aqOL1qbzgijpfIalvPdrGW
mgOa1DEaiMt+5SRlMEKp9j5vDyczbG06tcpxa02wKNPitRnp/pzTCcp1bOsTj3x1
gblLybCGL4sK7Cfq2Q0Tk05ACtocJGdMAwIyCAUR6NMcBL8M+zWhO2kCgYEA/EEM
eqcSFd7cL5zl9+oE/FFdYuJqwwcOmFNYEp1p6Unju9I5AnEpVzxOkrOkssN5jbuu
w6yK0X4SnazLS7yFCKpUrJXvU4QQRWVGzKCMOYLTdsbUfNzTY2sFlkxLoS+vmQIE
DdqJ7AQ4F5QtkhNrfZBUpbBYdx9z4xsE51jF5IMCgYBDCyisuyz+oH5o+ZM4lToR
+TryDt1lHPJeiWpgl5GeULBnBYUW8TKnSbiAThlIrCCkQuPsQBst9G++xaOYjgnq
5Y7P8XvtRo7IqnB/kHFOyGf50KHAX3ieM4Fi58hQnpqPA2pp0h5F4yOudDUZaKMm
yqV3KnTlzqIxsCjjjMqguQKBgErVOVCBk7ntPUDauNZNFGGN+bhGFwn4Y/oIb45G
KI9OnkKv4L26uFrqxxx6MpfdqYfEb9oYq63uSrN/+Wdka8rgTPJOIIuUGAeePdyi
nDbLetQ3s/2+vO83Zpbp113f+aXYlT9O36+mqMVF7ibxn+fGE3Z71CKyr/xlnZTM
HxjlAoGAHKyIGuiexWFxFyhs8nCOev/nfmjCjX9wDrm4ujCeNpb+CpDlJlDhF1ay
90jQnfR7JMTjij3yXXYH1YPLNK847TPPji/2P2fFbyA+y2v1tWAqUOvxmznCJp2i
zoESmrG1W3stoJ+2yp+MKf9XCyQRup+mXvExGR0q3BlQMwaY8iE=
-----END RSA PRIVATE KEY-----
```

ну и наконец стартуем вебсервер

```bash
vagrant@ubuntu2004:~$ sudo nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
vagrant@ubuntu2004:~$ sudo systemctl enable nginx
Synchronizing state of nginx.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable nginx
vagrant@ubuntu2004:~$ sudo systemctl start nginx
```

## Страница сервера nginx в браузере хоста не содержит предупреждений

на хостовой машине добавил СА сертефикат в доверенные и прописал в хостс следующую строку ```192.168.121.158 test.devops.com```

Ну и открыл в браузере:
![cert](assets/cert.png)

## Скрипт генерации нового сертификата работает (сертификат сервера ngnix должен быть "зеленым")

```bash
#!/bin/bash

export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

vault write pki_int/tidy tidy_cert_store=true tidy_revoked_certs=true

vault write -format=json pki_int/issue/devops-dot-com common_name="test.devops.com" ttl="720h" > test.devops.com.crt

jq -r .data.certificate < test.devops.com.crt > /etc/ssl/test.devops.com.crt
jq -r .data.issuing_ca < test.devops.com.crt >> /etc/ssl/test.devops.com.crt
jq -r .data.private_key < test.devops.com.crt >> /etc/ssl/test.devops.com.crt

systemctl restart nginx

unset VAULT_ADDR VAULT_TOKEN

rm test.devops.com.crt
```

## Поместите скрипт в crontab, чтобы сертификат обновлялся какого-то числа каждого месяца в удобное для вас время.

```bash
crontab -l
41 19 5 * * bash /usr/sbin/update_cert
```

![script](assets/script.png)
