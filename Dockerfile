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

RUN service mysql stop

RUN usermod -d /var/lib/mysql/ mysql

RUN service mysql start
    
RUN pip install alembic

RUN alembic init --template generic alembic

RUN sed -i -e 's/sqlalchemy.url.*/sqlalchemy.url = mysql:\/\/root:root@localhost\/framgiatw/g' alembic.ini

RUN alembic revision -m "Create users table"

COPY seed.py /venv/seed.py

CMD ["python", "/venv/seed.py"]

COPY run.py /venv/run.py

EXPOSE 5000

CMD ["python", "/venv/run.py", "-p 5000"]


