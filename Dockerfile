FROM debian

# Copy the list of packages to root directory, so apt-get will parse it
COPY packages.list /root

# define default user
USER root
# cd to root's directory
WORKDIR /root

# Define default language as C
ENV LANG C
# Define TERM because apt shows some warning message about not having it 
ENV TERM xterm
# Defining apt args to apt, apt-get and apt-cache
ENV APT_ARGS "-y -qq"

# First of all, update package list from repositories
RUN apt-get update $APT_ARGS

# Show what will be installed because I like debugging
RUN echo apt-get install $APT_ARGS $(grep -vE "^\s*#" packages.list | tr "\n" " ")

# Install packages from a file
RUN apt-get install $APT_ARGS $(grep -vE "^\s*#" packages.list | tr "\n" " ") ||\
    apt-get install -y --fix-missing # just in case something breaks on the way

# Run a screen session (yeah, I know I should use tmux instead)
CMD screen -l -q -e^Bb -S root -s /bin/bash