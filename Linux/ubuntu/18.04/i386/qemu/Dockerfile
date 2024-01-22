# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM debian:bookworm as builder
WORKDIR /tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl cloud-image-utils qemu-utils qemu-efi

RUN curl --silent --fail --location http://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-i386.img --output /mnt/boot.img

RUN qemu-img resize -f qcow2 /mnt/boot.img +5G

RUN echo '#cloud-config\n\
ssh_authorized_keys:\n\
  - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBoGwSyfP8g6fuzt7ND/LeL31b1hZXVbt5pklXoprae5 ubuntu\n\
runcmd:\n\
  - curl --fail --location --silent --output /run/rhubarb-pi-apt.deb https://docker.rhubarb.geek.nz/apt/$( . /etc/os-release ; echo $ID/$VERSION_ID )/rhubarb-pi-apt.deb\n\
  - dpkg -i /run/rhubarb-pi-apt.deb\n\
  - rm /run/rhubarb-pi-apt.deb\n\
  - DEBIAN_FRONTEND=noninteractive apt update\n\
  - DEBIAN_FRONTEND=noninteractive apt install -y aedit rhubarb-pi-user-rogerb rhubarb-pi-ssh-host' > user-data.yaml

RUN echo 'instance-id: 9f7172a0-dd65-4df0-8630-b239ce669a8c\n\
local-hostname: bionic' > metadata.yaml

RUN cloud-localds /mnt/seed.img user-data.yaml metadata.yaml

FROM alpine:3.19
WORKDIR /tmp

RUN apk add qemu-system-i386

COPY --from=builder /mnt/boot.img /mnt/boot.img

COPY --from=builder /mnt/seed.img /mnt/seed.img

EXPOSE 22

CMD ["qemu-system-i386", \
	"-nographic", \
	"-m", "1024", \
	"-hda", "/mnt/boot.img", \
	"-cdrom", "/mnt/seed.img", \
	"-netdev", "user,id=net0,hostfwd=tcp::22-:22", \
	"-device", "e1000,netdev=net0" \
]
