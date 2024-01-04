# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM rockylinux:9

RUN yum -y install dnf-plugins-core langpacks-de langpacks-en langpacks-es langpacks-fr langpacks-it glibc-langpack-en
RUN dnf config-manager --set-enabled crb

RUN yum -y install --nogpgcheck \
	"https://docker.rhubarb.geek.nz/yum/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-rpm-gpg-key.rpm" \
	"https://docker.rhubarb.geek.nz/yum/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-yum.rpm"

RUN yum -y install rhubarb-pi-ssh-host rhubarb-pi-user-rogerb aedit

RUN mkdir /var/run/sshd
RUN rm -rf /run/nologin

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
