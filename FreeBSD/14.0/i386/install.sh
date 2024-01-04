#!/bin/sh -e
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

IMAGE=FreeBSD-14.0-RELEASE-i386-disc1.iso.xz

trap "if test -w $IMAGE
then
	rm $IMAGE
fi
if test -w install.iso
then
	rm install.iso
fi" 0

if test ! -f "$IMAGE"
then
	curl --location --fail --silent "https://download.freebsd.org/releases/i386/i386/ISO-IMAGES/14.0/$IMAGE" --output "$IMAGE"

	chmod -w "$IMAGE"
fi

if test ! -f install.iso
then
	unxz < $IMAGE > install.iso

	xorriso -boot_image any keep \
        -dev install.iso \
        -map serial.conf /boot/loader.conf.d/serial.conf

	chmod -w install.iso
fi

qemu-img create -f qcow2 root.img 16G

qemu-system-i386 \
	-boot d \
	-m 256 \
	-hda root.img \
	-cdrom install.iso \
	-nographic \
	-netdev user,id=net0 \
	-device e1000,netdev=net0
