# docker-sshd/NetBSD/9.3/amd64

Creating an image for `NetBSD` requires three main steps

- Create the initial image using the operating system tools
- Customise the resulting image
- Create the docker image

## Serial console

As we are wanting a headless server we need to use media configured to use the serial port as a console.

## IPv6 issues

NetBSD can have problems using `IPv6` under `qemu`, resulting in hangs while it tries to use `IPv6` before falling back to `IPv4`. The solution to this is

- download the media sets and add to the iso image and install from CD
- update `/etc/rc.conf` to use `IPv4` first

## Procedure

Run `./install.sh` to create the `root.img`. Follow the process to format the hard drive and install the media. As the final step stop the server with `halt -p`.

Run `./boot.sh` to configure the server to your own needs such as adding users and keys. 

Add the following to `/etc/rc.conf`.

```
ip6addrctl=YES
ip6addrctl_policy="ipv4_prefer"
```

Reboot and confirm you can `ssh` to the server on the forwarding port used in the `boot.sh` script. 

```
ssh -p 8022 localhost
```

Stop the server with `halt -p`.

Create the docker image using the newly created `root.img` with 

```
docker build -t my-netbsd-sshd-server .
```

# Running

Run with

```
docker run -p 8022:22/tcp my-netbsd-sshd-server
```

## Monitoring

If the docker container is running detached then the console output can be seen with

```
docker logs container-id --follow
```

## Shutting down

Shutting down the server while running in the `docker` or under `qemu` should be done with `halt -p` otherwise it will be waiting for a key press to reboot. 

```
The operating system has halted.
Please press any key to reboot.
```

If the docker is run with the automatic clean-up `--rm` option then simply using `docker stop container-id` is sufficient.
