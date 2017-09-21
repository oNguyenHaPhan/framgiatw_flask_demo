#!/bin/bash

service mysql start
mysql -uroot -proot "CREATE DATABASE "framgiatw""
python seed.py
python run.py
exec $@
