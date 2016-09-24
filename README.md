# hardware/rainloop

![](https://i.goopics.net/nI.png)

### What is this ?

Rainloop is a simple, modern & fast web-based client. More details on the [official website](http://www.rainloop.net/).

### Features

- Lightweight & secure image (no root process)
- Based on Alpine 3.4
- Latest Rainloop **Community Edition** (stable)
- Contacts (DB) : sqlite, or mysql (server not built-in)
- With Nginx and PHP7

### Build-time variables

- **GPG_FINGERPRINT** : fingerprint of signing key

### Ports

- **8888**

### Environment variables

| Variable | Description | Type | Default value |
| -------- | ----------- | ---- | ------------- |
| **GID** | rainloop user id | *optional* | 991
| **UID** | rainloop group id | *optional* | 991

### Reverse proxy example with nginx

https://github.com/hardware/mailserver/wiki/Reverse-proxy-configuration

### Initial configuration

https://github.com/hardware/mailserver/wiki/Rainloop-initial-configuration

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

# if using mariadb as contacts database :

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
