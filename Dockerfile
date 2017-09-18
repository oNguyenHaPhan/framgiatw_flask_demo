FROM ubuntu:16.04

MAINTAINER Nguyen Ha Phan

RUN DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN apt install -y python3-pip build-essential libssl-dev libffi-dev python3-dev python3-venv

RUN mkdir environments

WORKDIR /environments

RUN pyvenv venv

COPY requirements.txt /venv

RUN pip install -r requirement.txt
