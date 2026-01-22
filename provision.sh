#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y

sudo apt install -y git python3-pip nginx
pip3 install pipenv python-dotenv

sudo mkdir -p /var/www/app
cp /vagrant/config/.env /var/www/app

sudo chown -R $USER:www-data /var/www/app
sudo chmod -R 775 /var/www/app

cd /var/www/app
pipenv run pip install flask gunicorn
pipenv run cat /vagrant/config/application.py > application.py
pipenv run cat /vagrant/config/wsgi.py > wsgi.py
cd ~

sudo cp /vagrant/config/flask_app.service /etc/systemd/system
sudo systemctl daemon-reload
sudo service flask_app enable
sudo service flask_app start

sudo service nginx start