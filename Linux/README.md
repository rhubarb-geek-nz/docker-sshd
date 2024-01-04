# docker-sshd/Linux

This project contains scripts to create `sshd` servers that run under `docker`.

The general pattern for creating Linux sshd dockers is to

- define the original base image
- update the repository and ensure curl is available
- bootstrap a local repository by downloading a package with the configuration
- download further packages to set up the SSH keys and a well-known user
- setup the sshd server application as the entry point

In most cases the /etc/os-release file with the ID and VERSION_ID are used to identify the release of operating system and match with package repositories.
