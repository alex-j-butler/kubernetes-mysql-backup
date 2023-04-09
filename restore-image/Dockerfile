# syntax=docker/dockerfile:1
   
FROM mysql/mysql-operator:8.0.32-2.0.8

RUN mkdir /mysqlsh/temp

USER 0
COPY ./restic_0.15.1_linux_amd64 /usr/bin/
RUN mv /usr/bin/restic_0.15.1_linux_amd64 /usr/bin/restic \
    && chmod +x /usr/bin/restic
USER 2

COPY . /mysqlsh/
ENTRYPOINT [ "bash", "/mysqlsh/restore.sh" ]