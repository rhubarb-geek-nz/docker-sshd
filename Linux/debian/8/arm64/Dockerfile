# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM jessie-arm64

RUN debootstrap/debootstrap --second-stage

RUN sed -i '/^mozilla\/DST_Root_CA_X3/s/^/!/' /etc/ca-certificates.conf && update-ca-certificates -f

RUN curl --output /tmp/rhubarb-pi-apt.deb --silent --fail --location "https://docker.rhubarb.geek.nz/apt/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-apt.deb" && \
    dpkg -i /tmp/rhubarb-pi-apt.deb && \
    rm /tmp/rhubarb-pi-apt.deb

RUN apt-get update && apt-get install -y rhubarb-pi-ssh-host rhubarb-pi-user-rogerb rhubarb-pi-locales aedit rhbtools

RUN mkdir /var/run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
