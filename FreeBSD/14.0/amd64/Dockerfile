# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM alpine:3.19
WORKDIR /tmp

RUN apk add qemu-system-x86_64

COPY root.img /mnt/root.img

EXPOSE 22

CMD ["qemu-system-x86_64", \
	"-m", "2048", \
	"-hda", "/mnt/root.img", \
	"-nographic", \
	"-netdev", "user,id=net0,hostfwd=tcp::22-:22", \
	"-device", "e1000,netdev=net0" \
]
