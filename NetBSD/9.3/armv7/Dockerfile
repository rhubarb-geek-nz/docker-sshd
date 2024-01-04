# Copyright (c) 2024 Roger Brown.
# Licensed under the MIT License.

FROM debian:bookworm as builder
WORKDIR /tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl qemu-utils

RUN curl --silent \
		--location \
		--fail \
		https://mirrorservice.org/sites/ftp.netbsd.org/pub/NetBSD/NetBSD-9.3/evbarm-earmv7hf/binary/gzimg/armv7.img.gz | gunzip > /mnt/boot.raw

RUN curl --silent \
		--location \
		--fail \
		https://mirrorservice.org/sites/ftp.netbsd.org/pub/NetBSD/NetBSD-9.3/evbarm-earmv7hf/binary/kernel/netbsd-GENERIC.ub.gz | gunzip > /mnt/netbsd.ub

RUN curl --silent \
		--location \
		--fail \
		https://mirrorservice.org/sites/ftp.netbsd.org/pub/NetBSD/NetBSD-9.3/evbarm-earmv7hf/binary/kernel/vexpress-v2p-ca15-tc1.dtb.gz | gunzip > /mnt/vexpress-v2p-ca15-tc1.dtb

RUN qemu-img convert -f raw -O qcow2 /mnt/boot.raw /mnt/boot.img

RUN qemu-img resize -f qcow2 /mnt/boot.img 4G

FROM alpine:3.19
WORKDIR /tmp

RUN apk add qemu-system-arm

COPY --from=builder /mnt/boot.img /mnt/boot.img

COPY --from=builder /mnt/netbsd.ub /mnt/netbsd.ub

COPY --from=builder /mnt/vexpress-v2p-ca15-tc1.dtb /mnt/vexpress-v2p-ca15-tc1.dtb

EXPOSE 22

CMD ["qemu-system-arm", \
	"-M", "vexpress-a15", \
	"-kernel", "/mnt/netbsd.ub", \
	"-dtb", "/mnt/vexpress-v2p-ca15-tc1.dtb", \
	"-m", "2G", \
	"-sd", "/mnt/boot.img", \
	"-append", "root=ld0a", \
	"-net", "nic,model=lan9118", \
	"-net", "user,hostfwd=tcp::22-:22", \
	"-nographic" \
]
