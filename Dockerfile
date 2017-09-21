FROM ubuntu:16.04

MAINTAINER Nguyen Ha Phan

RUN DEBIAN_FRONTEND=noninteractive

RUN apt update

ADD . /venv

WORKDIR /venv

RUN apt install -y python python-dev python-pip python-virtualenv

RUN pip install --upgrade pip

RUN apt-get install -y libmysqlclient-dev

RUN pip install -r requirements.txt

RUN apt-get update && apt-get install -y \
    software-properties-common

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \
    && echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections \
    && apt-get install -y mysql-server

RUN pip install alembic

RUN alembic revision -m "Create users table"

RUN sed -i -e 's/sqlalchemy.url.*/sqlalchemy.url = mysql:\/\/root:root@localhost\/framgiatw/g' alembic.ini

RUN chmod a+x start_service_mysql.sh

ENTRYPOINT start_service_mysql.sh
