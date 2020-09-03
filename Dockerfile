FROM python:alpine

# Update distribution & install required packages
RUN apk upgrade --no-cache --available \
    && apk add --no-cache \
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

# Install python modules
COPY ./requirements.txt /requirements.txt
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install -r /requirements.txt

RUN /usr/local/bin/python -m spacy download en_core_web_sm

RUN npm install aws-es-curl -g 
# Create and configure non-root user
RUN adduser -u 1000 -D -h /home/tools -s /bin/bash tools

COPY src/bash/ /root/
COPY src/testing /home/tools/testing
COPY src/BICS03 /home/tools/BICS03
RUN chown -R tools:tools /home/tools

WORKDIR /home/tools

USER 1000


