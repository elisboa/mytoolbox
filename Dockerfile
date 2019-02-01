FROM debian

# First of all, update package list from repositories
RUN apt-get update

# Install packages from a file
RUN echo apt-get install $(grep -vE "^\s*#" packages.list | tr "\n" " ")
RUN apt-get install $(grep -vE "^\s*#" packages.list | tr "\n" " ")

# define default user
USER root
# cd to root's directory
WORKDIR /root

# run a screen session
CMD screen -l -q -e^Bb -S root -s /bin/bash
