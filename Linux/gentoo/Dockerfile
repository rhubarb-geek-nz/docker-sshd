# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM gentoo/portage:latest as portage

FROM gentoo/stage3

COPY --from=gentoo/portage:latest /var/db/repos/gentoo /var/db/repos/gentoo

WORKDIR /tmp

RUN emerge app-admin/sudo
RUN emerge dev-vcs/git

RUN echo $'en_US.UTF-8 UTF-8\n\
de_DE.UTF-8 UTF-8\n\
de_DE ISO-8859-1\n\
de_DE@euro ISO-8859-15\n\
es_ES.UTF-8 UTF-8\n\
es_ES ISO-8859-1\n\
es_ES@euro ISO-8859-15\n\
fr_FR.UTF-8 UTF-8\n\
fr_FR ISO-8859-1\n\
fr_FR@euro ISO-8859-15\n\
it_IT.UTF-8 UTF-8\n\
it_IT@euro ISO-8859-15\n\ 
it_IT ISO-8859-1' >> /etc/locale.gen && locale-gen

RUN mkdir /etc/portage/repos.conf && \
	echo $'# created by eselect-repo\n\
[rhubarb-geek-nz]\n\
location = /var/db/repos/rhubarb-geek-nz\n\
sync-type = git\n\
sync-uri = https://github.com/rhubarb-geek-nz/portage.git' >> /etc/portage/repos.conf/eselect-repo.conf && \
	git clone https://github.com/rhubarb-geek-nz/portage.git /var/db/repos/rhubarb-geek-nz

RUN emerge app-editors/aedit

RUN curl --fail --location https://docker.rhubarb.geek.nz/pkg/gentoo/rhubarb-pi-ssh-host.tar.bz2 | tar xvfj - -C /

RUN useradd -m -d /home/rogerb -g users -G wheel rogerb && \
    usermod -p '*' rogerb

RUN curl --fail --location https://docker.rhubarb.geek.nz/pkg/gentoo/rhubarb-pi-user-rogerb.tar.bz2 | tar xvfj - -C /

RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
