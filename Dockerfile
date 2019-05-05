FROM ubuntu

MAINTAINER Mikhail Kovalsky <not-alone@yandex.ru>

RUN usermod -u 99 -g users -d /home/nobody nobody && groupmod -g 100 users

COPY ["config", "start.sh", "/home/nobody/"]

RUN sed -i 's/\r$//' /home/nobody/start.sh  && chmod +x /home/nobody/start.sh && apt-get update && apt-get install -y curl pkgconf libcurl4-openssl-dev libsqlite3-dev gcc xdg-utils unzip make xz-utils git && apt-get clean -y &&  rm -rf /var/lib/apt/lists/* /var/cache/* /var/tmp/*

RUN mkdir /OneDriveConf && mkdir /OneDriveData &&  mv /home/nobody/config /OneDriveConf && chown -R nobody:users /OneDriveConf && chown -R nobody:users /OneDriveData && chown -R nobody:users /home/nobody && cd /home/nobody && ls | grep -v start.sh | xargs rm -rf

RUN cd /home/nobody && curl -fsS -o install.sh https://dlang.org/install.sh && bash install.sh dmd && git clone https://github.com/abraunegg/onedrive && cd /home/nobody/onedrive && . `bash /home/nobody/install.sh -a` && `/bin/bash -c 'source ~/dlang/dmd*/activate'` && ./configure && make && make install && cd /home/nobody && ls | grep -v start.sh | xargs rm -rf

USER nobody

ENTRYPOINT /home/nobody/start.sh



