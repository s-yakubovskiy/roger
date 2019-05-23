#! /bin/sh
home=$(pwd | rev | cut -f2-15 -d "/" | rev)
source $home/scripts/./header.sh

echo "${RED}>>>> installing sudo && adding user to sudoers && apt update <<<<<<${NC}"