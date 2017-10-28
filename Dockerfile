FROM debian:jessie

RUN apt-get update
RUN apt-get -y install curl
RUN echo "deb http://emdebian.org/tools/debian/ jessie main" > /etc/apt/sources.list.d/crosstools.list
RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
RUN dpkg --add-architecture armhf
RUN apt-get update && apt-get install -y \
    crossbuild-essential-armhf \
    make \
    binutils \
    autoconf \
    automake \
    autotools-dev \
    libtool \
    pkg-config \
    zlib1g-dev \
    libcunit1-dev \
    libssl-dev \
    libxml2-dev \
    libev-dev \
    libevent-dev \
    libjansson-dev \
    libc-ares-dev \
    libjemalloc-dev \
    libsystemd-dev 
COPY nghttp2-1.27.0.tar.bz2 /tmp/nghttp2-1.27.0.tar.bz2
RUN tar xf tmp/nghttp2-1.27.0.tar.bz2 &&\
    cd nghttp2-1.27.0 &&\
    autoreconf -i &&\
    automake &&\
    autoconf &&\
    ./configure --enable-app &&\
    make &&\
    make install &&\
    ldconfig
