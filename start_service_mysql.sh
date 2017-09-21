#!/bin/bash
chmod 777 /venv/*
sed -i -e 's/sqlalchemy.url.*/sqlalchemy.url = mysql:\/\/root:root@localhost\/framgiatw/g' alembic.ini
sed -i -e 's/admin/root/g' config.py

service mysql start
mysql -uroot -proot -e "CREATE DATABASE "framgiatw""
alembic upgrade head
python seed.py
exec $@
