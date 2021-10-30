# devops-netology

## If i change this file his status will change to **Modified**

##Ignores:

###/.gitignore:

none

###/terraform/.gitignore:

Содержание фала:

```
**/.terraform/*
*.tfstate
*.tfstate.*
crash.log
*.tfvars
override.tf
override.tf.json
*_override.tf
*_override.tf.json
.terraformrc
terraform.rc
```

Что игнорируется:

1. Все файлы в директориях **.terraform** независимо от расположения директории **.terraform** 

2. Все файлы заканчивающиеся или содержащие в названии **.tfstatr** в данной директории (```/terraform```)

3. **crash.log** в данной директории

4. Все файлы заканчивающиеся на **.tfvars** в данной директории 

5. Файлы **override.tf.json** и **override.tf** в данной директории

6. Все файлы заканчивающиеся на **_override.tf.** и **_override.tf.json** в данной директории

7. Файлы **.terraformrc** и **terraform.rc** в данной директории


