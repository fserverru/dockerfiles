#LetsEncrypt Certbot with Alpine Linux
v0.9.3

**1. Add aliases to your web server for all domains you need cert:**

nginx:
> location /.well-known/ { alias /usr/share/nginx/html/.well-known/; }

httpd:
> Alias /.well-known/ /usr/share/nginx/html/.well-known/

**2. Fetch certs**
~~~bash
docker run -it --rm -v /etc/ssl/letsencrypt:/etc/letsencrypt/ \
-v /usr/share/nginx/html/:/var/www/ fserver/certbot \
certbot certonly --agree-tos -t -m your@email.com \
--webroot -w /var/www/ -d domain.com -d www.domain.com
~~~
* /etc/ssl/letsencrypt - dir with letsencrypt data, certs you will find at /etc/ssl/letsencrypt/live/domain.com/
* /usr/share/nginx/html/ - dir shared via web server for domain check
* add all domains you need with **-d**

**3. Update certs manualy with**
~~~bash
docker run -it --rm -v /etc/ssl/letsencrypt:/etc/letsencrypt/ \
-v /usr/share/nginx/html/:/var/www/ \
fserver/certbot certbot renew
~~~

**or add to crontab:**
~~~bash
echo "1 1 * * sat root docker run -it --rm -v /etc/ssl/letsencrypt:/etc/letsencrypt/ -v /usr/share/nginx/html/:/var/www/ fserver/certbot certbot renew" >> /etc/crontab
~~~
will try to update certs every week

Docker: [fserver/certbot](https://hub.docker.com/r/fserver/certbot/ "")
