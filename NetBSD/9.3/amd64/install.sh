#!/bin/sh -e
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

IMAGE=boot-com.iso
SOURCE=https://mirrorservice.org/sites/ftp.netbsd.org/pub/NetBSD/NetBSD-9.3/amd64
TGZ=tar.xz

trap 'if test -w install.iso
then
	rm install.iso
fi
rm -rf *.$TGZ' 0

if test ! -f install.iso
then
	echo "$IMAGE ..."
	curl --location --fail --silent "$SOURCE/installation/cdrom/$IMAGE" --output install.iso
fi

ls -ld install.iso

if test -w install.iso
then
	MAPPINGS=

	for d in base comp etc games kern-GENERIC man misc modules rescue tests text xbase xcomp xetc xfont xserver
	do
		TAR="$d.$TGZ"

		if test ! -f "$TAR"
		then
			echo "$TAR ..."
			curl --location --fail --silent "$SOURCE/binary/sets/$TAR" --output "$TAR"
		fi

		MAPPINGS="$MAPPINGS -map $TAR /amd64/binary/sets/$TAR"
	done

	xorriso -boot_image any keep \
        -dev install.iso \
		$MAPPINGS

	rm *.$TGZ

	chmod -w install.iso
fi

ls -ld install.iso

qemu-img create -f qcow2 root.img 16G

qemu-system-x86_64 \
	-boot d \
	-m 256 \
	-hda root.img \
	-cdrom install.iso \
	-nographic \
	-netdev user,id=net0 \
	-device e1000,netdev=net0
