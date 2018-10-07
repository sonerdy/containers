FROM ruby:2.3.6

RUN apt-get update
RUN apt-get install -y zip unzip

# Install Oracle Instant Client
RUN mkdir /oracle_instant_client
WORKDIR /oracle_instant_client
ADD instantclient-basiclite-linux.x64-18.3.0.0.0dbru.zip instantclient-basiclite-linux.x64-18.3.0.0.0dbru.zip
ADD instantclient-sdk-linux.x64-18.3.0.0.0dbru.zip instantclient-sdk-linux.x64-18.3.0.0.0dbru.zip
RUN unzip instantclient-basiclite-linux.x64-18.3.0.0.0dbru.zip
RUN unzip instantclient-sdk-linux.x64-18.3.0.0.0dbru.zip
RUN apt-get install -y libaio1
RUN sh -c "echo /oracle_instant_client/instantclient_18_3 > /etc/ld.so.conf.d/oracle-instantclient.conf"
RUN ldconfig
ENV PATH="/oracle_instant_client/instantclient_18_3:${PATH}"

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

# Install yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

RUN mkdir /app
WORKDIR /app
