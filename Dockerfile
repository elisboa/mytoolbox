FROM debian

# First of all, update package list from repositories
RUN apt-get update

# Then install some packages
# install screen
RUN apt-get install screen -y || apt-get install -y --fix-missing
# install openvpn
RUN apt-get install openvpn -y || apt-get install -y --fix-missing

# define default user
USER root
# cd to root's directory
WORKDIR /root

# run a screen session
CMD screen -l -q -e^Bb -S root -s /bin/bash
