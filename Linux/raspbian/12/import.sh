#!/bin/sh -ex
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

IMGFILE="$HOME/images/2023-12-11-raspios-bookworm-armhf-lite.img"

ls -ld "$IMGFILE"

clean()
{
	if sudo umount /bookworm
	then
		echo umount success
	fi

	sudo partx -d -v /dev/loop0

	sudo losetup -d /dev/loop0
}

trap clean 0

if test ! -d /bookworm
then
	sudo mkdir /bookworm
fi

if test ! -f /bookworm/etc/os-release
then
	if test ! -e /dev/loop0p2
	then
		sudo partx -a -v "$IMGFILE"
	fi

	ls -ld /dev/loop0p2

	sudo mount -o ro,noload /dev/loop0p2 /bookworm
fi

ls -ld /bookworm/etc/os-release

echo Use bash to have a look at the file system and exit cleanly to create image

if ( set -e ; cd /bookworm ; bash )
then
	sudo tar -C /bookworm -c . | docker import - raspbian12
fi
