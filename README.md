# USAGE #
see [DNSManager](https://github.com/yetisno/DNSManager)
![DNSManager](dnsmanager.png)
## BUILD ##
```bash
docker build \
--rm=true \
--force-rm=true \
--no-cache=true \
-t yeti/dnsmanager:v1.4.3 .
```

## ENV Parameter ##
    WEB_BIND_PORT           8080
    DNS_BIND_PORT           5300
    DNS_IP                  127.0.0.1
    DNS_RECORD_TTL          120
    DNS_ENABLE_FORWARD      false
    DNS_FORWARDER_IP        8.8.8.8
    DNS_FORWARDER_PORT      53
    DNS_DATABASE_URL        "sqlite3:///root/DNSManager/DNService/db/dnservice.sqlite3"
    DNS_RELOAD_KEY      

## Volume ##
    VOLUME /root/DNSManager/DNService/db
    VOLUME /root/DNSManager/DNService/log
    VOLUME /root/DNSManager/DNSAdmin/log

## RUN ##
```bash
docker run \
--restart=always \
-i \
-p 53:53 \
-p 53:53/udp \
-p 12080:8080 \
--name="dnsmanager" \
-h dnsmanager \
-e 'DNS_BIND_PORT=53' \
-e 'DNS_DATABASE_URL=postgres://admin:pass@postgres:5432/dnsdb' \
-v /pool/service-storage/dns/dnservice/db:/root/DNSManager/DNService/db \
-v /pool/service-storage/dns/dnservice/log:/root/DNSManager/DNService/log \
-v /pool/service-storage/dns/dnsadmin/log:/root/DNSManager/DNSAdmin/log \
-t yeti/dnsmanager:v1.4.3
```

## DELETE ##
    docker stop dnsmanager;docker rm dnsmanager; docker rmi yeti/dnsmanager:v1.4.3

## DDNS ##
    curl -X PUT -d "{\"ddn\":{\"to_ip\":\"${TO_IP}\"}}" -H "Content-Type: application/json" http://example.com/api/domains/example-com/ddns/<token>