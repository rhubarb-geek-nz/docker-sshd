#!/bin/sh -e
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

if test ! -f install.img
then
	curl --location --fail --silent "https://cloudflare.cdn.openbsd.org/pub/OpenBSD/7.4/arm64/install74.img" --output install.img

	chmod -w install.img
fi

qemu-img create -f qcow2 root.img 16G

qemu-system-aarch64 \
	-machine virt \
	-smp 2 \
	-cpu cortex-a57 \
	-nographic \
	-m 2048M \
	-bios /usr/share/qemu-efi/QEMU_EFI.fd \
	-netdev user,id=net0 \
	-device e1000,netdev=net0 \
	-device virtio-rng-pci \
	-drive file=install.img,format=raw,if=virtio,readonly=on \
	-drive file=root.img,format=qcow2,if=virtio
