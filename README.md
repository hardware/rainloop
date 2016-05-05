# hardware/rainloop

![](https://i.goopics.net/nI.png)

Rainloop is a SIMPLE, MODERN & FAST WEB-BASED EMAIL CLIENT. More details on the [official website](http://www.rainloop.net/).

### Requirement

- Docker 1.0 or higher
- MySQL (Optional, for contacts database)

### Features
- Based on Alpine 3.3
- Latest Rainloop **Community Edition** (stable)
- Extremely lightweight
- Contacts (DB) : sqlite, or mysql (server not built-in)

### How to use

```
docker run -d \
  --name rainloop \
  --link mariadb:mariadb \ # Optional
  -v /mnt/docker/rainloop:/rainloop/data \
  hardware/rainloop
```

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
  environment:
    - GID=991
    - UID=991
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

### Reverse proxy example with nginx

https://github.com/hardware/mailserver/wiki/Reverse-proxy-configuration

### Initial configuration

https://github.com/hardware/mailserver/wiki/Rainloop-initial-configuration
