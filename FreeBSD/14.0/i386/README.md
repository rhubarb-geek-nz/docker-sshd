# docker-sshd/FreeBSD/14.0/i386

Creating an image for `FreeBSD` requires three main steps

- Create the initial image using the operating system tools
- Customise the resulting image
- Create the docker image

## Serial console

As we are wanting a headless server we need to configure the operating system to use a serial port as the console.

This configuration lives in [serial.conf](serial.conf). In order for this to be used we need to

- Modify the installation media by adding [/boot/loader.conf.d/serial.conf](serial.conf) to the `iso` image
- Update the `root.img` as the final step of the installation by adding the file while in the `chroot` environment

## Procedure

Run `./install.sh` to create the `root.img`. Follow the process to format the hard drive and install the media. As the final step 

- Run the `shell` to get into the `chroot` environment
- Write the [/boot/loader.conf.d/serial.conf](serial.conf) file
- Stop the server with `halt -p`

Run `./boot.sh` to configure the server to your own needs such as adding users and keys. Reboot and confirm you can `ssh` to the server on the forwarding port used in the `boot.sh` script. 

```
ssh -p 8022 localhost
```

Stop the server with `halt -p`.

Create the docker image using the newly created `root.img` with 

```
docker build -t my-freebsd-sshd-server .
```

# Running

Run with

```
docker run -p 8022:22/tcp my-freebsd-sshd-server
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
