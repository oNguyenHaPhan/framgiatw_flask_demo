FROM ubuntu:16.04

MAINTAINER Nguyen Ha Phan

RUN DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN mkdir /venv

RUN apt install -y python python-dev python-pip python-virtualenv

RUN pip install --upgrade pip

COPY requirements.txt /venv/requirements.txt

WORKDIR /venv

RUN apt-get install -y libmysqlclient-dev

RUN pip install -r requirements.txt

RUN apt-get update && apt-get install -y \
    software-properties-common

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \
    && echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections \
    && apt-get install -y mysql-server
