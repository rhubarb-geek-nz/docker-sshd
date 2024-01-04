#!/bin/sh -ex
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

clean()
{
	sudo rm -rf target
}

trap clean 0

clean

mkdir target

TARGET=$(pwd)/target

sudo debootstrap --variant=minbase \
	--include=procps,openssh-server,apt-transport-https,ca-certificates,curl,locales,sudo \
	--foreign --arch arm64 jessie "$TARGET" http://archive.debian.org/debian

for d in initscripts util-linux procps udev
do
	WC=$(find "$TARGET/var/cache/apt/archives" -name "$d"_"*.deb" -type f | wc -l)

	test "$WC" -eq 1

	find "$TARGET/var/cache/apt/archives" -name "$d"_"*.deb" -type f | (
		set -e

		while read N
		do
			rm -rf tmp.deb control

			echo fixup "$N"

			ar x "$N"

			mkdir control

			(
				set -e

				cd control

				tar xfz ../control.tar.gz

				tar cfz ../control.tar.gz con*	
			)

			ar r tmp.deb debian-binary control.tar.* data.tar.*

			rm -rf control debian-binary control.tar.* data.tar.*

			sudo chown 0:0 tmp.deb

			sudo mv tmp.deb "$N"
		done
	)
done

sudo tar -C "$TARGET" -cf - . | ssh 10.1.2.14 docker import - jessie-arm64
