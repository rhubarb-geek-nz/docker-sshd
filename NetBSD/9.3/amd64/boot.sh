#!/bin/sh -e
# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

qemu-system-x86_64 \
	-m 256 \
	-hda root.img \
	-nographic \
	-netdev user,id=net0,hostfwd=tcp::8022-:22 \
	-device e1000,netdev=net0
