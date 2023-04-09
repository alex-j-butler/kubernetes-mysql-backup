# syntax=docker/dockerfile:1
   
FROM mysql/mysql-operator:8.0.32-2.0.8

RUN mkdir /mysqlsh/temp

USER 0
RUN microdnf update && echo "[main]" > /etc/dnf/dnf.conf \
    && microdnf install epel-release \
    && microdnf update \
    && microdnf install -y wget bzip2

RUN wget https://github.com/restic/restic/releases/download/v0.15.1/restic_0.15.1_linux_amd64.bz2 -O restic.bz2; bunzip2 -d restic.bz2 \
    && chmod +x restic \
    && mv restic /usr/bin/restic
USER 2

COPY . /mysqlsh/
ENTRYPOINT [ "bash", "/mysqlsh/restore.sh" ]