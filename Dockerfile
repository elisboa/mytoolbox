FROM debian


# define default user
USER root
# cd to root's directory
WORKDIR /root

# First of all, update package list from repositories
RUN apt-get update

# Copy the list of packages to root directory, so apt-get will parse it
COPY packages.list /root 

# Install packages from a file
RUN echo apt-get install $(grep -vE "^\s*#" packages.list | tr "\n" " ")
RUN apt-get install $(grep -vE "^\s*#" packages.list | tr "\n" " ")

# run a screen session
CMD screen -l -q -e^Bb -S root -s /bin/bash
