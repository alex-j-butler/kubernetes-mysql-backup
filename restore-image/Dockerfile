# syntax=docker/dockerfile:1
   
FROM mysql/mysql-operator:8.0.32-2.0.8

RUN mkdir /mysqlsh/temp
RUN microdnf install -y restic
COPY . /mysqlsh/
ENTRYPOINT [ "bash", "/mysqlsh/restore.sh" ]