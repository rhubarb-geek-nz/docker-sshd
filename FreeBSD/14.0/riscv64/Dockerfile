# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM debian:bookworm as builder
WORKDIR /tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl xz-utils qemu-utils opensbi u-boot-qemu 

RUN curl --silent \
		--location \
		--fail \
		https://download.freebsd.org/releases/ISO-IMAGES/14.0/FreeBSD-14.0-RELEASE-riscv-riscv64-GENERICSD.img.xz | unxz > /mnt/boot.img

RUN qemu-img convert -f raw -O qcow2 /mnt/boot.img /mnt/boot.qcow2 && mv /mnt/boot.qcow2 /mnt/boot.img

RUN qemu-img resize -f qcow2 /mnt/boot.img +5G

FROM alpine:3.19
WORKDIR /tmp

RUN apk add qemu-system-riscv64

COPY --from=builder /mnt/boot.img /mnt/boot.img

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
	"-drive", "file=/mnt/boot.img,format=qcow2,if=virtio" \
]
