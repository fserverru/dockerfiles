Squid
=====

Squid 3.5.x with Alpine Linux

Normal Proxy
=========

```
docker run  -v <configPath>/squid.conf:/etc/squid/squid.conf:ro \
            -v <configPath/cache:/var/cache/squid:rw \
            -v /var/log/squid:/var/log/squid:rw \
            -v /etc/localtime:/etc/localtime:ro \
            -p 3128:3128 -p 3129:3129 \
            --name squid -d -t fserver/squid
```


Transparent Proxy
=========

```
docker run  -v <configPath>/squid.conf:/etc/squid/squid.conf:ro \
            -v <configPath/cache:/var/cache/squid:rw \
            -v /var/log/squid:/var/log/squid:rw \
            -v /etc/localtime:/etc/localtime:ro \
            --privileged=true --net=host \
            --name squid -d -t fserver/squid
```
