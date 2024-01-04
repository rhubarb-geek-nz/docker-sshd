# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM arm32v5/debian:bullseye
WORKDIR /tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl

RUN curl --output rhubarb-pi-apt.deb --silent --fail --location "https://docker.rhubarb.geek.nz/apt/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-apt.deb" && \
    DEBIAN_FRONTEND=noninteractive dpkg -i rhubarb-pi-apt.deb && \
    rm rhubarb-pi-apt.deb

RUN curl --output packages-microsoft-prod.deb --silent --fail --location "https://packages.microsoft.com/config/$( . /etc/os-release ; echo $ID/$VERSION_ID )/packages-microsoft-prod.deb" && \
    DEBIAN_FRONTEND=noninteractive dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y rhubarb-pi-ssh-host rhubarb-pi-user-rogerb aedit rhubarb-pi-locales

RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
