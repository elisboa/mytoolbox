FROM debian


# define default user
USER root
# cd to root's directory
WORKDIR /root

# Defining default language as C
ENV LANG C

# First of all, update package list from repositories
RUN apt-get update

# Copy the list of packages to root directory, so apt-get will parse it
COPY packages.list /root 

# Install packages from a file
ENV APT_ARGS "-y -qq"
RUN echo apt-get install $APT_ARGS $(grep -vE "^\s*#" packages.list | tr "\n" " ")
RUN apt-get install $APT_ARGS $(grep -vE "^\s*#" packages.list | tr "\n" " ")

# run a screen session
CMD screen -l -q -e^Bb -S root -s /bin/bash
