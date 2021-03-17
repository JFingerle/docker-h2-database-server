# docker-h2-database-server
Docker image for a H2 SQL database (remotely accessible via JDBC (tcp))

H2 is a very lightweight but fast SQL database - perfect for small projects.

# Features
* H2 Database is remotely accessible via JDBC (over network/tcp)
* Creates the database automatically on startup if it does not exist already
* Lightweight
* OpenJDK11

# How to use?
* Clone the git repo
* Download the H2 jar file [here](https://mvnrepository.com/artifact/com.h2database/h2/latest). E.g. [version 1.4.200](https://repo1.maven.org/maven2/com/h2database/h2/1.4.200/h2-1.4.200.jar). Put it into the directory of the git repo and name it "h2.jar".
* Use docker-compose to build the image and start your docker container (see sample below)

# Docker-Compose sample configuration

```
version: '3'

volumes:

  my-h2-database-volume:
    driver: local
    driver_opts:
      type: 'node'
      o: 'bind'
      device: '/opt/my-docker-volumes/my-h2-database-volume' # this is the directory where your h2 database will be stored on the host OS

services:

  my-h2-database:
    build:
      context: /opt/my-docker-images/docker-h2-database-server # this is the directory where you've cloned the git repo
    environment:
      - ENV_DOCKER_VOLUME_DIR=/data # has to match the docker volume
      - ENV_DB_NAME=db # The name is important to connect to the db later - e.g. "jdbc:h2:tcp://myserver:9092/myDbName"
      - ENV_DB_USER=admin # User will be used to create a new DB if necessary
      - ENV_DB_PASSWORD=admin # Password will be used to create a new DB if necessary
      - ENV_DB_FILE_EXTENSION=.mv.db # the file extension varies between H2 versions (older versions use ".h2.db", newer ".mv.db")
      - ENV_JAVA_OPTS=-Xmx64m
    volumes:
      - my-h2-database-volume:/data
    ports:
      - 9092:9092
```
