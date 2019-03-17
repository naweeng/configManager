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
