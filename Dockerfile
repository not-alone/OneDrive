FROM ubuntu:latest as build 

MAINTAINER Mikhail Kovalsky <not-alone@yandex.ru>

COPY ["config", "start.sh", "/root/"]

RUN  apt-get update && apt-get install -y curl gnupg pkgconf \
libcurl4-openssl-dev libsqlite3-dev gcc xdg-utils unzip make xz-utils git \
&& cd /root && curl -fsS -o install.sh https://dlang.org/install.sh \
&& bash install.sh dmd && git clone https://github.com/abraunegg/onedrive \
&& cd /root/onedrive && . `bash /root/install.sh -a` && `/bin/bash -c 'source ~/dlang/dmd*/activate'` \
&& ./configure && make

FROM ubuntu:latest as 

COPY --from=build /root /root

RUN apt-get update && apt-get install -y libcurl4-openssl-dev libsqlite3-dev make \
&& mkdir /OneDriveConf && mkdir /OneDriveData && chmod +x /root/start.sh \
&& sed -i 's/\r$//' /root/start.sh && cd /root/onedrive && make install \
&& cd /root && rm -rf onedrive && apt-get purge -y make && apt-get autoremove -y \
&& apt-get clean -y && rm -rf /var/lib/apt/lists/* /var/cache/* /var/tmp/*

ENTRYPOINT /root/start.sh


