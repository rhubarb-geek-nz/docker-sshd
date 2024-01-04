#!/bin/sh -e
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

exec docker run -p 22092:8022/tcp --rm -h termux.docker.rhubarb.geek.nz --name rhubarb-pi-termux-x86_64 termux/termux-docker:x86_64 /bin/sh -c "set -e

for URL in \"https://docker.rhubarb.geek.nz/apt/termux/stable/rhubarb-pi-apt.deb\"
do
	BASENAME=\$(basename \"\$URL\")
	curl --output \"\$BASENAME\" --fail --location --silent \"\$URL\" --resolve docker.rhubarb.geek.nz:443:10.1.2.1
	pkg install \"./\$BASENAME\"
	rm \"\$BASENAME\"
done

DEBIAN_FRONTEND=noninteractive pkg update

DEBIAN_FRONTEND=noninteractive pkg install -y aedit rhubarb-pi-ssh-host openssh

exec sshd -D
"
