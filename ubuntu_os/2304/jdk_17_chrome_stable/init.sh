#!/bin/bash
set -e # 出现错误则退出
set -x # 打印执行的命令

# 构建 DOCKERFILE
docker build -t ubuntu-os-2304-jdk_17_chrome_stable . -f Dockerfile

# 构建容器
docker rm -f ubuntu-os-2304-jdk_17_chrome_stable
docker run -itd --name ubuntu-os-2304-jdk_17_chrome_stable ubuntu-os-2304-jdk_17_chrome_stable:latest /bin/bash

# 提交镜像
docker commit ubuntu-os-2304-jdk_17_chrome_stable ubuntu-os-2304-jdk_17_chrome_stable:latest

docker exec ubuntu-os-2304-jdk_17_chrome_stable java -version
docker exec ubuntu-os-2304-jdk_17_chrome_stable mvn -version

docker exec ubuntu-os-2304-jdk_17_chrome_stable google-chrome --version
docker exec ubuntu-os-2304-jdk_17_chrome_stable chromedriver --version

# 上传镜像
docker tag ubuntu-os-2304-jdk_17_chrome_stable:latest registry.cn-shanghai.aliyuncs.com/snewbie/ubuntu-os-2304-jdk_17_chrome_stable:0.0.1