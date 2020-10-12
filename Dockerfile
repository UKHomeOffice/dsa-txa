FROM python:3.7-alpine

# Update distribution & install required packages
RUN apk upgrade --no-cache --available \
    && apk add --no-cache \
        gcc \
	libc-dev\
	make \
	libffi-dev \
	libxml2-dev \
	libxslt-dev \
        alpine-sdk \
        bash \
        build-base \
        busybox-extras \
        ca-certificates \
        curl \
        git \
        gnupg \
        groff \
        jq \
        less \
        libffi-dev \
        linux-headers \
        musl-dev \
        openjdk8-jre \
        openssh \
        openssl \
        openssl-dev \
        perl \
        py-pip \
        python3-dev \
        redis \
        haproxy \
        gcompat \
        npm \
        vim \
        ca-certificates \
    && rm -rf /var/cache/apk /root/.cache

# Environment variables
ENV OS_VER linux_amd64

#Additional libs
RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main" >> /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories
RUN apk --no-cache --update-cache add gcc gfortran py-pip build-base wget freetype-dev libpng-dev openblas-dev
RUN ln -s /usr/include/locale.h/usr/include/xlocale.h

# Install python modules
COPY ./requirements.txt /requirements.txt
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install -r /requirements.txt

RUN /usr/local/bin/python -m spacy download en_core_web_sm

RUN npm install aws-es-curl -g 


