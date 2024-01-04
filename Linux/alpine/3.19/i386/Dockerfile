# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM i386/alpine:3.19
WORKDIR /tmp

RUN wget https://docker.rhubarb.geek.nz/pkg/$(. /etc/os-release; echo $ID/$VERSION_ID | sed y/\./\ / | while read A B C; do echo $A.$B; done )/rhubarb-pi-apk-keys-1.0-r0.apk && \
    apk add --allow-untrusted rhubarb-pi-apk-keys-1.0-r0.apk && \
    rm rhubarb-pi-apk-keys-1.0-r0.apk

RUN wget https://docker.rhubarb.geek.nz/pkg/$(. /etc/os-release; echo $ID/$VERSION_ID | sed y/\./\ / | while read A B C; do echo $A.$B; done )/rhubarb-pi-apk-1.0-r0.apk && \
    apk add rhubarb-pi-apk-1.0-r0.apk && \
    rm rhubarb-pi-apk-1.0-r0.apk

RUN apk update
RUN apk add bash aedit rhubarb-pi-ssh-host rhubarb-pi-user-rogerb

RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
