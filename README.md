# hardware/rainloop

![](https://i.goopics.net/nI.png)

Rainloop is a simple, modern & fast web-based client. More details on the [official website](http://www.rainloop.net/).

### Features
- Based on Alpine 3.3
- Latest Rainloop **Community Edition** (stable)
- Contacts (DB) : sqlite, or mysql (server not built-in)

### How to use

```
docker run -d \
  --name rainloop \
  --link mariadb:mariadb \ # Optional
  -v /mnt/docker/rainloop:/rainloop/data \
  hardware/rainloop
```

### Reverse proxy example with nginx

https://github.com/hardware/mailserver/wiki/Reverse-proxy-configuration

### Initial configuration

https://github.com/hardware/mailserver/wiki/Rainloop-initial-configuration

#### Build-time variables

- **GPG_rainloop** : fingerprint of signing key

### Environment variables

- **UID** : rainloop user id (*optional*, default: 991)
- **GID** : rainloop group id (*optional*, default: 991)

### Docker-compose

#### Docker-compose.yml
```
rainloop:
  image: hardware/rainloop
  container_name: rainloop
  links:
    - mariadb:mariadb
  volumes:
    - /mnt/docker/rainloop:/rainloop/data

# if using mysql as contacts database :

mariadb:
  image: mariadb:10.1
  container_name: mariadb
  volumes:
    - /mnt/docker/mysql/db:/var/lib/mysql
  environment:
    - MYSQL_ROOT_PASSWORD=xxxxxxx
    - MYSQL_DATABASE=rainloop
    - MYSQL_USER=rainloop
    - MYSQL_PASSWORD=xxxxxxx
```

#### Run !

```
docker-compose up -d
```