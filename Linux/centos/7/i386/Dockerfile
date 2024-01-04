# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM i386/centos:7
WORKDIR /tmp

RUN sed -i '/^override_install_langs=en_US.UTF-8/s/^/# /' /etc/yum.conf

RUN yum update -y glibc-common

RUN yum -y install dnf-plugins-core langpacks-de langpacks-es langpacks-fr langpacks-it

RUN yum -y install --nogpgcheck \
	"https://docker.rhubarb.geek.nz/yum/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-rpm-gpg-key.rpm" \
	"https://docker.rhubarb.geek.nz/yum/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-yum.rpm"

RUN yum -y install rhubarb-pi-ssh-host rhubarb-pi-user-rogerb aedit

RUN mkdir /var/run/sshd
RUN rm -rf /run/nologin

EXPOSE 22
CMD ["/bin/setarch", "i686", "/usr/sbin/sshd", "-D"]
