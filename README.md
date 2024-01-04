# docker-sshd

This project contains scripts to create `sshd` servers that run under `docker`.

The goal is that the docker appears as just an `sshd` server exposing port 22, but with different operating systems allowing native testing and execution in those environments.

Most `Linux` guest environments run directly under docker, the `FreeBSD`, `NetBSD` and `OpenBSD` run on `qemu` running on `Alpine`.

Some guests require an installation phase before creating the docker image. This can be done on `Linux` or a `Linux docker-sshd`.

This project does not provide user credentials or keys for those servers, the scripts give examples of how those can be automated from a repository.
