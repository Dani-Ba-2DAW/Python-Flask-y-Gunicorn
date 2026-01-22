#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y

sudo apt install -y git python3-pip
pip3 install pipenv python-dotenv

sudo mkdir -p /var/www/app
cp /vagrant/config/.env /var/www/app

sudo chown -R $USER:www-data /var/www/app
sudo chmod -R 775 /var/www/app
pipenv shell