#!/bin/sh -ex
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

IMGFILE="$HOME/images/2020-02-13-raspbian-buster-lite.img"

ls -ld "$IMGFILE"

clean()
{
	if sudo umount /buster
	then
		echo umount success
	fi

	sudo partx -d -v /dev/loop0

	sudo losetup -d /dev/loop0
}

trap clean 0

if test ! -d /buster
then
	sudo mkdir /buster
fi

if test ! -f /buster/etc/os-release
then
	if test ! -e /dev/loop0p2
	then
		sudo partx -a -v "$IMGFILE"
	fi

	ls -ld /dev/loop0p2

	sudo mount -o ro,noload /dev/loop0p2 /buster
fi

ls -ld /buster/etc/os-release

echo Use bash to have a look at the file system and exit cleanly to create image

if ( set -e ; cd /buster ; bash )
then
	sudo tar -C /buster -c . | docker import - raspbian10
fi
