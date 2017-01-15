# Samba 4.5.x with Alpine Linux
Alpine Linux based Docker image with latest Samba

## Usage
```
docker run -d -t -v /your/smb.conf:/etc/samba/smb.conf -v /public/share:/share --restart=always --net=host --name samba fserver/samba
```
