#!/bin/bash
set -e # 出现错误则退出
set -x # 打印执行的命令

# 构建 DOCKERFILE
docker build -t ubuntu-os-2304-jdk_8_node_16_chrome_stable . -f Dockerfile

# 构建容器
docker rm -f ubuntu-os-2304-jdk_8_node_16_chrome_stable
docker run -itd --name ubuntu-os-2304-jdk_8_node_16_chrome_stable ubuntu-os-2304-jdk_8_node_16_chrome_stable:latest /bin/bash

# 提交镜像
docker commit ubuntu-os-2304-jdk_8_node_16_chrome_stable ubuntu-os-2304-jdk_8_node_16_chrome_stable:latest

docker exec ubuntu-os-2304-jdk_8_node_16_chrome_stable /bin/bash -c 'source $HOME/.sdkman/bin/sdkman-init.sh && sdk version'
docker exec ubuntu-os-2304-jdk_8_node_16_chrome_stable /bin/bash -c 'source $HOME/.sdkman/bin/sdkman-init.sh && java -version'
docker exec ubuntu-os-2304-jdk_8_node_16_chrome_stable /bin/bash -c 'source $HOME/.sdkman/bin/sdkman-init.sh && mvn -version'

docker exec ubuntu-os-2304-jdk_8_node_16_chrome_stable /bin/bash -c 'source $HOME/.nvm/nvm.sh && nvm --version'
docker exec ubuntu-os-2304-jdk_8_node_16_chrome_stable /bin/bash -c 'source $HOME/.nvm/nvm.sh && node -v'
docker exec ubuntu-os-2304-jdk_8_node_16_chrome_stable /bin/bash -c 'source $HOME/.nvm/nvm.sh && npm -v'
docker exec ubuntu-os-2304-jdk_8_node_16_chrome_stable /bin/bash -c 'source $HOME/.nvm/nvm.sh && yarn -v'
docker exec ubuntu-os-2304-jdk_8_node_16_chrome_stable /bin/bash -c 'source $HOME/.nvm/nvm.sh && pnpm -v'

docker exec ubuntu-os-2304-jdk_8_node_16_chrome_stable /bin/bash -c 'google-chrome --version'
docker exec ubuntu-os-2304-jdk_8_node_16_chrome_stable /bin/bash -c 'chromedriver --version'

# 上传镜像
docker tag ubuntu-os-2304-jdk_8_node_16_chrome_stable:latest registry.cn-shanghai.aliyuncs.com/snewbie/ubuntu-os-2304-jdk_8_node_16_chrome_stable:0.0.1