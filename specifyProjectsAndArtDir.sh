#!/bin/bash
sudo mkdir -p /etc/profile.d > /dev/null
sudo rm -f /etc/profile.d/projects-and-art-dir.sh &> /dev/null
sudo touch /etc/profile.d/projects-and-art-dir.sh &> /dev/null
echo "Enter the directory of Projects-And-Art (remember to add '/*/' at the end)"
read newDir
echo "export PROJECTS_AND_ART_DIR=$newDir" | sudo tee -a /etc/profile.d/projects-and-art-dir.sh > /dev/null
