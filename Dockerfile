FROM twdps/circleci-base-image:alpine-8.8.0

LABEL org.opencontainers.image.created="%%CREATED%%" \
      org.opencontainers.image.authors="nic.cheneweth@thoughtworks.com" \
      org.opencontainers.image.documentation="https://github.com/ThoughtWorks-DPS/circleci-python-builder" \
      org.opencontainers.image.source="https://github.com/ThoughtWorks-DPS/circleci-python-builder" \
      org.opencontainers.image.url="https://github.com/ThoughtWorks-DPS/circleci-python-builder" \
      org.opencontainers.image.version="%%VERSION%%" \
      org.opencontainers.image.vendor="ThoughtWorks, Inc." \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="circleci-python-builder" \
      org.opencontainers.image.description="Alpine-based CircleCI executor image for building Python APIs" \
      org.opencontainers.image.base.name="%%BASE%%"

ENV HADOLINT_VERSION=2.12.0
ENV COSIGN_VERSION=2.5.0
ENV CRANE_VERSION=0.20.3
ENV SYFT_VERSION=1.22.0
ENV ORAS_VERSION=1.2.2

# sudo since twdps circleci remote docker images set the USER=cirlceci
# hadolint ignore=DL3004
RUN sudo apk add --no-cache \
             python3==3.12.9-r0 \
             python3-dev==3.12.9-r0 \
             nodejs-current==23.2.0-r1 \
             npm==10.9.1-r0 \
             libffi-dev==3.4.7-r0  && \
    sudo rm /usr/lib/python3.12/EXTERNALLY-MANAGED && \
    sudo python3 -m ensurepip && \
    sudo rm -r /usr/lib/python*/ensurepip && \
    sudo pip3 install --upgrade pip==25.0.1 && \
    if [ ! -e /usr/bin/pip ]; then sudo ln -s /usr/bin/pip3 /usr/bin/pip ; fi && \
    sudo ln -s /usr/bin/pydoc3 /usr/bin/pydoc && \
    sudo pip install \
         setuptools==75.8.1 \
         awscli==1.38.30 \
         setuptools_scm==8.2.0 \
         hatch==1.14.1 \
         moto==5.1.3 \
         wheel==0.45.1 \
         build==1.2.1 \
         twine==6.1.0 \
         pipenv==2024.4.1 \
         pylint==3.3.6 \
         pytest==8.3.5 \
         pytest-cov==6.1.1 \
         coverage==7.8.0 \
         invoke==2.2.0 \
         requests==2.32.3 \
         jinja2==3.1.6 && \
    sudo npm install -g \
             snyk@1.1296.1 \
             bats@1.11.1 && \
    curl -LO https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64 && \
    sudo mv hadolint-Linux-x86_64 /usr/local/bin/hadolint && sudo chmod +x /usr/local/bin/hadolint && \
    curl -sL "https://github.com/google/go-containerregistry/releases/download/v${CRANE_VERSION}/go-containerregistry_Linux_x86_64.tar.gz" > go-containerregistry.tar.gz && \
    sudo tar -zxvf go-containerregistry.tar.gz -C /usr/local/bin/ crane && rm go-containerregistry.tar.gz && \
    curl -LO https://github.com/sigstore/cosign/releases/download/v${COSIGN_VERSION}/cosign-linux-amd64 && \
    chmod +x cosign-linux-amd64 && sudo mv cosign-linux-amd64 /usr/local/bin/cosign && \
    sudo bash -c "curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin v${SYFT_VERSION}" && \
    curl -LO "https://github.com/oras-project/oras/releases/download/v${ORAS_VERSION}/oras_${ORAS_VERSION}_linux_amd64.tar.gz" && \
    mkdir -p oras-install && \
    tar -zxf oras_${ORAS_VERSION}_*.tar.gz -C oras-install/ && \
    sudo mv oras-install/oras /usr/local/bin/ && \
    rm -rf oras_${ORAS_VERSION}_*.tar.gz oras-install/

USER circleci
