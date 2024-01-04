# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM agners/archlinuxarm
WORKDIR /tmp

RUN pacman pacman -Syu --noconfirm
RUN pacman -Sy --noconfirm grep

RUN grep -v NoExtract < /etc/pacman.conf > /etc/pacman.conf.NoExtract && mv /etc/pacman.conf.NoExtract /etc/pacman.conf

RUN echo $'en_US.UTF-8 UTF-8\n\
de_DE.UTF-8 UTF-8\n\
de_DE ISO-8859-1\n\
es_ES.UTF-8 UTF-8\n\
es_ES ISO-8859-1\n\
fr_FR.UTF-8 UTF-8\n\
fr_FR ISO-8859-1\n\
it_IT.UTF-8 UTF-8\n\ 
it_IT ISO-8859-1' > /etc/locale.gen

RUN pacman -Sy --noconfirm glibc

RUN pacman -Sy --noconfirm openssh sudo curl shadow awk systemd

RUN pacman-key --init

RUN curl --fail --location --output rhubarb-pi-pacman-1.0-1-any.pkg.tar.xz https://docker.rhubarb.geek.nz/pkg/archarm/aarch64/rhubarb/rhubarb-pi-pacman-1.0-1-any.pkg.tar.xz && \
    pacman --noconfirm -U rhubarb-pi-pacman-1.0-1-any.pkg.tar.xz && \
    rm rhubarb-pi-pacman-1.0-1-any.pkg.tar.xz

RUN pacman -Sy --noconfirm aedit rhubarb-pi-ssh-host rhubarb-pi-user-rogerb

RUN mkdir /var/run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
