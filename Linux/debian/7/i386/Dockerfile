# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM i386/debian:wheezy
WORKDIR /tmp

RUN while read N; do echo "# $N"; done < /etc/apt/sources.list > /tmp/sources.list

RUN echo deb http://archive.debian.org/debian/ wheezy contrib main non-free >> /tmp/sources.list

RUN mv /tmp/sources.list /etc/apt/sources.list

RUN apt-get update

RUN apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl 

RUN mkdir /usr/share/ca-certificates/letsencrypt.org

RUN curl --insecure --fail --location "https://letsencrypt.org/certs/isrgrootx1.pem" --output /usr/share/ca-certificates/letsencrypt.org/isrgrootx1.crt

RUN echo letsencrypt.org/isrgrootx1.crt >> /etc/ca-certificates.conf

RUN sed -i '/^mozilla\/DST_Root_CA_X3/s/^/!/' /etc/ca-certificates.conf && update-ca-certificates -f

RUN curl --output rhubarb-pi-apt-gpg-key.deb --silent --fail --location "https://docker.rhubarb.geek.nz/apt/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-apt-gpg-key.deb" && \
    dpkg -i rhubarb-pi-apt-gpg-key.deb && \
    rm rhubarb-pi-apt-gpg-key.deb

RUN curl --output rhubarb-pi-apt.deb --silent --fail --location "https://docker.rhubarb.geek.nz/apt/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-apt.deb" && \
    dpkg -i rhubarb-pi-apt.deb && \
    rm rhubarb-pi-apt.deb

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y rhubarb-pi-user-rogerb aedit rhubarb-pi-locales openssh-server

RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
