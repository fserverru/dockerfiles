# Docker SoftEtherVPN inside Alpine Linux

##### Simple

```bash
docker run -d --name softethervpn --privileged --net host fserver/softethervpn
docker logs softethervpn
```

##### Setting your user/password/psk

```bash
docker run -d --name softethervpn --privileged --net host -e PSK=server -e USERNAME=root -e PASSWORD=P@ssw0rd fserver/softethervpn
```