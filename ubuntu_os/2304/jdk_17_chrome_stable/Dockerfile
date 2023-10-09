FROM ubuntu:23.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y curl git zip unzip

# jdk 17 maven
RUN apt-get install openjdk-17-jdk -y
RUN apt-get install maven -y

# https://googlechromelabs.github.io/chrome-for-testing/
# chrome chrome_driver

# 获取当前最新的 chrome 和 chrome_driver 版本号
RUN CHROME_VERSION=$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE) && \
    echo "CHROME_VERSION: $CHROME_VERSION" && \
    curl -sS -o /tmp/chrome.deb https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_$CHROME_VERSION-1_amd64.deb && \
    curl -sS -o /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/$CHROME_VERSION/chromedriver_linux64.zip
RUN apt-get install -y /tmp/chrome.deb
RUN unzip /tmp/chromedriver.zip -d /usr/local/share/
RUN chmod +x /usr/local/share/chromedriver
RUN ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
RUN ln -s /usr/local/share/chromedriver /usr/bin/chromedriver
RUN rm /tmp/chrome.deb && \
    rm /tmp/chromedriver.zip

RUN mkdir -p /data/marketcenter.java.pandora/chromedriver/linux64
RUN ln -s /usr/local/share/chromedriver /data/marketcenter.java.pandora/chromedriver/linux64/chromedriver

CMD ["/bin/bash"]