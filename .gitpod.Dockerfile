FROM ubuntu:latest

RUN sudo curl -sL -o/var/cache/apt/archives/updatecli_amd64.deb https://github.com/updatecli/updatecli/releases/download/v0.57.0/updatecli_amd64.deb
RUN sudo dpkg -i /var/cache/apt/archives/updatecli_amd64.deb 