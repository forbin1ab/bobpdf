#!/bin/bash
sudo apt update && sudo apt upgrade
sudo apt install poppler-utils
sudo apt install python3-venv -y # on windows might need to change this to 3.10 version
# create virtual environment in our home directory
python3 -m venv ~/shellgpt-env
#activate it
source ~/shellgpt-env/bin/activate
# install shellgpt so that we can get sgpt command
pip3 install shell-gpt
