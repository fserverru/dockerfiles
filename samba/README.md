# Samba 4.5.x with Alpine Linux
Alpine Linux based Docker image with latest Samba

## Usage
```
docker run -d -t -v ./smb.conf:/etc/samba/smb.conf -v /data/share:/share -t net -restart=always fserver/samba
```
