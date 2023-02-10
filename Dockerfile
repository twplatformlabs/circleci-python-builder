FROM twdps/circleci-base-image:alpine-4.1.0

LABEL maintainers=<nic.cheneweth@thoughtworks.com>

ENV CONFTEST_VERSION=0.39.0

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# sudo since twdps circleci remote docker images set the USER=cirlceci
# hadolint ignore=DL3004
RUN sudo apk add --no-cache \
             curl==7.87.0-r1 \
             libcurl==7.87.0-r1 \
             wget==1.21.3-r2 \
             gnupg==2.2.40-r0 \
             python3==3.10.10-r0 \
             python3-dev==3.10.10-r0 \
             docker==20.10.21-r2 \
             openrc==0.45.2-r7 \
             nodejs==18.12.1-r0 \
             npm==9.1.2-r0 \
             jq==1.6-r2 \
             build-base==0.5-r3 \
             openssl-dev==3.0.8-r0 \
             libffi-dev==3.4.4-r0 \
             g++==12.2.1_git20220924-r4 \
             gcc==12.2.1_git20220924-r4 \
             make==4.3-r1 && \
    sudo rc-update add docker boot && \
    sudo python3 -m ensurepip && \
    sudo rm -r /usr/lib/python*/ensurepip && \
    sudo pip3 install --upgrade pip==22.3.1 && \
    if [ ! -e /usr/bin/pip ]; then sudo ln -s /usr/bin/pip3 /usr/bin/pip ; fi && \
    sudo ln -s /usr/bin/pydoc3 /usr/bin/pydoc && \
    sudo pip install \
            setuptools==65.6.3 \
            wheel==0.38.4 \
            pipenv==2022.11.30 \
            pylint==2.15.8 \
            pytest==7.2.0 \
            coverage==6.5.0 \
            invoke==1.7.3 \
            requests==2.28.1 \
            jinja2==3.1.2 && \
    sudo npm install -g \
            bats@1.8.2 && \
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
