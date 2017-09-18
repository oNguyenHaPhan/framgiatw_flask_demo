FROM ubuntu:16.04

MAINTAINER Nguyen Ha Phan

RUN DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN apt install -y python-pip build-essential libssl-dev libffi-dev python-dev python-venv

RUN pip install --upgrade pip

RUN mkdir -p venv

COPY requirements.txt /venv/requirements.txt

WORKDIR /venv

RUN pip install -r requirement.txt
