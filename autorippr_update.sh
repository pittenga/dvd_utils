#!/bin/bash

sudo apt-get install pip handbrake-cli filebot

sudo pip install tendo pyyaml peewee

wget --quiet "https://github.com/JasonMillward/Autorippr/releases/latest" -O autorippr.html
VER=`cat autorippr.html | grep "Autorippr/releases/tag/" | sed 's/.*Autorippr\/releases\/tag\/\(.*\)\">Version.*/\1/'`
rm autorippr.html

echo ${VER}

git clone https://github.com/JasonMillward/Autorippr.git
cd Autorippr
git checkout ${VER}
cp settings.example.cfg settings.cfg
python autorippr.py --test
echo "Setup settings in settings.cfg"
