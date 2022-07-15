FROM ubuntu:jammy

# install repo tools
RUN apt-get update && apt-get install -y apt-transport-https curl software-properties-common wget

# install yarn repo
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# install required tools
RUN apt-get update \
  && apt-get install -y \
    bash \
    build-essential \
    chromium-browser \
    docker.io \
    jq \
    yarn \
    zip

# install pipenv
RUN apt-get install -y libssl-dev libffi-dev python-dev \
  && pip install pipenv

# cleanup now everything has finished
RUN apt-get autoremove && apt-get clean

# runtime config
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV NVM_DIR=/root/.nvm

# NVM install
RUN mkdir -p ${NVM_DIR}
RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh  | bash
RUN cp ${NVM_DIR}/nvm.sh /usr/bin/nvm.sh && echo ". nvm.sh --no-use" >> /root/.bashrc

CMD "bash" "-c" ". nvm.sh --no-use && nvm install \$(<.nvmrc) && ./build.sh"
