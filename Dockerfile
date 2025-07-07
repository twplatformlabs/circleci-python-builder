FROM twdps/circleci-base-image:alpine-stable

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

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# Configured for automatic, monthly build using current package repository release versions.
# Pin downstream executor builds to specific OS and package versions using YYYY.MM tag.
# hadolint ignore=DL3004,SC3057
RUN sudo apk add --no-cache \
             python3\
             python3-dev \
             nodejs-current \
             npm \
             libffi-dev  && \
    sudo rm /usr/lib/python3.12/EXTERNALLY-MANAGED && \
    sudo python3 -m ensurepip && \
    sudo rm -r /usr/lib/python*/ensurepip && \
    sudo pip3 install --upgrade pip && \
    if [ ! -e /usr/bin/pip ]; then sudo ln -s /usr/bin/pip3 /usr/bin/pip ; fi && \
    sudo ln -s /usr/bin/pydoc3 /usr/bin/pydoc && \
    sudo pip install \
         setuptools \
         setuptools_scm \
         hatch \
         moto \
         wheel \
         build \
         twine \
         pipenv \
         pylint \
         pytest \
         pytest-cov \
         coverage \
         invoke \
         requests \
         jinja2 && \
    sudo npm install -g \
             snyk \
             bats && \
    download_url=$(curl -s "https://api.github.com/repos/hadolint/hadolint/releases/latest" | jq -r ".assets[] | select(.name == \"hadolint-Linux-x86_64\") | .browser_download_url") && \
    curl -LO "${download_url}" && \
    chmod +x hadolint-Linux-x86_64 && sudo mv hadolint-Linux-x86_64 /usr/local/bin/hadolint && \
    download_url=$(curl -s "https://api.github.com/repos/sigstore/cosign/releases/latest" | jq -r ".assets[] | select(.name == \"cosign-linux-amd64\") | .browser_download_url") && \
    curl -LO "${download_url}" && \
    chmod +x cosign-linux-amd64 && sudo mv cosign-linux-amd64 /usr/local/bin/cosign && \
    curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sudo sh -s -- -b /usr/local/bin && \
    contains_url=$(curl -s "https://api.github.com/repos/oras-project/oras/releases/latest" | jq -r ".assets[] | select(.name | contains(\"_linux_amd64.tar.gz.asc\")) | .browser_download_url") && \
    download_url="${contains_url::-4}" && curl -L -o oras.tar.gz "${download_url}" && \
    mkdir -p oras-install && \
    tar -zxf oras.tar.gz -C oras-install/ && \
    sudo mv oras-install/oras /usr/local/bin/ && \
    rm -rf ./oras.tar.gz oras-install/ && \
    current_version=$(curl -s "https://api.github.com/repos/google/go-containerregistry/releases/latest" | jq -r '.tag_name') && \
    curl -sL "https://github.com/google/go-containerregistry/releases/download/${current_version}/go-containerregistry_Linux_x86_64.tar.gz" > go-containerregistry.tar.gz && \
    sudo bash -c "tar -zxvf go-containerregistry.tar.gz -C /usr/local/bin/ crane"

USER circleci
