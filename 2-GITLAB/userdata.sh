#! /bin/bash

#MONTADO DE DISCO
########################
#SISTEMA DE ARCHIVOS
sudo apt-get install xfsprogs
#FORMATE DE DISCO
sudo mkfs -t xfs /dev/nvme1n1
#MONTADO DE RUTA
mount /dev/nvme1n1 /opt/
#MONTADO AUTOMATICO DE DISCO
sudo echo -e "/dev/nvme1n1        /opt       xfs   defaults    0 0" >> /etc/fstab

    # sudo apt-get update
    # sudo apt-get install -y curl openssh-server ca-certificates tzdata
    # curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
    # sudo apt-get install -y gitlab-ee
    sudo apt-get update -y
    sudo apt install -y ca-certificates curl openssh-server
    curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

    sudo apt -y install gitlab-ce

    #sudo apt -y install gitlab-ce=9.3.9-ce.0

    # Cambia URL del dominio de gitlab

    sed -i 's%http://gitlab.example.com%http://test2gitlabxyz.glr.pe%g' /etc/gitlab/gitlab.rb


    # Luego del cambio mandamos a reconfigurar
    gitlab-ctl reconfigure


    apt install awscli -y


    #! /bin/bash
    memory_limit = 2048M
    sed -i s%memory_limit = 1024M%memory_limit = 2048M%g /etc/php.ini