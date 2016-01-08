# Install DNSManager

# Pull base image.
FROM     yeti/ruby:2.3.0
MAINTAINER Yeti Sno

WORKDIR /root

RUN \
	git clone --recursive https://github.com/yetisno/DNSManager.git DNSManager

COPY assets DNSManager/assets
COPY AppEntry /sbin/AppEntry

ENV WEB_BIND_IP 0.0.0.0
ENV DNS_IP 127.0.0.1
ENV WEB_BIND_PORT 8080
ENV DNS_DATABASE_URL sqlite3:///root/DNSManager/DNService/db/dnservice.sqlite3
ENV PATH $PATH:/root/DNSManager

RUN \
	cd DNSManager && \
	apt-get update && \
	apt-get install libpq-dev -y && \
	cd DNService && \
	bundle install && \
	cd .. && \
	cd DNSAdmin && \
	bundle install && \
	rake assets:precompile && \
	cd .. && \
	chmod 755 /sbin/AppEntry && \
	chmod +x /sbin/AppEntry

VOLUME /root/DNSManager/DNService/db
VOLUME /root/DNSManager/DNService/log
VOLUME /root/DNSManager/DNSAdmin/log

WORKDIR /root/DNSManager/
ENTRYPOINT ["/sbin/AppEntry"]

CMD ["app:start"]