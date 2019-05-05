FROM ubuntu

MAINTAINER Mikhail Kovalsky <not-alone@yandex.ru>

COPY ["config", "start.sh", "/root"]

RUN sed -i 's/\r$//' /root/start.sh  && chmod +x /root/start.sh && apt-get update && apt-get install -y curl pkgconf libcurl4-openssl-dev libsqlite3-dev gcc xdg-utils unzip make xz-utils git && apt-get clean -y &&  rm -rf /var/lib/apt/lists/* /var/cache/* /var/tmp/*

RUN mkdir /OneDriveConf && mkdir /OneDriveData &&  mv /root/config /OneDriveConf  && cd /root && ls | grep -v start.sh | xargs rm -rf

RUN cd /root && curl -fsS -o install.sh https://dlang.org/install.sh && bash install.sh dmd && git clone https://github.com/abraunegg/onedrive && cd /root/onedrive && . `bash /root/install.sh -a` && `/bin/bash -c 'source ~/dlang/dmd*/activate'` && ./configure && make && make install && cd /root && ls | grep -v start.sh | xargs rm -rf

ENTRYPOINT /root/start.sh



