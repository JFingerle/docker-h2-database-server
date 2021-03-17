FROM adoptopenjdk:11-jre
WORKDIR /

ADD h2.jar /
ADD entrypoint.sh /

ENTRYPOINT /bin/bash /entrypoint.sh