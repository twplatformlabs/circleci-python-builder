FROM twdps/circleci-base-image:alpine-6.6.2

LABEL org.opencontainers.image.authors="nic.cheneweth@thoughtworks.com" \
      org.opencontainers.image.description="Alpine-based CircleCI executor image" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/ThoughtWorks-DPS/circleci-python-builder" \
      org.opencontainers.image.title="circleci-python-builder" \
      org.opencontainers.image.vendor="ThoughtWorks, Inc."

LABEL org.opencontainers.image.title="circleci-python-builder" \
      org.opencontainers.image.description="Alpine-based CircleCI executor image" \
      org.opencontainers.image.documentation="https://github.com/ThoughtWorks-DPS/circleci-python-builder" \
      org.opencontainers.image.source="https://github.com/ThoughtWorks-DPS/circleci-python-builder" \
      org.opencontainers.image.url="https://github.com/ThoughtWorks-DPS/circleci-python-builder" \
      org.opencontainers.image.vendor="ThoughtWorks, Inc." \
      org.opencontainers.image.authors="nic.cheneweth@thoughtworks.com" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.created="CREATED" \
      org.opencontainers.image.version="VERSION"

ENV CONFTEST_VERSION=0.41.0

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# sudo since twdps circleci remote docker images set the USER=cirlceci
# hadolint ignore=DL3004
RUN sudo bash -c "echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories" && \
    sudo apk add --no-cache \
             libcurl==8.1.1-r1 \
             python3==3.11.3-r11 \
             python3-dev==3.11.3-r11 \
             docker==23.0.6-r2 \
             openrc==0.47.1-r0 \
             nodejs==18.16.0-r1 \
             npm==9.6.6-r0 \
             jq==1.6-r3 \
             build-base==0.5-r3 \
             openssl-dev==3.1.0-r4 \
             libffi-dev==3.4.4-r2 \
             g++==12.2.1_git20220924-r10 \
             gcc==12.2.1_git20220924-r10 \
             make==4.4.1-r1 && \
    sudo python3 -m ensurepip && \
    sudo rm -r /usr/lib/python*/ensurepip && \
    sudo pip3 install --upgrade pip==23.1.1 && \
    if [ ! -e /usr/bin/pip ]; then sudo ln -s /usr/bin/pip3 /usr/bin/pip ; fi && \
    sudo ln -s /usr/bin/pydoc3 /usr/bin/pydoc && \
    sudo pip install \
         setuptools==67.8.0 \
         awscli==1.27.142 \
         setuptools_scm==7.1.0 \
         hatch==1.7.0 \
         moto==4.1.10 \
         wheel==0.40.0 \
         build==0.10.0 \
         twine==4.0.2 \
         pipenv==2023.4.20 \
         pylint==2.17.3 \
         pytest==7.3.1 \
         pytest-cov==4.0.0 \
         coverage==7.2.3 \
         invoke==1.7.3 \
         requests==2.28.2 \
         jinja2==3.1.2 && \
    sudo npm install -g \
             snyk@1.1168.0 \
             bats@1.9.0 && \
    sudo bash -c "curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > /usr/local/bin/cc-test-reporter" && \
    sudo chmod +x /usr/local/bin/cc-test-reporter && \
    wget --quiet https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    tar xzf conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    sudo mv conftest /usr/local/bin && rm ./* && \
    sudo -u circleci mkdir /home/circleci/.gnupg && \
    sudo -u circleci bash -c "echo 'allow-loopback-pinentry' > /home/circleci/.gnupg/gpg-agent.conf" && \
    sudo -u circleci bash -c "echo 'pinentry-mode loopback' > /home/circleci/.gnupg/gpg.conf" && \
    chmod 700 /home/circleci/.gnupg && \
    chmod 600 /home/circleci/.gnupg/*

USER circleci
