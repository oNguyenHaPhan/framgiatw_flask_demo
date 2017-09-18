FROM ubuntu:16.04

MAINTAINER Nguyen Ha Phan

RUN DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN apt install -y python3-pip build-essential libssl-dev libffi-dev python3-dev python3-venv

RUN pip3 install --upgrade pip3

RUN mkdir -p venv

COPY requirements.txt /venv/requirements.txt

WORKDIR /venv

RUN pip3 install -r requirement.txt
