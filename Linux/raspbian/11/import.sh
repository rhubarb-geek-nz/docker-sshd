#!/bin/sh -ex
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

IMGFILE="$HOME/images/2022-09-06-raspios-bullseye-armhf-lite.img"

ls -ld "$IMGFILE"

clean()
{
	if sudo umount /bullseye
	then
		echo umount success
	fi

	sudo partx -d -v /dev/loop0

	sudo losetup -d /dev/loop0
}

trap clean 0

if test ! -d /bullseye
then
	sudo mkdir /bullseye
fi

if test ! -f /bullseye/etc/os-release
then
	if test ! -e /dev/loop0p2
	then
		sudo partx -a -v "$IMGFILE"
	fi

	ls -ld /dev/loop0p2

	sudo mount -o ro,noload /dev/loop0p2 /bullseye
fi

ls -ld /bullseye/etc/os-release

echo Use bash to have a look at the file system and exit cleanly to create image

if ( set -e ; cd /bullseye ; bash )
then
	sudo tar -C /bullseye -c . | docker import - raspbian11
fi
