#!/bin/bash

set -e
set -x

#Temp password
#password='dummypassword'


###### Copying File ############
fetch_file_details()
{
    file=$1
    dst_ip=$2
    file_detail=$(sshpass -p $password ssh root@$dst_ip -p 2222 "stat -c '%U %G %a' $file && cksum $file")
    req_file_detail=$(echo $file_detail | awk '{ print $1,$2,$3,$4}')
}


file_copy()
{
    src=$1
    dst=$2
    owner=$3
    group=$4
    perm=$5
    dst_ip=$6
    sshpass -p $password ssh root@$dst_ip -p 2222 "stat $dst"
    file_exists=$?
    if [ $file_exists -eq 0 ]
    then
        fetch_file_details $dst $dst_ip
        cur_owner=$(echo $req_file_detail | awk '{print $1}')
        cur_group=$(echo $req_file_detail | awk '{print $2}')
        cur_perm=$(echo $req_file_detail | awk '{print $3}')
        cur_cksum=$(echo $req_file_detail | awk '{print $4}')
        if [ $cur_cksum != $(cksum $src | awk '{print $1}') ]
        then
            scp -P 2222 $src root@$dst_ip:$dst
            content_state='changed'
        else
            content_state='ok'
        fi
        if [[ $cur_owner != $owner ]] || [[ $cur_group != $group ]]
        then
            sshpass -p $password ssh root@$dst_ip -p 2222 "chown $owner:$group $dst"
            owner_state='changed'
        else
            owner_state='ok'
        fi
        if [ $cur_perm != $perm ]
        then
            sshpass -p $password ssh root@$dst_ip -p 2222 "chmod $perm $dst"
            perm_state='changed'
        else
            perm_state='ok'
        fi
    else
        scp -P 2222 $src root@$dst_ip:$dst
        overall_state='changed'
    fi
    ###### State reporting #######
    if [[ $overall_state = 'changed' ]] || [[ $perm_state = 'changed' ]] || [[ $owner_state = 'changed' ]] || [[ $content_state = 'changed' ]];
    then
        echo "File Copy State: Changed"
    elif [[ $overall_state = 'ok' ]] || [[ $perm_state = 'ok' ]] || [[ $owner_state = 'ok' ]] || [[ $content_state = 'ok' ]];
    then
        echo "File Copy State: OK"
    else
        echo "File Copy State: Unknown"
    fi
}


file_copy 'test' '/home/vagrant/test' 'vagrant' 'vagrant' '644' '127.0.0.1'


##### Installing Package #########

check_if_package()
{

}

install_package()
{

}