FROM twdps/circleci-base-image:alpine-7.0.2

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

ENV CONFTEST_VERSION=0.48.0
ENV COSIGN_VERSION=2.2.2
ENV SYFT_VERSION=0.100.0
ENV ORAS_VERSION=1.1.0

# sudo since twdps circleci remote docker images set the USER=cirlceci
# hadolint ignore=DL3004
RUN sudo apk add --no-cache \
             python3==3.11.6-r1 \
             python3-dev==3.11.6-r1 \
             nodejs-current==21.4.0-r0 \
             npm==10.2.5-r0 \
             libffi-dev==3.4.4-r3 && \
    sudo rm /usr/lib/python3.11/EXTERNALLY-MANAGED && \
    sudo python3 -m ensurepip && \
    sudo rm -r /usr/lib/python*/ensurepip && \
    sudo pip3 install --upgrade pip==23.3.2 && \
    if [ ! -e /usr/bin/pip ]; then sudo ln -s /usr/bin/pip3 /usr/bin/pip ; fi && \
    sudo ln -s /usr/bin/pydoc3 /usr/bin/pydoc && \
    sudo pip install \
         setuptools==69.0.3 \
         awscli==1.32.27 \
         setuptools_scm==8.0.4 \
         hatch==1.9.3 \
         moto==4.2.13 \
         wheel==0.42.0 \
         build==1.0.3 \
         twine==4.0.2 \
         pipenv==2023.11.17 \
         pylint==3.0.3 \
         pytest==7.4.4 \
         pytest-cov==4.1.0 \
         coverage==7.4.0 \
         invoke==2.2.0 \
         requests==2.31.0 \
         jinja2==3.1.3 && \
    sudo npm install -g \
             snyk@1.1274.0 \
             bats@1.10.0 && \
    sudo bash -c "curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > /usr/local/bin/cc-test-reporter" && \
    sudo chmod +x /usr/local/bin/cc-test-reporter && \
    curl -LO https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    tar xzf conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    sudo mv conftest /usr/local/bin && rm ./* && \
    curl -LO https://github.com/sigstore/cosign/releases/download/v${COSIGN_VERSION}/cosign-linux-amd64 && \
    chmod +x cosign-linux-amd64 && sudo mv cosign-linux-amd64 /usr/local/bin/cosign && \
    sudo bash -c "curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin v${SYFT_VERSION}" && \
    curl -LO "https://github.com/oras-project/oras/releases/download/v${ORAS_VERSION}/oras_${ORAS_VERSION}_linux_amd64.tar.gz" && \
    mkdir -p oras-install && \
    tar -zxf oras_${ORAS_VERSION}_*.tar.gz -C oras-install/ && \
    sudo mv oras-install/oras /usr/local/bin/ && \
    rm -rf oras_${ORAS_VERSION}_*.tar.gz oras-install/

USER circleci
