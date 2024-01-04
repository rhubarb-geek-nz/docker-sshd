# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM debian:bookworm as builder
WORKDIR /tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y qemu-efi

FROM alpine:3.19
WORKDIR /tmp

RUN apk add qemu-system-aarch64

COPY --from=builder /usr/share/qemu-efi/QEMU_EFI.fd /mnt/QEMU_EFI.fd

COPY root.img /mnt/root.img

EXPOSE 22

CMD ["qemu-system-aarch64", \
	"-machine", "virt", \
	"-smp", "2", \
	"-cpu", "cortex-a57", \
	"-nographic", \
	"-m", "2048M", \
	"-bios", "/mnt/QEMU_EFI.fd", \
	"-device", "e1000,netdev=net0", \
	"-netdev", "user,id=net0,hostfwd=tcp::22-:22", \
	"-device", "virtio-rng-pci", \
	"-drive", "file=/mnt/root.img,format=qcow2,if=virtio" \
]
