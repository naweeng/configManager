# configer

The idea is to create a minimal config manager.

The configer currently supports 2 major modules.

1. Copy File
2. Manage Package


### Installation:
```
install_path=/opt/configer
shell_configuration=$HOME/.bashrc

git clone <git-url> $install_path
echo 'export PATH=$PATH:'$installation_path'/bin' >> $shell_configuration
```

### Usage:

### Expected Files:
bootstrap.sh (if you have some dependency to solve)

#### copy:

```
configer copy -s source_file -d destination_file -o file_owner -g file_group -p file_perm -t target_hosts -n service_name
```


#### package

```
configer package -s state(default:install; install/remove) -p package_name -v version_no
```


#### Example Usage:

```
mkdir web_project
cd web_project
touch bootstrap.sh
echo "apt-get install -y php='1:7.2+60ubuntu1'" >> bootstrap.sh
```



Create hello.php file and insert the following contents:
```
<?php

header("Content-Type: text/plain");

echo "Hello, world!\n";
```

Once the files are in place run the following commands:
```
configer package -u root -p '<your_password>' -s install -p apache2 -v '2.4.29-1ubuntu4.5'

configer copy -s hello.php -d /var/www/html/hello.php -o root -g root -p 644 -t ip1,ip2 -n
```