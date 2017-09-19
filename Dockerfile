FROM ubuntu:xenial
LABEL maintainer="Jorik De Waen"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y git \
	&& git clone https://github.com/VerifiableRobotics/slugs.git \
	&& apt-get remove -y git \
	&& apt-get autoremove -y \
	&& apt-get clean

WORKDIR slugs/src

RUN apt-get install -y make gcc g++ libboost-all-dev \
	&& make \
	&& make clean \
	&& apt-get remove -y make gcc g++ libboost-all-dev \
	&& apt-get autoremove -y \
	&& apt-get clean

#RUN ./slugs ../examples/networks.slugsin

WORKDIR /

RUN apt-get install -y python python-pip python-dev build-essential graphviz\
	&& pip install --upgrade pip \ 
	&& pip install 'polytope==0.1.2' \
	&& pip install tulip \
	&& apt-get remove -y python-dev build-essential \
	&& apt-get autoremove -y \
	&& apt-get clean

ENV PATH="/slugs/src:${PATH}"

VOLUME /app
WORKDIR /app