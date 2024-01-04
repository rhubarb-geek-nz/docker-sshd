# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM debian:bookworm as builder
WORKDIR /tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl xz-utils cloud-image-utils qemu-utils opensbi u-boot-qemu 

RUN curl --silent \
		--location \
		--fail \
		https://cdimage.ubuntu.com/releases/22.04.2/release/ubuntu-22.04.3-preinstalled-server-riscv64+unmatched.img.xz | unxz > /mnt/boot.img

RUN qemu-img convert -f raw -O qcow2 /mnt/boot.img /mnt/boot.qcow2 && mv /mnt/boot.qcow2 /mnt/boot.img

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

RUN echo 'instance-id: d702b057-9071-44ed-8acc-741a41896116\n\
local-hostname: jammy' > metadata.yaml

RUN cloud-localds /mnt/seed.img user-data.yaml metadata.yaml

FROM alpine:3.19
WORKDIR /tmp

RUN apk add qemu-system-riscv64

COPY --from=builder /mnt/boot.img /mnt/boot.img

COPY --from=builder /mnt/seed.img /mnt/seed.img

COPY --from=builder /usr/lib/u-boot/qemu-riscv64_smode/uboot.elf /mnt/uboot.elf

COPY --from=builder /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.bin /mnt/fw_jump.bin

EXPOSE 22

CMD ["qemu-system-riscv64", \
	"-machine", "virt", \
	"-nographic", \
	"-m", "2048", \
	"-smp", "4", \
	"-bios", "/mnt/fw_jump.bin", \
	"-kernel", "/mnt/uboot.elf", \
	"-device", "virtio-net-device,netdev=eth0", \
	"-netdev", "user,id=eth0,hostfwd=tcp::22-:22", \
	"-device", "virtio-rng-pci", \
	"-drive", "file=/mnt/boot.img,format=qcow2,if=virtio", \
	"-drive", "if=virtio,format=raw,file=/mnt/seed.img" \
]
