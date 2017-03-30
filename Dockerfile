FROM ubuntu:16.10
MAINTAINER Fabian Stäber, fabian@fstab.de

ENV LAST_UPDATE=2017-03-30

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
    bash-completion \
    bc \
    curl \
    git \
    inetutils-traceroute \
    iputils-ping \
    lsof \
    man \
    netcat \
    nmap \
    psmisc \
    screen \
    telnet \
    unzip \
    vim \
    sysstat \
    wget

# admin tools

RUN apt-get install -y \
    expect

# Go development

RUN apt-get install -y \
    build-essential \
    golang \
    libtool

# Java development

RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    apt-get install -y oracle-java8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN apt-get install -y maven

# Python development

RUN apt-get install -y python-pip

# C development

RUN apt-get install -y clang

# config

RUN echo 'defshell -bash' >> /root/.screenrc
RUN echo 'if [ -f /etc/bash_completion ] && ! shopt -oq posix; then' >> /root/.bashrc && \
    echo '    . /etc/bash_completion' >> /root/.bashrc && \
    echo 'fi' >> /root/.bashrc
