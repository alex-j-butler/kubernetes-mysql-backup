# syntax=docker/dockerfile:1
   
FROM mysql/mysql-operator:8.0.32-2.0.8

RUN mkdir /mysqlsh/temp

USER 0
RUN microdnf update && echo "[main]" > /etc/dnf/dnf.conf \
    && microdnf install -y restic
USER 2

COPY . /mysqlsh/
ENTRYPOINT [ "bash", "/mysqlsh/restore.sh" ]