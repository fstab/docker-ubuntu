FROM ubuntu:16.10
MAINTAINER Fabian Stäber, fabian@fstab.de

ENV LAST_UPDATE=2016-10-20

RUN apt-get update && \
    apt-get upgrade -y

# Set the timezone
RUN echo "Europe/Berlin" | tee /etc/timezone && \
    ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Set the locale for UTF-8 support
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && \
    locale-gen && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# basic tools

RUN apt-get install -y \
    curl \
    git \
    lsof \
    man \
    netcat \
    psmisc \
    screen \
    telnet \
    vim \
    wget

# admin tools

RUN apt-get install -y \
    expect

# developer tools

RUN apt-get install -y \
    build-essential \
    golang \
    libtool

# config

RUN echo 'defshell -bash' >> /root/.screenrc
