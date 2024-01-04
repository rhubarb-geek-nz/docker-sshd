#!/bin/sh -ex
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

IMGFILE="$HOME/images/2019-04-08-raspbian-stretch-lite.img"

ls -ld "$IMGFILE"

clean()
{
	if sudo umount /stretch
	then
		echo umount success
	fi

	sudo partx -d -v /dev/loop0

	sudo losetup -d /dev/loop0
}

trap clean 0

if test ! -d /stretch
then
	sudo mkdir /stretch
fi

if test ! -f /stretch/etc/os-release
then
	if test ! -e /dev/loop0p2
	then
		sudo partx -a -v "$IMGFILE"
	fi

	ls -ld /dev/loop0p2

	sudo mount -o ro,noload /dev/loop0p2 /stretch
fi

ls -ld /stretch/etc/os-release

echo Use bash to have a look at the file system and exit cleanly to create image

if ( set -e ; cd /stretch ; bash )
then
	sudo tar -C /stretch -c . | docker import - raspbian9
fi
