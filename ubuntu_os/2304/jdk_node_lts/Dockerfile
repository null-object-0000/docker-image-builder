FROM ubuntu:23.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y curl git zip unzip

# https://sdkman.io/
RUN curl -s "https://get.sdkman.io" | bash
RUN source $HOME/.sdkman/bin/sdkman-init.sh && \
    sdk install java && \
    sdk install maven

# https://github.com/nvm-sh/nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
RUN source $HOME/.nvm/nvm.sh && \
    nvm install --lts && \
    nvm use --lts && \
    npm install -g npm yarn pnpm

CMD ["/bin/bash"]