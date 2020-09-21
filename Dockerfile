FROM debian:jessie
MAINTAINER Agustin Alexander <agustin.c.alexander@gmail.com>

RUN apt-get update \
	&& apt-get -y upgrade \
	&& apt-get -y install git cmake build-essential libgcrypt11-dev libyajl-dev \
    libboost-all-dev libcurl4-openssl-dev libexpat1-dev libcppunit-dev binutils-dev \
	pkg-config \
	&& rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/vitalif/grive2.git \
	&& mkdir grive2/build \
	&& cd grive2/build  \
	&& cmake ..  \
	&& make -j4  \
	&& make install \
  && cd ../.. \
	&& rm -rf grive2 \
	&& mkdir /drive \
	&& echo "Grive installation finished!"

COPY ./entrypoint.sh /root/entrypoint.sh
RUN chmod 777 /root/entrypoint.sh
WORKDIR /drive
CMD ["/root/entrypoint.sh"]