FROM ubuntu:16.04

MAINTAINER Nguyen Ha Phan

RUN DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN mkdir /venv

RUN apt install -y python python-dev python-pip python-virtualenv

RUN pip install --upgrade pip

COPY requirements.txt /venv/requirements.txt

WORKDIR /venv

RUN pip install -r requirement.txt
