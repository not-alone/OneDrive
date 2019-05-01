
FROM ubuntu
MAINTAINER Mikhail Kovalsky <not-alone@yandex.ru>

ENTRYPOINT /home/nobody/start.sh

RUN mkdir -p /home/nobody && usermod -u 99 -g users -d /home/nobody nobody && groupmod -g 100 users

ADD ./start.sh /home/nobody/
RUN sed -i 's/\r$//' /home/nobody/start.sh  && chmod +x /home/nobody/start.sh
		
RUN apt-get update && apt-get install -y curl pkgconf libcurl4-openssl-dev libsqlite3-dev gcc xdg-utils unzip make xz-utils git && apt-get clean -y && 	rm -rf /var/lib/apt/lists/* /var/cache/* /var/tmp/*
	
RUN cd /home/nobody && curl -fsS -o install.sh https://dlang.org/install.sh && bash install.sh dmd && git clone https://github.com/abraunegg/onedrive && cd /home/nobody/onedrive && . `bash /home/nobody/install.sh -a` && cd /~ && source ~/dlang/dmd*/activate && ./configure && make && make install

VOLUME ["/OneDriveConf", "/OneDriveData"]
RUN chown -R nobody:users /OneDriveConf
RUN chown -R nobody:users /OneDriveData

USER nobody
