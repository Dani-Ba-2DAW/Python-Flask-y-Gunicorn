#!/bin/bash

sudo apt-get update
#sudo apt-get upgrade -y

sudo apt install -y git python3-pip nginx
pip3 install pipenv python-dotenv

sudo mkdir -p /var/www/app
sudo cp /vagrant/config/.env /var/www/app

sudo chown -R $USER:www-data /var/www/app
sudo chmod -R 775 /var/www/app

cd /var/www/app
pipenv install flask gunicorn
pipenv run cat /vagrant/config/application.py > application.py
pipenv run cat /vagrant/config/wsgi.py > wsgi.py
cd ~

sudo cp /vagrant/config/flask_app.service /etc/systemd/system
sudo systemctl daemon-reload
sudo service flask_app enable
sudo service flask_app start

sudo cp /vagrant/config/app.conf /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled

cd /var/www
sudo git clone https://github.com/Azure-Samples/msdocs-python-flask-webapp-quickstart
sudo chown -R $USER:www-data msdocs-python-flask-webapp-quickstart
sudo chmod -R 775 msdocs-python-flask-webapp-quickstart
cd msdocs-python-flask-webapp-quickstart
pipenv install -r requirements.txt
cd ~

sudo cp /vagrant/config/flask_app_tarea.service /etc/systemd/system
sudo systemctl daemon-reload
sudo service flask_app_tarea enable
sudo service flask_app_tarea start

sudo cp /vagrant/config/tarea.conf /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/tarea.conf /etc/nginx/sites-enabled

sudo service nginx restart