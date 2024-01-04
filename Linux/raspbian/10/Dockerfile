# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM raspbian10
WORKDIR /tmp

RUN apt-get update --allow-releaseinfo-change && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN curl --output rhubarb-pi-apt.deb --silent --fail --location "https://docker.rhubarb.geek.nz/apt/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-apt.deb" && \
    dpkg -i rhubarb-pi-apt.deb && \
    rm rhubarb-pi-apt.deb
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y rhubarb-pi-ssh-host rhubarb-pi-user-rogerb aedit rhubarb-pi-locales

RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
