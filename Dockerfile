FROM alpine:latest as build

RUN apk add git make cmake g++ libgcrypt-dev yajl-dev yajl \
    boost-dev curl-dev expat-dev cppunit-dev binutils-dev \
	pkgconfig \
	&& git clone https://github.com/vitalif/grive2.git \
	&& mkdir grive2/build \
	&& cd grive2/build  \
	&& cmake ..  \
	&& make -j4  \
	&& make install \
    && cd ../.. \
	&& rm -rf grive2 \
	&& mkdir /drive
	
FROM alpine:latest
COPY --from=build /usr/local/bin/grive /bin/grive
COPY ./entrypoint.sh /root/entrypoint.sh  
RUN chmod 777 /root/entrypoint.sh /bin/grive \
	&& mkdir /drive \
	&& apk add yajl-dev curl-dev libgcrypt \
	boost-program_options boost-regex binutils-dev \
	&& apk add boost-filesystem --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main
VOLUME /drive
WORKDIR /drive
CMD ["/root/entrypoint.sh"]