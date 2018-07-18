#FROM openwhisk/dockerskeleton
FROM openwhisk/dockerskeleton:latest

# TODO: kan dit weg?
ENV FLASK_PROXY_PORT 8080

# Install R
RUN echo "ipv6" >> /etc/modules
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-3.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-5.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "http://dl-3.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "http://dl-5.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    apk update && apk upgrade && apk add --no-cache git R R-dev R-doc curl openssl-dev curl-dev libxml2-dev gcc g++ git coreutils bash ncurses

RUN R -q -e "install.packages(c('devtools', 'covr', 'roxygen2', 'testthat'), repos = 'https://cloud.r-project.org/')" 
RUN R -q -e "devtools::install_github('roqua/autovar', ref='low-memory', force=TRUE)         " &&\
    rm -rf /tmp/*

#ADD skeleton/actionproxy.py /actionProxy/
ADD ./files/exec /action/exec

