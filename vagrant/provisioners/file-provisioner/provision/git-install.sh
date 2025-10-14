#!/bin/bash

sudo apt-get update
sudo apt-get install -y git

# clean-up resources to reduce image size
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*
