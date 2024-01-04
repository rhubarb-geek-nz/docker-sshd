#!/bin/sh -ex
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

IMGFILE="$HOME/images/2017-07-05-raspbian-jessie-lite.img"

ls -ld "$IMGFILE"

clean()
{
	if sudo umount /jessie
	then
		echo umount success
	fi

	sudo partx -d -v /dev/loop0

	sudo losetup -d /dev/loop0
}

trap clean 0

if test ! -d /jessie
then
	sudo mkdir /jessie
fi

if test ! -f /jessie/etc/os-release
then
	if test ! -e /dev/loop0p2
	then
		sudo partx -a -v "$IMGFILE"
	fi

	ls -ld /dev/loop0p2

	sudo mount -o ro,noload /dev/loop0p2 /jessie
fi

ls -ld /jessie/etc/os-release

echo Use bash to have a look at the file system and exit cleanly to create image

if ( set -e ; cd /jessie ; bash )
then
	sudo tar -C /jessie -c . | docker import - raspbian8
fi
