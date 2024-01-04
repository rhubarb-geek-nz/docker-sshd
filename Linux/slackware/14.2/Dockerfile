# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM vbatts/slackware:14.2
WORKDIR /tmp

RUN slackpkg update gpg
RUN slackpkg update
RUN slackpkg install openssh
RUN slackpkg install sudo
RUN slackpkg install perl
RUN slackpkg install ca-certificates
RUN /usr/sbin/update-ca-certificates --fresh

RUN wget https://docker.rhubarb.geek.nz/pkg/slackware/14.2/rhubarb-pi-ssh-host-1.0-noarch-126_slack14.2.txz && \
    installpkg rhubarb-pi-ssh-host-1.0-noarch-126_slack14.2.txz && \
    rm rhubarb-pi-ssh-host-1.0-noarch-126_slack14.2.txz

RUN wget https://docker.rhubarb.geek.nz/pkg/slackware/14.2/rhubarb-pi-user-rogerb-1.0-noarch-128_slack14.2.txz && \
    installpkg rhubarb-pi-user-rogerb-1.0-noarch-128_slack14.2.txz && \
    rm rhubarb-pi-user-rogerb-1.0-noarch-128_slack14.2.txz

RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
