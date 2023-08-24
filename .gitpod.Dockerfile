FROM ubuntu:latest

USER root

RUN curl -sL -o/var/cache/apt/archives/updatecli_amd64.deb https://github.com/updatecli/updatecli/releases/download/v0.57.0/updatecli_amd64.deb
RUN dpkg -i /var/cache/apt/archives/updatecli_amd64.deb
