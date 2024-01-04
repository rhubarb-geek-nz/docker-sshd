# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM raspbian7
WORKDIR /tmp

RUN while read N; do echo "# $N"; done < /etc/apt/sources.list > /tmp/sources.list

RUN echo deb http://archive.debian.org/debian/ wheezy contrib main non-free >> /tmp/sources.list

RUN mv /tmp/sources.list /etc/apt/sources.list

RUN rm /etc/apt/sources.list.d/raspi.list

RUN rm /etc/apt/sources.list.d/*

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B48AD6246925553

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6FB2A1C265FFB764

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y debian-archive-keyring apt-transport-https ca-certificates curl 

RUN mkdir /usr/share/ca-certificates/letsencrypt.org

RUN curl --insecure --fail --location "https://letsencrypt.org/certs/isrgrootx1.pem" --output /usr/share/ca-certificates/letsencrypt.org/isrgrootx1.crt
RUN echo letsencrypt.org/isrgrootx1.crt >> /etc/ca-certificates.conf

RUN sed -i '/^mozilla\/DST_Root_CA_X3/s/^/!/' /etc/ca-certificates.conf && update-ca-certificates -f

RUN echo 'Acquire::https::docker.rhubarb.geek.nz::Verify-Peer "false";' > /etc/apt/apt.conf.d/99docker.rhubarb.geek.nz-cert

RUN curl --output rhubarb-pi-apt.deb --insecure --fail --location "https://docker.rhubarb.geek.nz/apt/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-apt.deb" && \
    dpkg -i rhubarb-pi-apt.deb && \
    rm rhubarb-pi-apt.deb

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y rhubarb-pi-user-rogerb aedit rhubarb-pi-locales

RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure openssh-server

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
