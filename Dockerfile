FROM ubuntu:16.04

# Install Ruby.
RUN \
    apt-get update && \
    apt-get install -y ruby-dev && \
    apt-get install -y build-essential && \
    apt-get install -y curl && \
    apt-get install -y libxi6 libgconf-2-4

RUN gem install selenium-webdriver

ADD . /app
WORKDIR /app

RUN cd /app
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
RUN echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN apt-get -y update
RUN apt-get -y install google-chrome-stable


RUN curl https://chromedriver.storage.googleapis.com/2.45/chromedriver_linux64.zip -L -o chromdriver.zip
RUN unzip chromdriver.zip -d chromedriver
ENV PATH="/app/chromedriver:${PATH}"

CMD ["ruby", "check_nas_system_info.rb"]