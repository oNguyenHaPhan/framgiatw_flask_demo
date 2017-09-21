#!/bin/bash
chmod 777 /venv/*
sed -i -e 's/sqlalchemy.url.*/sqlalchemy.url = mysql:\/\/root:root@localhost\/framgiatw/g' alembic.ini
dbconfig="SQLALCHEMY_DATABASE_URI = 'mysql://root:root@localhost/framgiatw'"
sed -i -e 's/SQLALCHEMY_DATABASE_URI.*/'$dbconfig'/g' config.py

service mysql start
mysql -uroot -proot -e "CREATE DATABASE "framgiatw""
sleep 7
python seed.py
python run.py
exec $@
