# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM mcr.microsoft.com/dotnet/sdk:6.0-cbl-mariner2.0

RUN yum -y install --nogpgcheck \
	"https://docker.rhubarb.geek.nz/yum/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-rpm-gpg-key.rpm" \
	"https://docker.rhubarb.geek.nz/yum/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-yum.rpm"

RUN yum -y install rhubarb-pi-ssh-host rhubarb-pi-user-rogerb aedit

RUN mkdir /var/run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
