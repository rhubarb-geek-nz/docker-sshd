# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM opensuse/leap:15.2
WORKDIR /tmp

RUN zypper install --no-confirm curl

RUN curl --fail --location --output rhubarb-pi-rpm-gpg-key.rpm "https://docker.rhubarb.geek.nz/yum/$( . /etc/os-release; echo $ID/$VERSION_ID)/rhubarb-pi-rpm-gpg-key.rpm" && \
	rpm --install rhubarb-pi-rpm-gpg-key.rpm && \
	rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rhubarb-geek-nz && \
	rm rhubarb-pi-rpm-gpg-key.rpm

RUN curl --fail --location --output rhubarb-pi-yum.rpm "https://docker.rhubarb.geek.nz/yum/$( . /etc/os-release; echo $ID/$VERSION_ID)/rhubarb-pi-yum.rpm" && \
	rpm --install rhubarb-pi-yum.rpm && \
	rm rhubarb-pi-yum.rpm

RUN zypper install --no-confirm rhubarb-pi-ssh-host rhubarb-pi-user-rogerb aedit

RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
