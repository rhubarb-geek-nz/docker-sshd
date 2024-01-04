# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM ubuntu:14.04
WORKDIR /tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl 
RUN update-ca-certificates

RUN sed -i '/^mozilla\/DST_Root_CA_X3/s/^/!/' /etc/ca-certificates.conf && update-ca-certificates -f

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server language-pack-fr language-pack-de language-pack-es language-pack-it language-pack-en

RUN curl --output rhubarb-pi-apt-gpg-key.deb --silent --fail --location "https://docker.rhubarb.geek.nz/apt/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-apt-gpg-key.deb" && \
    dpkg -i rhubarb-pi-apt-gpg-key.deb && \
    rm rhubarb-pi-apt-gpg-key.deb
RUN curl --output rhubarb-pi-apt.deb --silent --fail --location "https://docker.rhubarb.geek.nz/apt/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-apt.deb" && \
    dpkg -i rhubarb-pi-apt.deb && \
    rm rhubarb-pi-apt.deb

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y rhubarb-pi-user-rogerb aedit

RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
