#!/bin/sh -e
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

qemu-system-aarch64 \
	-machine virt \
	-smp 2 \
	-cpu cortex-a57 \
	-nographic \
	-m 2048M \
	-bios /usr/share/qemu-efi/QEMU_EFI.fd \
	-netdev user,id=net0,hostfwd=tcp::8022-:22 \
	-device e1000,netdev=net0 \
	-device virtio-rng-pci \
	-drive file=root.img,format=qcow2,if=virtio
