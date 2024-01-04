# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM dokken/centos-stream-9
WORKDIR /tmp

RUN dnf update -y

RUN dnf -y install dnf-plugins-core langpacks-de langpacks-es langpacks-fr langpacks-it epel-release
RUN dnf config-manager --set-enabled crb

RUN dnf -y install --nogpgcheck \
	"https://docker.rhubarb.geek.nz/yum/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-rpm-gpg-key.rpm" \
	"https://docker.rhubarb.geek.nz/yum/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-yum.rpm"

RUN dnf -y install rhubarb-pi-ssh-host rhubarb-pi-user-rogerb aedit

RUN mkdir /var/run/sshd
RUN rm -rf /run/nologin

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
