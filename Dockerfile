FROM ubuntu:15.04
MAINTAINER nahidul kibria <nahidupa@gmail.com>

RUN apt-get update \
 && apt-get install -y python2.7 git

#grab oracle java (auto accept licence)
RUN apt-get install -y software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get clean

# Do following install tasks in /tmp
WORKDIR /tmp

# Install latest pip
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python2.7 get-pip.py

# Do following install tasks in /opt
WORKDIR /opt

git clone https://github.com/ajinabraham/Mobile-Security-Framework-MobSF.git

WORKDIR /opt/Mobile-Security-Framework-MobSF
pip install -r requirements.txt

EXPOSE 8000

RUN python manage.py runserver
