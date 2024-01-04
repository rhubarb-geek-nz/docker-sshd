# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM debian:bookworm as builder
WORKDIR /tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl qemu-utils qemu-efi

RUN curl --silent \
		--location \
		--fail \
		https://mirrorservice.org/sites/ftp.netbsd.org/pub/NetBSD/NetBSD-9.3/evbarm-aarch64/binary/gzimg/arm64.img.gz | gunzip > /mnt/boot.raw

RUN qemu-img convert -f raw -O qcow2 /mnt/boot.raw /mnt/boot.img

RUN qemu-img resize -f qcow2 /mnt/boot.img +5G

FROM alpine:3.19
WORKDIR /tmp

RUN apk add qemu-system-aarch64

COPY --from=builder /mnt/boot.img /mnt/boot.img

COPY --from=builder /usr/share/qemu-efi/QEMU_EFI.fd /mnt/QEMU_EFI.fd

EXPOSE 22

CMD ["qemu-system-aarch64", \
	"-machine", "virt", \
	"-smp", "2", \
	"-cpu", "cortex-a57", \
	"-nographic", \
	"-m", "2048M", \
	"-bios", "/mnt/QEMU_EFI.fd", \
	"-device", "virtio-net-device,netdev=eth0", \
	"-netdev", "user,id=eth0,hostfwd=tcp::22-:22", \
	"-device", "virtio-rng-pci", \
	"-drive", "file=/mnt/boot.img,format=qcow2,if=virtio" \
]
