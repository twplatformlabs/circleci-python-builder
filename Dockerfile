FROM twdps/circleci-base-image:alpine-3.4.0

LABEL maintainers=<nic.cheneweth@thoughtworks.com>

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# sudo since twdps circleci remote docker images set the USER=cirlceci
# hadolint ignore=DL3004
RUN sudo apk add --no-cache \
             curl==7.80.0-r0 \
             wget==1.21.2-r2 \
             gnupg==2.2.31-r1 \
             python3==3.9.7-r4 \
             docker==20.10.14-r1 \
             openrc==0.44.7-r5 \
             build-base==0.5-r2 \
             python3-dev==3.9.7-r4 \
             nodejs==16.14.2-r0 \
             npm==8.1.3-r0 \
             openssl-dev==1.1.1n-r0 \
             g++==10.3.1_git20211027-r0 \
             gcc==10.3.1_git20211027-r0 \
             make==4.3-r0 && \
    sudo rc-update add docker boot && \
    sudo python3 -m ensurepip && \
    sudo rm -r /usr/lib/python*/ensurepip && \
    sudo pip3 install --upgrade pip==22.0.4 && \
    if [ ! -e /usr/bin/pip ]; then sudo ln -s /usr/bin/pip3 /usr/bin/pip ; fi && \
    sudo ln -s /usr/bin/pydoc3 /usr/bin/pydoc && \
    sudo ln -s /usr/bin/python3 /usr/bin/python && \
    sudo ln -s /usr/bin/python3-config /usr/bin/python-config && \
    sudo pip install --no-binary \
            setuptools==62.1.0 \
            wheel==0.37.1 \
            pylint==2.13.7 \
            pytest==7.1.2 \
            coverage==6.3.2 \
            invoke==1.7.0 \
            requests==2.27.1 \
            jinja2==3.1.1 && \
    sudo npm install -g \
            bats@1.6.0 && \
    sudo -u circleci mkdir /home/circleci/.gnupg && \
    sudo -u circleci bash -c "echo 'allow-loopback-pinentry' > /home/circleci/.gnupg/gpg-agent.conf" && \
    sudo -u circleci bash -c "echo 'pinentry-mode loopback' > /home/circleci/.gnupg/gpg.conf" && \
    chmod 700 /home/circleci/.gnupg && chmod 600 /home/circleci/.gnupg/*

USER circleci