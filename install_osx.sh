#!/bin/bash

#make sure we are on osx
if ! [[ "$OSTYPE" == "darwin"* ]]; then
  echo "ERROR: this script only works on osx"
  exit 0
fi

#check if brew is instealled
if ! type "brew" > /dev/null; then
  echo "ERROR: please install brew to continue"
  exit 0
fi

if [ ! -d "jasper" ]; then
  git clone https://github.com/jasperproject/jasper-client.git jasper
else
  read -p "Jasper directory already exists, would you like to delete it (y) or use it (n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
      rm -rf jasper
      git clone https://github.com/jasperproject/jasper-client.git jasper
  fi
fi

echo "INFO: installing requirements via pip (you will be prompted for your password)"

sudo pip install --upgrade setuptools
sudo pip install -r jasper/client/requirements.txt

echo "INFO: populating japsper..."
python client/populate.py