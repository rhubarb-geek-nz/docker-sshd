#!/bin/sh -ex
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

IMGFILE="$HOME/images/2015-05-05-raspbian-wheezy.img"

ls -ld "$IMGFILE"

clean()
{
	if sudo umount /wheezy
	then
		echo umount success
	fi

	sudo partx -d -v /dev/loop0

	sudo losetup -d /dev/loop0
}

trap clean 0

if test ! -d /wheezy
then
	sudo mkdir /wheezy
fi

if test ! -f /wheezy/etc/os-release
then
	if test ! -e /dev/loop0p2
	then
		sudo partx -a -v "$IMGFILE"
	fi

	ls -ld /dev/loop0p2

	sudo mount -o ro,noload /dev/loop0p2 /wheezy
fi

ls -ld /wheezy/etc/os-release

echo Use bash to have a look at the file system and exit cleanly to create image

if ( set -e ; cd /wheezy ; bash )
then
	sudo tar -C /wheezy -c . | docker import - raspbian7
fi
