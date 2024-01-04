#!/bin/sh -e
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

trap 'rm -rf boot.conf
if test -w install.iso
then
	rm install.iso
fi' 0

if test ! -f install.iso
then
	curl --location --fail --silent "https://cloudflare.cdn.openbsd.org/pub/OpenBSD/7.4/amd64/install74.iso" --output install.iso

	(
		set -e
		echo set tty com0
		echo set image /bsd.rd
	) > boot.conf

	xorriso -boot_image any keep \
		-dev install.iso \
		-map boot.conf /etc/boot.conf \
		-clone /7.4/amd64/cdboot /cdboot \
		-clone /7.4/amd64/bsd.rd /bsd.rd

	chmod -w install.iso
fi

qemu-img create -f qcow2 root.img 16G

qemu-system-x86_64 \
	-boot d \
	-m 256 \
	-hda root.img \
	-cdrom install.iso \
	-nographic \
	-netdev user,id=net0 \
	-device e1000,netdev=net0
