# syntax=docker/dockerfile:1
   
FROM mysql/mysql-operator:8.0.32-2.0.8
COPY . /mysqlsh/
