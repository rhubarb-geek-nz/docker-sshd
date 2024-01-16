# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM raspbian12
WORKDIR /tmp

RUN mkdir -p /boot/firmware

RUN grep /boot/firmware /etc/fstab

RUN grep -v /boot/firmware /etc/fstab | dd of=/etc/fstab.fix && mv /etc/fstab.fix /etc/fstab

RUN mv /usr/bin/systemd-detect-virt /usr/bin/systemd-detect-virt.disabled && ln -s true /usr/bin/systemd-detect-virt

RUN DEBIAN_FRONTEND=noninteractive dpkg --purge $( dpkg-query -W -f='${binary:Package}\n' "*:arm64" )

RUN rm /usr/bin/systemd-detect-virt && mv /usr/bin/systemd-detect-virt.disabled /usr/bin/systemd-detect-virt

RUN apt-get update --allow-releaseinfo-change && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl
RUN curl --output rhubarb-pi-apt.deb --fail --location "https://docker.rhubarb.geek.nz/apt/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-apt.deb" && \
    dpkg -i rhubarb-pi-apt.deb && \
    rm rhubarb-pi-apt.deb
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y rhubarb-pi-ssh-host rhubarb-pi-user-rogerb aedit rhubarb-pi-locales
RUN echo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

RUN rm /etc/ssh/sshd_config.d/rename_user.conf

RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
